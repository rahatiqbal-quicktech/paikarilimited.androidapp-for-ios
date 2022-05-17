import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:androidapp/screens/digits_register_google_screens/set_username_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleLoginController extends GetxController {
  var _googlesignin = GoogleSignIn();
  var googleaccount = Rx<GoogleSignInAccount?>(null);

  login() async {
    googleaccount.value = await _googlesignin.signIn();
    final auth = await googleaccount.value!.authentication;
    BigInt a = BigInt.parse(googleaccount.value!.id);
    print("This is big int = ");
    print(a);
    int googleStaticId = 53735;

    final spfGoogle = await SharedPreferences.getInstance();
    spfGoogle.setInt('gmailUserUid', googleStaticId);
    spfGoogle.setString('gmailUserName', "${googleaccount.value!.displayName}");
    spfGoogle.setString('displayName', "${googleaccount.value!.displayName}");
    spfGoogle.setString('googleEmailAddress', "${googleaccount.value!.email}");
    spfGoogle.setString('photoUrl', "${googleaccount.value!.photoUrl}");
    Get.to(() => SetUsernameGoogleScreen());
  }
  //   setGoogleAuth() async {
  //   final spfGoogle = await SharedPreferences.getInstance();
  //   spfGoogle.setInt('userUid', int.parse(controller.googleaccount.value!.id));
  //   spfGoogle.setString(
  //       'userName', "${controller.googleaccount.value!.displayName}");
  //   Get.off(HomeScreen());
  // }

  logout() async {
    googleaccount.value = await _googlesignin.signOut();
  }
}
