import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:referl/dashboard/bloc/dashboard_summary/dashboard_summary_event.dart';
import 'package:referl/dashboard/bloc/dashboard_summary/dashboard_summary_state.dart';
import 'package:referl/dashboard/repo/dashboard_repo.dart';

class DashBoardSummaryBloc
    extends Bloc<DashBoardSummaryEvent, DashBoardSummaryState> {
  DashBoardSummaryBloc() : super(DashBoardSummaryInitial()) {
    final DashBoardRepo apiRepo = DashBoardRepo();
    on<FetchDashBoardSummary>(
      (event, emit) async {
        emit(DashBoardSummaryLoading());

        try {
          final res = await apiRepo.fetchDashBoardSummary();

          emit(DashBoardSummaryLoaded(res));

          if (res.errorMsg != null) {
            if (res.errorMsg == "LOGGED_OUT") {
              emit(DashBoardTokenExpired());
            } else {
              emit(DashBoardSummaryError(res.errorMsg));
            }
          }
        } catch (e) {
          emit(DashBoardSummaryError("Failed to fetch data"));
        }
      },
    );
  }
}
