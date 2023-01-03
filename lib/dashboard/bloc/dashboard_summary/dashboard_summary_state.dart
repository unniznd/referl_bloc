import 'package:referl/dashboard/model/dashboard_summary_model.dart';

abstract class DashBoardSummaryState {}

class DashBoardSummaryInitial extends DashBoardSummaryState {}

class DashBoardSummaryLoading extends DashBoardSummaryState {}

class DashBoardSummaryLoaded extends DashBoardSummaryState {
  final DashBoardSummaryModel dashBoardSummaryModel;
  DashBoardSummaryLoaded(this.dashBoardSummaryModel);
}

class DashBoardSummaryError extends DashBoardSummaryState {
  final String? error;
  DashBoardSummaryError(this.error);
}

class DashBoardTokenExpired extends DashBoardSummaryState {}
