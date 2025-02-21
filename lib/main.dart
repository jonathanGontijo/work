import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work/constants/app_constants.dart';
import 'package:work/controllers/bookmark_provider.dart';
import 'package:work/controllers/image_provider.dart';
import 'package:work/controllers/jobs_provider.dart';
import 'package:work/controllers/login_provider.dart';
import 'package:work/controllers/onboarding_provider.dart';
import 'package:work/controllers/profile_provider.dart';
import 'package:work/controllers/signup_provider.dart';
import 'package:work/controllers/zoom_provider.dart';
import 'package:work/firebase_options.dart';
import 'package:work/views/ui/auth/login.dart';
import 'package:work/views/ui/auth/update_user.dart';
import 'package:work/views/ui/mainscreen.dart';
import 'package:work/views/ui/onboarding/onboarding_screen.dart';

Widget defaultHome = const OnBoardingScreen();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final entrypoint = prefs.getBool('entrypoint') ?? false;
  final loggedIn = prefs.getBool('loggedIn') ?? false;
  if (entrypoint & !loggedIn) {
    defaultHome = LoginPage();
  } else if (entrypoint == true) {
    defaultHome = const MainScreen();
  }

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => OnBoardNotifier()),
    ChangeNotifierProvider(create: (context) => LoginNotifier()),
    ChangeNotifierProvider(create: (context) => ZoomNotifier()),
    ChangeNotifierProvider(create: (context) => SignUpNotifier()),
    ChangeNotifierProvider(create: (context) => JobsNotifier()),
    ChangeNotifierProvider(create: (context) => BookMarkNotifier()),
    ChangeNotifierProvider(create: (context) => ImageUpoader()),
    ChangeNotifierProvider(create: (context) => ProfileNotifier()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'JobHub',
            theme: ThemeData(
              scaffoldBackgroundColor: Color(kLight.value),
              iconTheme: IconThemeData(color: Color(kDark.value)),
              primarySwatch: Colors.grey,
            ),
            home: PersonalDetails(),
          );
        });
  }
}
