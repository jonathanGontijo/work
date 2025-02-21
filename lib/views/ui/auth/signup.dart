import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:work/constants/app_constants.dart';
import 'package:work/controllers/login_provider.dart';
import 'package:work/controllers/signup_provider.dart';
import 'package:work/views/common/app_bar.dart';
import 'package:work/views/common/app_style.dart';
import 'package:work/views/common/custom_btn.dart';
import 'package:work/views/common/custom_textfield.dart';
import 'package:work/views/common/drawer/drawer_widget.dart';
import 'package:work/views/common/height_spacer.dart';
import 'package:work/views/common/reusable_text.dart';
import 'package:work/views/ui/auth/login.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    return Consumer<SignUpNotifier>(
      builder: (context, signupNotifier, child) {
        return Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: CustomAppBar(
                text: 'Register',
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(CupertinoIcons.arrow_left),
                ),
              )),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                HeightSpacer(size: 50),
                ReusableText(
                  text: 'Welcome Back',
                  style: appstyle(30, Color(kDark.value), FontWeight.w600),
                ),
                ReusableText(
                  text: 'Fill the details to login to your account',
                  style: appstyle(16, Color(kDarkGrey.value), FontWeight.w600),
                ),
                HeightSpacer(size: 50),
                CustomTextField(
                  controller: email,
                  hintText: "Full Name",
                  keyboardType: TextInputType.text,
                  validator: (name) {
                    if (name!.isEmpty) {
                      return 'Please enter a valid name';
                    } else {
                      return null;
                    }
                  },
                ),
                HeightSpacer(size: 20),
                CustomTextField(
                  controller: email,
                  hintText: "Email",
                  keyboardType: TextInputType.emailAddress,
                  validator: (email) {
                    if (email!.isEmpty || !email.contains("@")) {
                      return 'Please enter a valid email';
                    } else {
                      return null;
                    }
                  },
                ),
                HeightSpacer(size: 20),
                CustomTextField(
                  controller: password,
                  hintText: "Password",
                  obscureText: signupNotifier.obscureText,
                  keyboardType: TextInputType.text,
                  validator: (password) {
                    if (signupNotifier.passwordValidator(password ?? '')) {
                      return 'Please enter a valid password with at least one uppercase, one lowercase, one special character, one digit and length of 8 charactes';
                    } else {
                      return null;
                    }
                  },
                  suffixIcon: GestureDetector(
                    onTap: () {
                      signupNotifier.obscureText = !signupNotifier.obscureText;
                    },
                    child: signupNotifier.obscureText
                        ? Icon(
                            Icons.visibility,
                            color: Color(kDark.value),
                          )
                        : Icon(
                            Icons.visibility_off,
                            color: Color(kDark.value),
                          ),
                  ),
                ),
                HeightSpacer(size: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {},
                    child: ReusableText(
                        text: "Login",
                        style:
                            appstyle(14, Color(kDark.value), FontWeight.w400)),
                  ),
                ),
                HeightSpacer(size: 10),
                CustomButton(
                  onTap: () {
                    loginNotifier.firstTime = !loginNotifier.firstTime;
                  },
                  text: 'Sign Up',
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
