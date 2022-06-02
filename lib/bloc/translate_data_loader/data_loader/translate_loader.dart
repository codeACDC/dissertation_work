import 'package:http/http.dart' as http;
import 'dart:convert';

class TranslateLoader {
  final String url;

  const TranslateLoader({
    required this.url,
  });

  Future<dynamic> translateLoader() async {
    http.Response response;
    response = await http.get(Uri.parse(url));
    if(response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    else {
      return response.statusCode;
    }
  }
}
