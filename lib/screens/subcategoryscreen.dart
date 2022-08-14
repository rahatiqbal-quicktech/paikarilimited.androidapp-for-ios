import 'package:flutter/material.dart';
import 'package:androidapp/widgets/commonwidgets.dart';
import 'package:androidapp/screens/homescreen.dart';

class SubCategoryScreen extends StatefulWidget {
  const SubCategoryScreen({Key? key}) : super(key: key);

  @override
  _SubCategoryScreenState createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size / 100;

    return Scaffold(
      appBar: CommonAppBar(context),
      // drawer: Sidenav(size),
      body: Container(
        color: Colors.black.withOpacity(0.5),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    image: const DecorationImage(
                        image: NetworkImage(
                          "https://thumbs.dreamstime.com/b/detail-eggs-carton-box-delicate-soft-faded-tone-useful-as-background-eggs-picture-soft-faded-tone-background-125408985.jpg",
                        ),
                        fit: BoxFit.cover)),
                alignment: Alignment.center,
                width: double.infinity,
                height: size.height * 20,
                child: const Text(
                  "Subcategory",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          "https://thumbs.dreamstime.com/b/detail-eggs-carton-box-delicate-soft-faded-tone-useful-as-background-eggs-picture-soft-faded-tone-background-125408985.jpg",
                        ),
                        fit: BoxFit.cover)),
                alignment: Alignment.center,
                width: double.infinity,
                height: size.height * 20,
                child: const Text(
                  "Subcategory",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          "https://thumbs.dreamstime.com/b/detail-eggs-carton-box-delicate-soft-faded-tone-useful-as-background-eggs-picture-soft-faded-tone-background-125408985.jpg",
                        ),
                        fit: BoxFit.cover)),
                alignment: Alignment.center,
                width: double.infinity,
                height: size.height * 20,
                child: const Text(
                  "Subcategory",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
