class InfluencerList {
  int id;
  String name;
  String profilePic =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzHQv_th9wq3ivQ1CVk7UZRxhbPq64oQrg5Q&usqp=CAU";
  int totalReferal;
  int totalEarning;
  Map<String, dynamic> social;

  InfluencerList({
    required this.id,
    required this.name,
    // required this.profilePic,
    required this.totalReferal,
    required this.totalEarning,
    required this.social,
  });
}

class InfluencerListModel {
  int? count;
  List<InfluencerList>? active;
  String? errorMsg;

  InfluencerListModel.fromJson(Map<String, dynamic> json) {
    count = json["count"];
    active = [];

    for (int i = 0; i < json["active"].length; i++) {
      InfluencerList temp = InfluencerList(
        id: json["active"][i]["id"],
        name: json["active"][i]["name"],
        totalEarning: json["active"][i]["total_earning"],
        totalReferal: json["active"][i]["total_referal"],
        social: json["active"][i]["social"],
        // profilePic: json["active"][i]["profile_pic"],
      );
      active!.add(temp);
    }
  }
  InfluencerListModel.withError(String error) : errorMsg = error;
}
