import 'package:referl/home/model/home_summary_model.dart';

abstract class HomeSummaryState {}

class HomeSummaryInitial extends HomeSummaryState {}

class HomeSummaryLoading extends HomeSummaryState {}

class HomeSummaryLoaded extends HomeSummaryState {
  final HomeSummaryModel homeSummaryModel;
  HomeSummaryLoaded(this.homeSummaryModel);
}

class HomeSummaryError extends HomeSummaryState {
  final String? error;
  HomeSummaryError(this.error);
}

class HomeSummaryTokenExpired extends HomeSummaryState {}

class HomeSummaryUpdateFailed extends HomeSummaryState {
  final String? error;
  HomeSummaryUpdateFailed(this.error);
}
