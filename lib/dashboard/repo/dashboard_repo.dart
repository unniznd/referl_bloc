import 'package:referl/dashboard/api/dashboard_api.dart';
import 'package:referl/dashboard/model/dashboard_summary_model.dart';
import 'package:referl/dashboard/model/influencer_list_model.dart';

class DashBoardRepo {
  final DashBoardApiProvider _apiProvider = DashBoardApiProvider();

  Future<DashBoardSummaryModel> fetchDashBoardSummary() =>
      _apiProvider.fetchDashBoardSummary();

  Future<InfluencerListModel> fetchActiveInfluencer() =>
      _apiProvider.fetchActiveInfluencer();
}
