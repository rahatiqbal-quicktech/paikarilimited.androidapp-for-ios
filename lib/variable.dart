import 'package:shared_preferences/shared_preferences.dart';

var token_;
getvariable() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final token = sharedPreferences.get('userUid');
  token_ = token;
}
