class InfluencerRequest {
  int id;
  String name,
      profilePic =
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzHQv_th9wq3ivQ1CVk7UZRxhbPq64oQrg5Q&usqp=CAU";
  Map social;
  bool isProfile;
  InfluencerRequest({
    required this.id,
    required this.name,
    // required this.profilePic,
    required this.social,
    required this.isProfile,
  });
}

class InfluencerRequestModel {
  List<InfluencerRequest>? requests;
  String? errorMsg;

  InfluencerRequestModel.fromJson(Map<String, dynamic> json) {
    requests = [];
    for (int i = 0; i < json["requests"].length; i++) {
      InfluencerRequest temp = InfluencerRequest(
        id: json["requests"][i]["id"],
        name: json["requests"][i]["influencer_name"],
        social: json["requests"][i]["social"],
        // profilePic: json["requests"][i]["profile_pic"],
        isProfile: false,
      );
      requests!.add(temp);
    }
  }

  InfluencerRequestModel.withError(String error) : errorMsg = error;
}
