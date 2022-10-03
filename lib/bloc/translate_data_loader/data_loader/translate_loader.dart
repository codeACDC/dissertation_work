import 'dart:convert';

import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;

class TranslateLoader {
  final String url;

  const TranslateLoader({
    required this.url,
  });

  Future<List> translateLoader() async {
    List siteModelList = [];
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if(response.statusCode == 200){
      final dom.Document html = dom.Document.html(response.body);

      final titleList = html
          .querySelectorAll('article> '
              'header > h1> a > span')
          .map((e) => e.innerHtml.trim())
          .toList();

      final titleContentSource = html
          .querySelectorAll('article> header > span')
          .map((e) => e.text.trim())
          .toList();

      final titleContent = html
          .querySelectorAll('article div.pl-1')
          .map((e) => e.text.toString().trim())
          .toList();

      print(titleContent.length);

      siteModelList.add(titleList);
      siteModelList.add(titleContentSource);
      siteModelList.add(titleContent);

    }
    return siteModelList;

  }
}
