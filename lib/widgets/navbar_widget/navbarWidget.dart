import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:androidapp/Controllers/allcategoriescontroller.dart';
import 'package:androidapp/screens/categoryproductsscreen.dart';
import 'package:androidapp/screens/allcouponsscreen.dart';
import 'package:androidapp/screens/homescreen.dart';
import 'package:androidapp/screens/loginscreen.dart';
import 'package:androidapp/screens/orderhistoryscreen.dart';
import 'package:androidapp/screens/profilescreen.dart';
import 'package:androidapp/widgets/navbar_widget/call_center_widget.dart';
import 'package:androidapp/widgets/navbar_widget/navbar_widget_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

final AllCategoriesController categoriesController =
    Get.put(AllCategoriesController());

class NavBarWidget extends StatefulWidget {
  String? userName;

  NavBarWidget({this.userName});

  @override
  State<NavBarWidget> createState() => _NavBarWidgetState();
}

class _NavBarWidgetState extends State<NavBarWidget> {
  final box = GetStorage();
  @override
  void initState() {
    setvalue();
    super.initState();
  }

  NavbaWidgetController c = Get.put(NavbaWidgetController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size / 100;
    return Drawer(
      child: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              ListTile(
                minLeadingWidth: 5,
                leading: Icon(
                  Ionicons.person_circle_outline,
                  color: Colors.black,
                ),
                title: name_ == null
                    ? GestureDetector(
                        onTap: () {
                          Get.to(() => LoginScreen());
                        },
                        child: Text(
                          "Login",
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      )
                    : ifLoggedIn(size),
                trailing: ifLoggedInTrailing(size),
              ),
              Obx(() {
                return c.showContainer.value == true
                    ? CallCenterWidget()
                    : Container();
              }),
              Divider(
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          setpref(384);
                          Get.to(() => CategoryProductsScreen(pid: 384));
                        },
                        icon: Icon(
                          Ionicons.flame_outline,
                          color: Colors.blue,
                        ),
                        label: Text("Offers",
                            style: GoogleFonts.openSans(
                              color: Colors.black,
                            )),
                      ),
                      Spacer(),
                      // VerticalDivider(
                      //   color: Colors.red,
                      // ),
                      TextButton.icon(
                          onPressed: () {
                            Get.to(() => AllCouponsScreen());
                          },
                          icon: Icon(
                            Ionicons.gift_outline,
                            color: Colors.yellow.shade800,
                          ),
                          label: Text(
                            "Coupons",
                            style: GoogleFonts.openSans(
                              color: Colors.black,
                            ),
                          ))
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              ListTile(
                title: Text("Home"),
                leading: Icon(Ionicons.home_sharp),
                trailing: Icon(Ionicons.chevron_forward),
                onTap: () {
                  Get.to(() => HomeScreen());
                },
              ),
              SizedBox(
                  height: (MediaQuery.of(context).size.height / 100) * 75,
                  child: CategoriesList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget CategoriesList() {
    return Obx(() {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: categoriesController.categories_.length,
          itemBuilder: (context, i) {
            final temp = categoriesController.categories_[i];

            return ListTile(
              title: Text(temp.name.toString()),
              // leading: Icon(Ionicons.grid_outline),
              trailing: Icon(Ionicons.chevron_forward),
              onTap: () {
                setpref(temp.id);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CategoryProductsScreen(pid: temp.id!.toInt())));
                // Get.to(() {
                //   CategoryProductsScreen(pid: int.parse(temp.id.toString()));
                // });
              },
            );
          });
    });
  }

  Widget ifLoggedIn(Size size) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Get.to(() => ProfileScreen(
                  name: name_.toString(),
                ));
          },
          child: Container(
            width: size.width * 30,
            child: Text(
              name_.toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              )),
            ),
          ),
        ),
      ],
    );
  }

  Widget ifLoggedInTrailing(Size size) {
    return Container(
      width: size.width * 20,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          token_ == null
              ? SizedBox()
              : GestureDetector(
                  child: Icon(
                    Ionicons.reader_outline,
                    color: Colors.blue.shade800,
                  ),
                  onTap: () {
                    Get.to(() => OrderHistoryScreen(
                          id: token_.toString(),
                        ));
                  }),
          Spacer(),
          GestureDetector(
            child: Icon(
              Ionicons.headset,
              color: Colors.blue.shade800,
            ),
            onTap: () {
              // _callNumber();
              c.show();
            },
          ),
        ],
      ),
    );
  }

  _callNumber() async {
    const number = '01324437989'; //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
    print(res);
  }

//below function is from url_launcher package and has been deprecated
  _launchCaller() async {
    const url = "tel:01324437989";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not call the number $url';
    }
  }

  setgetstorage(int? id) {
    id = 10;
    box.remove('categoryid');
    box.write('categoryid', id);
  }

  setpref(int? a) async {
    // Obtain shared preferences.
    final sprefs = await SharedPreferences.getInstance();
    sprefs.setInt('categoryid', a!);
    print(sprefs.getInt('categoryid'));
  }

  int? token_;
  var name_;

  setvalue() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getInt('userUid');
    var name = sharedPreferences.get('userName');
    setState(() {
      token_ = token;
      name_ = name;
    });
    print("Navbar token = ");
    print(token_);
    print(name_);
  }
}
