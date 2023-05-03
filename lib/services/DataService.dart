import 'dart:convert';
import 'package:av_app/Models/Information.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/responses/HelloWorldResponse.dart';

class DataService {
  static final _supabase = Supabase.instance.client;
  static final _secureStorage = FlutterSecureStorage();
  static const REFRESH_TOKEN_KEY = 'refresh';

  //final String _baseUrl = "http://localhost:5001/";
  // Future<HelloWorldResponse> getHelloWorld() async{
  //   final url = Uri.parse("${_baseUrl}api/Test/hello/world");
  //   final response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     return HelloWorldResponse.fromJson((json.decode(response.body)));
  //   } else{
  //     throw Exception("status Code != 200");
  //   }
  // }

  static Future<String> getFirstProgramTitle() async {
    var programJson =
        await _supabase.from('events').select('title').limit(1).single();
    return programJson['title'].toString();
  }

  static Future<bool> tryAuthUser() async {
    if (!await _secureStorage.containsKey(key: REFRESH_TOKEN_KEY)) {
      return false;
    }
    var refresh = await _secureStorage.read(key: REFRESH_TOKEN_KEY);
    var result = await _supabase.auth.setSession(refresh.toString());
    if (result.user != null) {
      await _secureStorage.write(
          key: REFRESH_TOKEN_KEY,
          value: _supabase.auth.currentSession!.refreshToken.toString());
      return true;
    }
    return false;
  }

  static isLoggedIn() {
    return _supabase.auth.currentSession != null;
  }

  static Future<void> login(String email, String password) async {
    var data = await _supabase.auth
        .signInWithPassword(email: email, password: password);
    await _secureStorage.write(
        key: REFRESH_TOKEN_KEY, value: data.session!.refreshToken.toString());
  }

  static Future<void> logout() async {
    _secureStorage.delete(key: REFRESH_TOKEN_KEY);
    await _supabase.auth.signOut();
  }

  static Future<dynamic> getPlaces() async =>
      await _supabase.from('places').select();

  static Future<List<Information>> getAllInformation() async {
    final response = await _supabase
      .from(Information.informationTable)
      .select()
      .order('created_at', ascending: false );

    return (response as List<dynamic>)
      .map((n) => Information.fromDynamic(n))
      .toList();
  }

  static Future<void> saveInformation(Information information) async {
      await _supabase
          .from(Information.informationTable)
          .insert(information.toInsertMap());
  }

  static Future<void> deleteInformation(int informationId) async{
    await _supabase
        .from(Information.informationTable)
        .delete()
        .eq(Information.idColumn, informationId);
  }
}
