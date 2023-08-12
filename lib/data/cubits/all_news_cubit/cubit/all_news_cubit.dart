import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:news_wave/data/models/all_news/all_news.dart';
import 'package:news_wave/data/repositories/all_news_repo.dart';

part 'all_news_state.dart';

class AllNewsCubit extends Cubit<AllNewsState> {
  AllNewsCubit() : super(AllNewsInitial());
  getAllNews(String? text) {
    emit(AllNewsLoading());
    AllNewsRepo().getAllNews(text: text).then((value) {
      if (value != null) {
        emit(AllNewsSuccess(finalData: value));
      } else {
        emit(AllNewsError());
      }
    });
  }
}
