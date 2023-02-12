import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:referl/home/api/home_api.dart';
import 'package:referl/home/bloc/influencer_request/influencer_request_event.dart';
import 'package:referl/home/bloc/influencer_request/influencer_request_state.dart';
import 'package:referl/home/model/influencer_request_model.dart';

class InfluencerRequestBloc
    extends Bloc<InfluencerRequestEvent, InfluencerRequestState> {
  InfluencerRequestBloc() : super(InfluencerRequestInitial()) {
    final apiRepo = HomeApiProvider();

    on<FetchInfluencerRequest>(
      (event, emit) async {
        emit(InfluencerRequestLoading());

        try {
          final res = await apiRepo.fetchInfluencerRequest();

          emit(InfluencerRequestLoaded(res));
          if (res.errorMsg != null) {
            emit(InfluencerRequestError(res.errorMsg));
          }
        } catch (e) {
          emit(InfluencerRequestError("Failed to fetch data"));
        }
      },
    );
    on<SetProfileInfluencerRequest>(
      (event, emit) {
        if (state is InfluencerRequestLoaded) {
          (state as InfluencerRequestLoaded)
              .influencerRequestModel
              .requests!
              .cast<InfluencerRequest>()[event.index]
              .isProfile = event.isProfile;
          emit(InfluencerRequestLoaded(
              (state as InfluencerRequestLoaded).influencerRequestModel));
        }
      },
    );
    on<AcceptInfluencerRequest>(
      (event, emit) async {
        if (state is InfluencerRequestLoaded) {
          List<InfluencerRequest> temp = (state as InfluencerRequestLoaded)
              .influencerRequestModel
              .requests!
              .cast<InfluencerRequest>();

          InfluencerRequest toAccept = temp.removeAt(event.index);
          (state as InfluencerRequestLoaded).influencerRequestModel.requests =
              temp;
          var newState =
              (state as InfluencerRequestLoaded).influencerRequestModel;
          emit(
            InfluencerRequestLoaded(newState),
          );

          try {
            final res = await apiRepo.acceptInfluencerRequest(event.id);
            if (res == "OK") {
              emit(InfluencerRequestAccepted());
              emit(
                InfluencerRequestLoaded(newState),
              );
            } else {
              temp.insert(event.index, toAccept);
              (state as InfluencerRequestLoaded)
                  .influencerRequestModel
                  .requests = temp;
              var newState =
                  (state as InfluencerRequestLoaded).influencerRequestModel;
              emit(InfluencerRequestAcceptFailed());
              emit(
                InfluencerRequestLoaded(newState),
              );
            }
          } catch (e) {
            temp.insert(event.index, toAccept);
            (state as InfluencerRequestLoaded).influencerRequestModel.requests =
                temp;
            var newState =
                (state as InfluencerRequestLoaded).influencerRequestModel;
            emit(InfluencerRequestAcceptFailed());
            emit(
              InfluencerRequestLoaded(newState),
            );
          }
        }
      },
    );
    on<RejectInfluencerRequest>(
      (event, emit) async {
        if (state is InfluencerRequestLoaded) {
          List<InfluencerRequest> temp = (state as InfluencerRequestLoaded)
              .influencerRequestModel
              .requests!
              .cast<InfluencerRequest>();

          InfluencerRequest toAccept = temp.removeAt(event.index);
          (state as InfluencerRequestLoaded).influencerRequestModel.requests =
              temp;
          var newState =
              (state as InfluencerRequestLoaded).influencerRequestModel;
          emit(
            InfluencerRequestLoaded(newState),
          );

          try {
            final res = await apiRepo.rejectInfluencerRequest(event.id);
            if (res == "OK") {
              emit(InfluencerRequestRejected());
              emit(
                InfluencerRequestLoaded(newState),
              );
            } else {
              temp.insert(event.index, toAccept);
              (state as InfluencerRequestLoaded)
                  .influencerRequestModel
                  .requests = temp;
              var newState =
                  (state as InfluencerRequestLoaded).influencerRequestModel;
              emit(InfluencerRequestRejectFailed());
              emit(
                InfluencerRequestLoaded(newState),
              );
            }
          } catch (e) {
            temp.insert(event.index, toAccept);
            (state as InfluencerRequestLoaded).influencerRequestModel.requests =
                temp;
            var newState =
                (state as InfluencerRequestLoaded).influencerRequestModel;
            emit(InfluencerRequestRejectFailed());
            emit(
              InfluencerRequestLoaded(newState),
            );
          }
        }
      },
    );
  }
}
