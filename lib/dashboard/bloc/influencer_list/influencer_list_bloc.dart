import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:referl/dashboard/repo/dashboard_repo.dart';
import 'package:referl/dashboard/bloc/influencer_list/influencer_list_event.dart';
import 'package:referl/dashboard/bloc/influencer_list/influencer_list_state.dart';

class InfluencerListBloc
    extends Bloc<InfluencerListEvent, InfluencerListState> {
  InfluencerListBloc() : super(InfluencerListInitial()) {
    final DashBoardRepo apiRepo = DashBoardRepo();
    on<FetchActiveInfluencer>(
      (event, emit) async {
        emit(InfluencerListLoading());
        try {
          final res = await apiRepo.fetchActiveInfluencer();

          emit(InfluencerListLoaded(res));

          if (res.errorMsg != null) {
            emit(InfluencerListError(res.errorMsg));
          }
        } catch (e) {
          emit(InfluencerListError("Failed to fetch data"));
        }
      },
    );
  }
}
