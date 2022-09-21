import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projects/api/model/NewsResponse.dart';
import 'package:projects/api/model/SourcesResponse.dart';

class ApiManager {
  static const String BASE_URL = 'newsapi.org',
      API_KEY = 'f95ff82b38b44ec783ab97ea78369999';

  static Future<SourcesResponse> getNewsSources(String catId) async {
    var uri = Uri.https(BASE_URL, '/v2/top-headlines/sources',
        {'apiKey': API_KEY, 'category': catId});
    var response = await http.get(uri);
    var json = jsonDecode(response.body);
    SourcesResponse sourcesResponse = SourcesResponse.fromJson(json);
    return sourcesResponse;
  }

  static Future<NewsResponse> getNews({String? sourceId, String? query}) async {
    var uri = Uri.https(BASE_URL, '/v2/everything',
        {'apiKey': API_KEY, 'sources': sourceId, 'q': query});
    var response = await http.get(uri);
    var json = jsonDecode(response.body);
    NewsResponse newsResponse = NewsResponse.fromJson(json);
    return newsResponse;
  }
}
