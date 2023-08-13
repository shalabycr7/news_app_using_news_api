import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_wave/data/models/all_news/all_news.dart';
import 'package:news_wave/shared/snackbar.dart';

class AllNewsRepo {
  Future<AllNews?> getAllNews(
      {required String? text, required BuildContext context}) async {
    try {
      var response = await http.get(Uri.parse(
          "https://newsapi.org/v2/everything?q=$text&sortBy=popularity&apiKey=00a02bd4f9b34cf3bb0ee900a4cc1f5b"));
      Map<String, dynamic> decodedresponse = json.decode(response.body);
      if (response.statusCode == 200) {
        AllNews data = AllNews.fromJson(decodedresponse);
        return data;
      } else {
        showErrorSnackbar(context, "Request failed");
        return null;
      }
    } catch (error) {
      showErrorSnackbar(context, "Couldn't fetch the data");
      return null;
    }
  }

 
}
