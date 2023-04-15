import 'package:asset_tracker/services/web_services.dart';
import 'package:asset_tracker/ui/constants/theme_data.dart';
import 'package:asset_tracker/ui/utilities/routes.dart';
import 'package:asset_tracker/ui/widgets/custom_form_text_field.dart';
import 'package:asset_tracker/ui/widgets/pry_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user.dart';
import '../../ui/utilities/size_config.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late SharedPreferences prefs;

  @override
  void initState() {
    SharedPreferences.getInstance().then((value) => prefs = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double? defaultSize = SizeConfig.defaultSize!;
    String coloredText(String color, String text) {
      return '\x1B$color$text\x1B[0m';
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(defaultSize * 2),
          child: Column(
            children: [
              Center(
                child: Container(
                  width: defaultSize * 30,
                  height: defaultSize * 20,
                  child: Image.asset("assets/logo/bcc.png"),
                ),
              ),
              SizedBox(
                height: defaultSize * 2,
              ),
              Text(
                "Sign in to continue",
                style: TextStyle(color: textColor, fontSize: defaultSize * 1.8),
              ),
              SizedBox(
                height: defaultSize * 2,
              ),
              CustomFormTextWidget(
                hint: "Email",
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
              ),
              CustomFormTextWidget(
                hint: "Password",
                obscureText: true,
                keyboardType: TextInputType.text,
                controller: passwordController,
              ),
              SizedBox(
                height: defaultSize * 2,
              ),
              PrimaryButton(
                label: "Signin",
                onPressed: () {
                  Get.showOverlay(
                    asyncFunction: () => WebServices()
                        .signIn(emailController.text.trim(),
                            passwordController.text)
                        .then((result) {
                      if (result['status']) {
                        User.toPrefs(result['user'], prefs);
                        Get.offAndToNamed(GetRoutes.dashboard);
                      } else {
                        Get.showSnackbar(GetSnackBar(
                          duration: const Duration(seconds: 3),
                          title: "Error",
                          message: "${result['message']}",
                        ));
                      }
                    }),
                    // {
                    // WebServices()
                    //     .signIn(emailController.text.trim(),
                    //         passwordController.text)
                    //   .then((result) {
                    // if (result['status']) {
                    //   User.toPrefs(result['user'], prefs);
                    //   Get.offAndToNamed(GetRoutes.dashboard);
                    // } else {
                    //   Get.showSnackbar(GetSnackBar(
                    //     duration: const Duration(seconds: 3),
                    //     title: "Error",
                    //     message: "${result['message']}",
                    //   ));
                    // }
                    // });
                    //   return Future.value(true);
                    // },
                    loadingWidget: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    ),
                  );
                },
                icon: Icons.arrow_right_alt,
              )
            ],
          ),
        ),
      ),
    );
  }
}
