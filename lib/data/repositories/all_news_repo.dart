import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/data/models/all_news/all_news.dart';

class AllNewsRepo {
  Future<AllNews?> getAllNews() async {
    try {
      var response = await http.get(Uri.parse(
          "https://newsapi.org/v2/everything?q=apple&from=2023-07-24&to=2023-07-24&sortBy=popularity&apiKey=00a02bd4f9b34cf3bb0ee900a4cc1f5b"));
      Map<String, dynamic> decodedresponse = json.decode(response.body);
      if (response.statusCode == 200) {
        AllNews data = AllNews.fromJson(decodedresponse);
        return data;
      } else {
        print("request failed");
        return null;
      }
    } catch (error) {
      print("can not fetch the data:$error");
      return null;
    }
  }
}
