import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:androidapp/Controllers/login_controller.dart';

class LoginScreenBoilerplate extends StatefulWidget {
  const LoginScreenBoilerplate({Key? key}) : super(key: key);

  @override
  _LoginScreenBoilerplateState createState() => _LoginScreenBoilerplateState();
}

class _LoginScreenBoilerplateState extends State<LoginScreenBoilerplate> {
  final controller = Get.put(GoogleLoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(() {
          if (controller.googleaccount.value == null) {
            return buildloginbutton();
          } else {
            return buildprofileview();
          }
        }),
      ],
    ));
  }

  SignInButton buildloginbutton() {
    return SignInButton(
      Buttons.Google,
      onPressed: () {
        // GoogleSignIn().signIn();
        controller.login();
      },
    );
  }

  Column buildprofileview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundImage: Image.network("").image,
          radius: 100,
        ),
        Text(controller.googleaccount.value?.displayName ?? ''),
      ],
    );
  }
}
