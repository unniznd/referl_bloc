import 'package:referl/dashboard/model/influencer_list_model.dart';

abstract class InfluencerListState {}

class InfluencerListInitial extends InfluencerListState {}

class InfluencerListLoading extends InfluencerListState {}

class InfluencerListLoaded extends InfluencerListState {
  final InfluencerListModel influencerListModel;
  InfluencerListLoaded(this.influencerListModel);
}

class InfluencerListError extends InfluencerListState {
  final String? error;
  InfluencerListError(this.error);
}
