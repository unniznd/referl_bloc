import 'package:referl/home/api/home_api.dart';
import 'package:referl/home/model/home_summary_model.dart';
import 'package:referl/home/model/influencer_request_model.dart';

class HomeRepo {
  final HomeApiProvider _apiProvider = HomeApiProvider();

  Future<HomeSummaryModel> fetchMonthlySummary() =>
      _apiProvider.fetchMonthlySummary();

  Future<InfluencerRequestModel> fetchInfluencerRequest() =>
      _apiProvider.fetchInfluencerRequest();

  Future<String> acceptInfluencerRequest(int id) =>
      _apiProvider.acceptInfluencerRequest(id);

  Future<String> rejectInfluencerRequest(int id) =>
      _apiProvider.rejectInfluencerRequest(id);

  Future<String> updateYourOffer(int payout, int validity) =>
      _apiProvider.updateYourOffer(payout, validity);
}
