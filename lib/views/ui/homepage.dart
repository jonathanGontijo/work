import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:work/views/common/app_bar.dart';
import 'package:work/views/common/drawer/drawer_widget.dart';
import 'package:work/views/common/exports.dart';
import 'package:work/views/common/heading_widget.dart';
import 'package:work/views/common/height_spacer.dart';
import 'package:work/views/common/search.dart';
import 'package:work/views/common/vertical_tile.dart';
import 'package:work/views/ui/jobs/job_page.dart';
import 'package:work/views/ui/jobs/widgets/jobhorizontal_tile.dart';
import 'package:work/views/ui/search/searchpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          actions: [
            Padding(
              padding: EdgeInsets.all(12.h),
              child: CircleAvatar(
                radius: 15,
                backgroundImage: AssetImage("assets/images/user.png"),
              ),
            )
          ],
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: DrawerWidget(),
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeightSpacer(size: 10),
              Text(
                "Search \n Find & Apply",
                style: appstyle(40, Color(kDark.value), FontWeight.bold),
              ),
              HeightSpacer(size: 40),
              SearchWidget(
                onTap: () {
                  Get.to(() => SearchPage());
                },
              ),
              HeightSpacer(size: 30),
              HeadingWidget(
                text: "Popular Jobs",
                onTap: () {},
              ),
              HeightSpacer(size: 20),
              SizedBox(
                height: height * 0.28,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return JobHorizontalTile(
                      onTap: () {
                        Get.to(() => const JobPage(
                              title: "Facebook",
                              id: "01",
                            ));
                      },
                    );
                  },
                ),
              ),
              HeightSpacer(size: 20),
              HeadingWidget(
                text: "Recently Posted",
                onTap: () {},
              ),
              HeightSpacer(size: 20),
              VerticalTile()
            ],
          ),
        ),
      )),
    );
  }
}
