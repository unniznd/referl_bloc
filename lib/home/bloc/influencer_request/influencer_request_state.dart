import 'package:referl/home/model/influencer_request_model.dart';

abstract class InfluencerRequestState {
  get influencerRequestModel => null;
}

class InfluencerRequestInitial extends InfluencerRequestState {}

class InfluencerRequestLoading extends InfluencerRequestState {}

class InfluencerRequestLoaded extends InfluencerRequestState {
  @override
  final InfluencerRequestModel influencerRequestModel;
  InfluencerRequestLoaded(this.influencerRequestModel);
}

class InfluencerRequestError extends InfluencerRequestState {
  String? error;
  InfluencerRequestError(this.error);
}

class InfluencerRequestAccepted extends InfluencerRequestState {}

class InfluencerRequestAcceptFailed extends InfluencerRequestState {}

class InfluencerRequestRejected extends InfluencerRequestState {}

class InfluencerRequestRejectFailed extends InfluencerRequestState {}
