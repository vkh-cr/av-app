class HelloWorldResponse {
  final String message;

  HelloWorldResponse({required this.message});

  factory HelloWorldResponse.fromJson(Map<String, dynamic> json) {
    return HelloWorldResponse(message: json['message']);
  }
}