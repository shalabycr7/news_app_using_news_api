import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:news_app/data/models/all_news/all_news.dart';
import 'package:news_app/data/repositories/all_news_repo.dart';

part 'all_news_state.dart';

class AllNewsCubit extends Cubit<AllNewsState> {
  AllNewsCubit() : super(AllNewsInitial());
  getAllNews() {
    emit(AllNewsLoading());
    AllNewsRepo().getAllNews().then((value) {
      if (value != null) {
        emit(AllNewsSuccess(finalData: value));
      } else {
        emit(AllNewsError());
      }
    });
  }
}
