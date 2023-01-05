// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketies/components/default_button.dart';
import 'package:marketies/utils/constant.dart';

class Introduction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.blueGrey,

        body: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bg.png"),
                  fit: BoxFit.cover)),
        ),
        Body()
      ],
    ));
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Earn anytime, anywhere "
          "\n with Marketies",
      "image": "assets/images/3rd.png",
      "title": "Earn unlimited without"
          "\n any hassle"
    },
    {
      "text": "Earn by referring all your"
          "\n favorite brands",
      // "\nthe printing and typesetting industry.",
      "image": "assets/images/1st.png",
      "title": "Start your 'Passive Income'"
          "\n  with us",
    },
    {
      "text": "Withdraw your payouts anytime"
          "\n in your linked bank account",
      "image": "assets/images/2nd.png",
      "title": "Secure and timely payouts "
    },
  ];

  var id;
  @override
  initState() {
    super.initState();
    // Getid();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"].toString(),
                  text: splashData[index]["text"].toString(),
                  title: splashData[index]["title"].toString(),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    // Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 160,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: kPrimaryColor)),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () {
                              Get.toNamed("/login");
                            },
                            child: Text(
                              "Login",
                              style: GoogleFonts.cabin(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 160,
                          height: 50,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor: kPrimaryColor,
                            ),
                            onPressed: () {
                              Get.toNamed("/signup");
                            },
                            child: Text(
                              "Register",
                              style: GoogleFonts.cabin(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Anineted dot build according to moving images and text (index)
  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }


}

class SplashContent extends StatelessWidget {
  const SplashContent(
      {required this.text, required this.image, required this.title});
  final String text, image, title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 120,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Image.asset(
            image,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.cabin(
              height: 1.5,
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.cabin(
            letterSpacing: 1,
            height: 1.5,
            color: Colors.black87,
            fontSize: 16,
          ),
        ),
        Spacer(flex: 1),
      ],
    );
  }
}
