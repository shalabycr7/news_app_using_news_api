part of 'all_news_cubit.dart';

@immutable
abstract class AllNewsState {}

class AllNewsInitial extends AllNewsState {}

class AllNewsLoading extends AllNewsState {}

class AllNewsSuccess extends AllNewsState {
  final AllNews finalData;
  AllNewsSuccess({required this.finalData});
}

class AllNewsError extends AllNewsState {}
