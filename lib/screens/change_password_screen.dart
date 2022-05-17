import 'package:flutter/material.dart';
import 'package:androidapp/Fixed%20Variables/fixedvariables.dart';
import 'package:androidapp/Service/change_password_service.dart';
import 'package:androidapp/widgets/commonwidgets.dart';
import 'package:androidapp/widgets/loading_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    setuserid();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            whitespace(context, 5, 0),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            hintText: "New Password",
                            labelText: "New Password"),
                        controller: passwordController,
                        validator: (val) {
                          if (val!.isEmpty) return 'Enter a new password';
                          return null;
                        }),
                    whitespace(context, 2, 0),
                    TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            hintText: "Confirm Password",
                            labelText: "Confirm Password"),
                        controller: confirmPasswordController,
                        validator: (val) {
                          if (val!.isEmpty) return 'Field Empty';
                          if (val != passwordController.text)
                            return 'Password Doesn\'t match';
                          return null;
                        }),
                    whitespace(context, 2, 0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: redcolor),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              LoadingDialog().show(context);
                              ChangePasswordService().changePassword(
                                  userid, confirmPasswordController.text);
                            }
                          },
                          child: Text("Change Password")),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  int? userid;

  setuserid() async {
    final preference = await SharedPreferences.getInstance();
    setState(() {
      userid = preference.getInt('userUid');
    });
    print(userid);
  }
}
