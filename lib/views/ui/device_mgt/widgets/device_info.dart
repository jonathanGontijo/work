import 'package:flutter/material.dart';
import 'package:work/views/common/custom_outline_btn.dart';
import 'package:work/views/common/exports.dart';
import 'package:work/views/common/height_spacer.dart';
import 'package:work/views/ui/mainscreen.dart';

class DeviceInfo extends StatelessWidget {
  const DeviceInfo(
      {super.key,
      required this.location,
      required this.device,
      required this.platform,
      required this.date,
      required this.ipAdress});

  final String location;
  final String device;
  final String platform;
  final String date;
  final String ipAdress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReusableText(
          text: platform,
          style: appstyle(22, Color(kDark.value), FontWeight.bold),
        ),
        ReusableText(
          text: device,
          style: appstyle(22, Color(kDark.value), FontWeight.bold),
        ),
        HeightSpacer(size: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReusableText(
                  text: date,
                  style: appstyle(16, Color(kDarkGrey.value), FontWeight.w400),
                ),
                ReusableText(
                  text: ipAdress,
                  style: appstyle(16, Color(kDarkGrey.value), FontWeight.w400),
                ),
              ],
            ),
            CustomOutlineBtn(
              text: "Sign Out",
              color: Color(kOrange.value),
              height: height * 0.05,
              width: width * 0.3,
            )
          ],
        )
      ],
    );
  }
}
