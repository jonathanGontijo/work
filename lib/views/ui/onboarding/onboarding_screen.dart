import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:work/controllers/exports.dart';
import 'package:work/views/common/exports.dart';
import 'package:work/views/ui/onboarding/widgets/page_one.dart';
import 'package:work/views/ui/onboarding/widgets/page_three.dart';
import 'package:work/views/ui/onboarding/widgets/page_two.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController pageController = PageController();
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<OnBoardNotifier>(
        builder: (context, onBoardNotifier, child) {
          return Stack(
            children: [
              PageView(
                physics: onBoardNotifier.isLastPage
                    ? const NeverScrollableScrollPhysics()
                    : const AlwaysScrollableScrollPhysics(),
                controller: pageController,
                onPageChanged: (page) {
                  onBoardNotifier.isLastPage = page == 2;
                },
                children: [
                  PageOne(),
                  PageTwo(),
                  PageThree(),
                ],
              ),
              Positioned(
                bottom: height * 0.12,
                left: 0,
                right: 0,
                child: onBoardNotifier.isLastPage
                    ? SizedBox.shrink()
                    : Center(
                        child: SmoothPageIndicator(
                          controller: pageController,
                          count: 3,
                          effect: WormEffect(
                              dotHeight: 12,
                              dotWidth: 12,
                              spacing: 10,
                              dotColor: Color(kDarkGrey.value).withOpacity(0.5),
                              activeDotColor: Color(kLight.value)),
                        ),
                      ),
              ),
              Positioned(
                  child: onBoardNotifier.isLastPage
                      ? SizedBox.fromSize()
                      : Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 20.h,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    pageController.jumpToPage(2);
                                  },
                                  child: ReusableText(
                                      text: "Skip",
                                      style: appstyle(16, Color(kLight.value),
                                          FontWeight.w500)),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    pageController.nextPage(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.ease);
                                  },
                                  child: ReusableText(
                                      text: "Next",
                                      style: appstyle(16, Color(kLight.value),
                                          FontWeight.w500)),
                                ),
                              ],
                            ),
                          ),
                        ))
            ],
          );
        },
      ),
    );
  }
}
