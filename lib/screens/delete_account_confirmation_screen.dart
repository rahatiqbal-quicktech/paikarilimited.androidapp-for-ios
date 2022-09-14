import 'package:androidapp/Service/delete_account_service.dart';
import 'package:androidapp/widgets/commonwidgets.dart';
import 'package:flutter/material.dart';

class DeleteAccountConfirmationScreen extends StatelessWidget {
  const DeleteAccountConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          whitespace(context, 10, 0),
          Icon(
            Icons.delete_forever,
            color: Colors.red,
            size: 100,
          ),
          Text("Delete Account"),
          whitespace(context, 5, 0),
          Text(
            '''If you delete your account, all your account infomation will be removed and you will not be able to access your account.''',
            textAlign: TextAlign.center,
          ),
          whitespace(context, 5, 0),
          SizedBox(
            width: 250,
            child: ElevatedButton(
              onPressed: () {
                DeleteAccountService().deleteMyAccount();
              },
              child: Text("Delete"),
            ),
          ),
        ],
      ),
    );
  }
}
