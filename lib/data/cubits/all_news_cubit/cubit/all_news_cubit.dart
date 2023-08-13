import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:news_wave/data/cubits/all_news_cubit/cubit/all_news_state.dart';
import 'package:news_wave/data/models/all_news/all_news.dart';
import 'package:news_wave/data/repositories/all_news_repo.dart';

class AllNewsCubit extends Cubit<AllNewsState> {
  final AllNewsRepo _allNewsRepo;

  AllNewsCubit(this._allNewsRepo) : super(AllNewsInitial());

  void getAllNews(String? text, BuildContext context) async {
    emit(AllNewsLoading());

    try {
      final AllNews? value =
          await _allNewsRepo.getAllNews(text: text, context: context);

      if (value != null) {
        emit(AllNewsSuccess(finalData: value));
      } else {
        emit(AllNewsError());
      }
    } catch (error) {
      emit(AllNewsError());
    }
  }
}
