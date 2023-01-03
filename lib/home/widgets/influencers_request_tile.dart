import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:referl/home/model/influencer_request_model.dart';
import 'package:url_launcher/url_launcher.dart';

class InfluencersRequestTile extends StatelessWidget {
  const InfluencersRequestTile({
    super.key,
    required this.influencerRequest,
    required this.onAccept,
    required this.onReject,
    required this.width,
    required this.showProfile,
    required this.showSocial,
  });

  final InfluencerRequest influencerRequest;
  final void Function() onAccept;
  final void Function() onReject;
  final void Function() showSocial;
  final void Function() showProfile;

  final double width;

  @override
  Widget build(BuildContext context) {
    Map<String, List> colorSocial = {
      "instagram": [
        FontAwesomeIcons.instagram,
        Colors.pink,
      ],
      "whatsapp": [
        FontAwesomeIcons.whatsapp,
        Colors.green,
      ],
      "twitter": [
        FontAwesomeIcons.twitter,
        Colors.blue,
      ],
      "youtube": [
        FontAwesomeIcons.youtube,
        Colors.red,
      ],
    };
    return Container(
      height: 56,
      padding: const EdgeInsets.only(left: 5),
      // margin: const EdgeInsets.only(top: 2, bottom: 10),
      color: Colors.transparent, //main bg color
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 0,
            child: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(influencerRequest.profilePic),
            ),
          ),
          Expanded(
            flex: 0,
            child: Container(
              margin: const EdgeInsets.only(left: 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  influencerRequest.name,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    // fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          if (influencerRequest.isProfile)
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(
                  left: width * 0.12,
                ),
                height: 100,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(234, 244, 225, 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (var key in influencerRequest.social.keys)
                      IconButton(
                        onPressed: () async {
                          var url = Uri.parse(influencerRequest.social[key]);
                          if (await canLaunchUrl(url)) {
                            await launchUrl(
                              url,
                              mode: LaunchMode.externalNonBrowserApplication,
                            );
                          } else {
                            throw "Could not launch $url";
                          }
                          // can't launch url, there is some error
                        },
                        icon: FaIcon(colorSocial[key]?[0]),
                        color: colorSocial[key]?[1],
                      ),
                    GestureDetector(
                      onTap: showProfile,
                      child: const HeroIcon(
                        HeroIcons.chevronRight,
                        style: HeroIconStyle.outline,
                      ),
                    )
                  ],
                ),
              ),
            ),
          if (!influencerRequest.isProfile)
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(left: width * 0.25),
                height: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: onAccept,
                      child: const HeroIcon(
                        HeroIcons.checkCircle,
                        color: Colors.green,
                        size: 30,
                      ),
                    ),
                    GestureDetector(
                      onTap: onReject,
                      child: const HeroIcon(
                        HeroIcons.xCircle,
                        color: Colors.green,
                        size: 30,
                      ),
                    ),
                    GestureDetector(
                      onTap: showSocial,
                      child: const HeroIcon(
                        HeroIcons.userCircle,
                        color: Colors.green,
                        size: 30,
                      ),
                    )
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
