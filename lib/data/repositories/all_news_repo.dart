import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_wave/data/models/all_news/all_news.dart';
import 'package:news_wave/shared/snackbar.dart';

class AllNewsRepo {
  static const String _apiKey = '00a02bd4f9b34cf3bb0ee900a4cc1f5b';
  static const String _baseUrl = 'https://newsapi.org/v2/everything';

  Future<AllNews?> getAllNews({required String? text, required BuildContext context}) async {
    try {
      final Uri uri = Uri.parse('$_baseUrl?q=$text&sortBy=popularity&apiKey=$_apiKey');
      final http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedResponse = json.decode(response.body);
        final AllNews data = AllNews.fromJson(decodedResponse);
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
