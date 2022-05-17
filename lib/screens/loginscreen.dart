import 'package:flutter/material.dart';
import 'package:flutter_awesome_buttons/flutter_awesome_buttons.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:androidapp/Controllers/digits_auth_controller.dart';
import 'package:androidapp/Controllers/login_controller.dart';
import 'package:androidapp/Controllers/signincontroller.dart';
import 'package:androidapp/widgets/commonwidgets.dart';
import 'package:androidapp/widgets/loading_dialog.dart';
import 'package:androidapp/screens/select_passwordreset_method_screen.dart';
import 'package:androidapp/screens/digits_register_google_screens/set_username_screen.dart';
import 'package:androidapp/screens/homescreen.dart';
import 'package:androidapp/screens/otp_login_screen.dart';
import 'package:androidapp/screens/signupscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Get.put(GoogleLoginController());
  final logincontroller = Get.put(SignIn(), permanent: true);
  final digitsLoginController =
      Get.put(DigitsAuthController(), permanent: true);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size / 100;
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            whitespace(context, 10, 0),

            Image.asset(
              'assets/logos/paikari.jpg',
              height: size.height * 30,
            ),
            whitespace(context, 3.3, 0),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    onChanged: digitsLoginController.user,
                    decoration: const InputDecoration(
                      // labelText: 'Email/Mobile Number',
                      hintText: 'Enter Phone Number / Email / Username ',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone Number / Email / Username is required';
                      }
                      return null;
                    },
                  ),
                  whitespace(context, 1.1, 0),
                  TextFormField(
                    onChanged: digitsLoginController.password,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      // labelText: 'Password',
                      hintText: 'Enter your password',
                    ),
                  ),
                  whitespace(context, 3, 0),
                  SizedBox(
                      width: double.infinity,
                      child: DarkButtton(
                          title: "Login",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              LoadingDialog().show(context);
                              digitsLoginController.signIn();
                            }
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => const HomeScreen()));
                          })),
                  SizedBox(
                      width: double.infinity,
                      child: DarkButtton(
                          title: "Login with OTP",
                          onPressed: () {
                            Get.to(() => OtpLoginScreen());

                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => const HomeScreen()));
                          })),
                ],
              ),
            ),
            whitespace(context, 1.5, 0),
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                child: Text(
                  "Forgot password?",
                  style: GoogleFonts.openSans(),
                ),
                onTap: () {
                  Get.to(() => SelectPasswordResetMethodScreen());
                },
              ),
            ),
            whitespace(context, 2, 0),
            SizedBox(width: double.infinity, child: buildloginbutton()),
            // SizedBox(
            //     width: double.infinity,
            //     child: Obx(() {
            //       if (controller.googleaccount.value == null) {
            //         return buildloginbutton();
            //       } else {
            //         return buildprofileview();
            //       }
            //     })),
            // whitespace(context, 2, 0),
            SizedBox(
              width: double.infinity,
              child: SignInButton(
                Buttons.Facebook,
                onPressed: () {
                  signInFacebook();
                },
              ),
            ),
            whitespace(context, 2, 0),
            Text(
              "Don't have an account?",
              style: GoogleFonts.openSans(),
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpScreen()));
                },
                child: Text(
                  "Sign Up",
                  style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                    color: Colors.black,
                  )),
                ),
                style: const ButtonStyle(),
              ),
            ),

            // textformfi
          ],
        ),
      ),
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

  setGoogleAuth() async {
    final spfGoogle = await SharedPreferences.getInstance();
    spfGoogle.setInt('userUid', int.parse(controller.googleaccount.value!.id));
    spfGoogle.setString(
        'userName', "${controller.googleaccount.value!.displayName}");
    Get.off(HomeScreen());
  }

  buildprofileview() {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage:
              Image.network(controller.googleaccount.value?.photoUrl ?? '')
                  .image,
          radius: 100,
        ),
        Text(controller.googleaccount.value?.displayName ?? ''),
        Text(controller.googleaccount.value?.email ?? ''),
        Text(controller.googleaccount.value?.id ?? ''),
        // Text(controller.googleaccount.value?.serverAuthCode ?? ''),
        TextButton.icon(
            onPressed: () {
              controller.logout();
            },
            icon: Icon(Ionicons.log_out),
            label: Text("Logout"))
      ],
    );
  }

  Map<String, dynamic>? _userdata;
  String? dataCheck;

  signInFacebook() async {
    // final LoginResult loginResult =
    await FacebookAuth.instance.login(permissions: ['email']).then((value) {
      FacebookAuth.instance.getUserData().then((getUserData) async {
        final spf = await SharedPreferences.getInstance();
        // spf.setInt('userUid', int.parse(getUserData['id']));
        // spf.setString('userName', getUserData['name']);
        spf.setString('displayName', "${getUserData['name']}");
        spf.setString('googleEmailAddress', "${getUserData['email']}");
        spf.setString('photoUrl', "${getUserData['picture']['data']['url']}");
        // spf.setString('imageUrl', getUserData['data']['url']);
        print(getUserData);
        Get.to(() => SetUsernameGoogleScreen());
      });
    });
    // if (loginResult == LoginStatus.success) {
    //   // final userData = await FacebookAuth.instance.getUserData();
    //   // _userdata = userData;
    //   final AccessToken accessToken = loginResult.accessToken!;
    //   print("signInFacebook function - $accessToken");
    //   Get.to(() => HomeScreen());
    // } else {
    //   print("signInFacebook function - ${loginResult.message}");
    // }
    // setState(() {
    //   dataCheck = _userdata!['email'];
    // });
    // print("This is the email address from print  " +
    //     _userdata!['email'].toString());
    // final OAuthCredential oAuthCredential =
    //     FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // return FirebaseAuth.instance.signInWithCredential(oAuthCredential);
  }
}
