import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:news_wave/data/models/all_news/all_news.dart';

@immutable
abstract class AllNewsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AllNewsInitial extends AllNewsState {}

class AllNewsLoading extends AllNewsState {}

class AllNewsSuccess extends AllNewsState {
  final AllNews finalData;
  AllNewsSuccess({required this.finalData});

  @override
  List<Object?> get props => [finalData];
}

class AllNewsError extends AllNewsState {}
