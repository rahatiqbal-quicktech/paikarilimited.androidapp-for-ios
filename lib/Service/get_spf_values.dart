import 'package:shared_preferences/shared_preferences.dart';

class GetSpfValues {
  int? userId;
  var userName;

  getUserId() async {
    final spf = await SharedPreferences.getInstance();
    userId = spf.getInt('userUid');
    return userId;
  }
}
