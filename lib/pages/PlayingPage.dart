import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:timelines/timelines.dart';

import '../services/ApiClient.dart';

class PlayingPage extends StatefulWidget {
  const PlayingPage({Key? key}) : super(key: key);

  @override
  _PlayingPageState createState() => _PlayingPageState();
}

class _PlayingPageState extends State<PlayingPage> {
  String infoText = "Info";

  // https://flutterawesome.com/a-powerful-easy-to-use-timeline-package-for-flutter/


  

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test timeline'),
      ),
    body: FixedTimeline.tileBuilder(
      builder: TimelineTileBuilder.connectedFromStyle(
      contentsAlign: ContentsAlign.basic,
      //oppositeContentsBuilder: (context, index) => Padding(
      //padding: const EdgeInsets.all(8.0),
      //child: Text('opposite\ncontents'),
    //),
      contentsBuilder: (context, index) => Card(
      child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('Contents'),
  ),
  ),
    connectorStyleBuilder: (context, index) => ConnectorStyle.solidLine,
    indicatorStyleBuilder: (context, index) => IndicatorStyle.dot,
    itemCount: 3,
  ),
  ),
    );
  }
}
// varianta s přerušovanou čarou

//@override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('Test timeline'),
//      ),
//    body: FixedTimeline.tileBuilder(
//      builder: TimelineTileBuilder.connectedFromStyle(
//        connectionDirection: ConnectionDirection.after,
//        connectorStyleBuilder: (context, index) {
//      return (index == 3) ? ConnectorStyle.dashedLine : ConnectorStyle.solidLine;
//    },
//      indicatorStyleBuilder: (context, index) => IndicatorStyle.dot,
//      itemExtent: 40.0,
//      itemCount: 6,
//  ),
//),
//    );
//}   
//}


// základní varianta

//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('Test timeline'),
//      ),
//      body: Timeline.tileBuilder(
//        builder: TimelineTileBuilder.fromStyle(
//          contentsAlign: ContentsAlign.alternating,
//          contentsBuilder: (context, index) => Padding(
//            padding: const EdgeInsets.all(24.0),
//            child: Text('Timeline Event $index'),
//          ),
//          itemCount: 5,
//        ),
//      ),
//    );
//  }
//}

//@override
//Widget build(BuildContext context) {
//  return Scaffold(
//    body: Column(
//      mainAxisSize: MainAxisSize.max,
//      children: <Widget> [
//        const Padding(
//            padding: EdgeInsets.all(24.0),
//            child: Text("Our playing page")),
//        Padding(
//          padding: const EdgeInsets.symmetric(vertical: 48.0),
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Column(
//                mainAxisSize: MainAxisSize.min,
//                children: <Widget>[
//                  ElevatedButton(
//                      onPressed: _callApiPressed,
//                      child: const Text('Call API!')),
//                  Text(infoText), // <-- Text
//                ],
//              ),
//            ],
//          ),
//        )],
//    ), // This trailing comma makes auto-formatting nicer for build methods.
//  );
//}
//
//
//void _callApiPressed() async{
//  var client = ApiClient();
//  try{
//    var helloWorldResponse = await client.getHelloWorld();
//    setState(() {
//      infoText = helloWorldResponse.message;
//    });
//    Fluttertoast.showToast(msg: helloWorldResponse.message);
//  }catch(e){
//    Fluttertoast.showToast(msg: "Api call error");
//  }
//}
//