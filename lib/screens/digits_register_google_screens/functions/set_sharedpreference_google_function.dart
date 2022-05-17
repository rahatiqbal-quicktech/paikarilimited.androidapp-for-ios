import 'package:shared_preferences/shared_preferences.dart';

setSharedPreferenceGoogle(
    {required String spfKey,
    required String texts,
    required void Function() function}) async {
  final spf = await SharedPreferences.getInstance();
  spf.setString(spfKey, texts);
  print("setSharedPreferenceGoogle print :  ${spf.getString(spfKey)}");
  function();
}
