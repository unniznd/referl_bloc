import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class InfluencerListTile extends StatelessWidget {
  InfluencerListTile({
    super.key,
    required this.profilePic,
    required this.name,
    required this.totalReferal,
    required this.totalEarning,
    required this.social,
  });

  final String profilePic;
  final String name;
  final int totalReferal;
  final int totalEarning;
  final Map social;

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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.only(left: 10),
      margin: const EdgeInsets.only(top: 2, bottom: 10),
      color: Colors.transparent, //main bg color
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 0,
            child: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(profilePic),
            ),
          ),
          Expanded(
            flex: 0,
            child: Container(
              margin: const EdgeInsets.only(left: 5),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      name,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        // fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const HeroIcon(
                        HeroIcons.user,
                        color: Colors.green,
                        size: 18,
                        style: HeroIconStyle.solid,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        totalReferal.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      const Text(
                        "\$",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(8, 183, 119, 1),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        totalEarning.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: const EdgeInsets.only(left: 70),
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
                  for (var key in social.keys)
                    IconButton(
                      onPressed: () async {
                        var url = Uri.parse(social[key]);
                        if (await canLaunchUrl(url)) {
                          await launchUrl(
                            url,
                            mode: LaunchMode.externalNonBrowserApplication,
                          );
                        } else {
                          throw "Could not launch $url";
                        }
                      },
                      icon: FaIcon(colorSocial[key]?[0]),
                      color: colorSocial[key]?[1],
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

// ignore: non_constant_identifier_names
Widget influencersListTile({
  required var profilePic,
  required var name,
  required var totalReferal,
  required var totalEarning,
  required var social,
}) {
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
    padding: const EdgeInsets.only(left: 10),
    margin: const EdgeInsets.only(top: 2, bottom: 10),
    color: Colors.transparent, //main bg color
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 0,
          child: CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(profilePic),
          ),
        ),
        Expanded(
          flex: 0,
          child: Container(
            margin: const EdgeInsets.only(left: 5),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    name,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      // fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                Row(
                  children: [
                    const HeroIcon(
                      HeroIcons.user,
                      color: Colors.green,
                      size: 18,
                      style: HeroIconStyle.solid,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      totalReferal.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    const Text(
                      "\$",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(8, 183, 119, 1),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      totalEarning.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            margin: const EdgeInsets.only(left: 70),
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
                for (var key in social.keys)
                  IconButton(
                    onPressed: () async {
                      var url = Uri.parse(social[key]);
                      if (await canLaunchUrl(url)) {
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalNonBrowserApplication,
                        );
                      } else {
                        throw "Could not launch $url";
                      }
                    },
                    icon: FaIcon(colorSocial[key]?[0]),
                    color: colorSocial[key]?[1],
                  )
              ],
            ),
          ),
        )
      ],
    ),
  );
}
