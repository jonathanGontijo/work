import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:work/controllers/login_provider.dart';
import 'package:work/controllers/onboarding_provider.dart';
import 'package:work/controllers/zoom_provider.dart';
import 'package:work/views/common/app_bar.dart';
import 'package:work/views/common/drawer/drawer_widget.dart';
import 'package:work/views/common/exports.dart';
import 'package:work/views/common/height_spacer.dart';
import 'package:work/views/ui/device_mgt/widgets/device_info.dart';
import 'package:work/views/ui/onboarding/onboarding_screen.dart';

class DeviceManagement extends StatelessWidget {
  const DeviceManagement({super.key});

  @override
  Widget build(BuildContext context) {
    var zoomNotifier = Provider.of<ZoomNotifier>(context);
    var onBoardNotifier = Provider.of<OnBoardNotifier>(context);
    String date = DateTime.now().toString();
    var loginDate = date.substring(0, 11);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: 'Devices Management',
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: DrawerWidget(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeightSpacer(size: 50),
                  Text(
                    "You are logged into your account on these devices",
                    style: appstyle(16, Color(kDark.value), FontWeight.normal),
                  ),
                  HeightSpacer(size: 50),
                  DeviceInfo(
                    location: "Contagem",
                    device: "Mac Mini",
                    platform: "Apple Webkit",
                    date: loginDate,
                    ipAdress: "10.0.12.000",
                  ),
                  HeightSpacer(size: 50),
                  DeviceInfo(
                    location: "Contagem",
                    device: "Iphone 16 pro",
                    platform: "Apple Webkit",
                    date: loginDate,
                    ipAdress: "10.0.12.000",
                  ),
                  HeightSpacer(size: 50),
                  DeviceInfo(
                    location: "Contagem",
                    device: "Apple vision",
                    platform: "Apple Webkit",
                    date: loginDate,
                    ipAdress: "10.0.12.000",
                  ),
                  HeightSpacer(size: 20),
                  Consumer<LoginNotifier>(
                    builder: (context, loginNotifier, child) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            zoomNotifier.currentIndex = 0;
                            onBoardNotifier.isLastPage = false;
                            Get.to(() => const OnBoardingScreen());
                          },
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: ReusableText(
                              text: "Sign Out of all devices",
                              style: appstyle(
                                  16, Color(kOrange.value), FontWeight.w600),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
