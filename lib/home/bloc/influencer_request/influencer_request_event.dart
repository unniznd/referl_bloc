abstract class InfluencerRequestEvent {}

class FetchInfluencerRequest extends InfluencerRequestEvent {}

class SetProfileInfluencerRequest extends InfluencerRequestEvent {
  final bool isProfile;
  final int index;
  SetProfileInfluencerRequest(this.isProfile, this.index);
}

class AcceptInfluencerRequest extends InfluencerRequestEvent {
  final int id, index;
  AcceptInfluencerRequest(this.id, this.index);
}

class RejectInfluencerRequest extends InfluencerRequestEvent {
  final int id, index;
  RejectInfluencerRequest(this.id, this.index);
}
