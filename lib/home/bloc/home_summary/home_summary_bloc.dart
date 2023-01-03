import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:referl/home/bloc/home_summary/home_summary_event.dart';
import 'package:referl/home/bloc/home_summary/home_summary_state.dart';
import 'package:referl/home/model/home_summary_model.dart';
import 'package:referl/home/repo/home_repo.dart';

class HomeSummaryBloc extends Bloc<HomeSummaryEvent, HomeSummaryState> {
  HomeSummaryBloc() : super(HomeSummaryInitial()) {
    final apiRepo = HomeRepo();

    on<FetchMonthlySummary>(
      (event, emit) async {
        emit(HomeSummaryLoading());

        try {
          final res = await apiRepo.fetchMonthlySummary();
          emit(HomeSummaryLoaded(res));

          if (res.errorMsg != null) {
            if (res.errorMsg == "LOGGED_OUT") {
              emit(HomeSummaryTokenExpired());
            } else {
              emit(HomeSummaryError(res.errorMsg));
            }
          }
        } catch (e) {
          emit(HomeSummaryError("Failed to fetch data"));
        }
      },
    );
    on<UpdateYourOffer>(
      (event, emit) async {
        if (state is HomeSummaryLoaded) {
          var oldState = (state as HomeSummaryLoaded).homeSummaryModel;
          try {
            final res = await apiRepo.updateYourOffer(
              event.payout,
              event.validity,
            );

            if (res == "OK") {
              (state as HomeSummaryLoaded).homeSummaryModel.payout =
                  event.payout;
              (state as HomeSummaryLoaded).homeSummaryModel.validity =
                  event.validity;
              var newState = (state as HomeSummaryLoaded).homeSummaryModel;
              emit(HomeSummaryLoaded(newState));
            } else if (res == "FAILED") {
              emit(HomeSummaryUpdateFailed("Unexcepted Error Occured"));
            }
          } catch (e) {
            emit(HomeSummaryLoaded(oldState));
          }
        }
      },
    );
  }
}
