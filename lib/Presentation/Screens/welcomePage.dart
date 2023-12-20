import 'package:af_watches2/Constants/strings.dart';
import 'package:flutter/material.dart';
import '../Widgets/splash_content.dart';
import 'SignUpPage.dart';
import 'loginPage.dart';
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key, this.title});
  final String? title;

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to AF Watches, Let’s shop!",
      "image": "assets/3.png"
    },
    {
      "text":
      "We help people conect with store \naround Egypt",
      "image": "assets/2.png"
    },
    {
      "text": "We show the easy way to shop. \nJust stay at home with us",
      "image": "assets/1.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: splashData.length,
                  itemBuilder: (context, index) => SplashContent(
                    image: splashData[index]["image"],
                    text: splashData[index]['text'],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          splashData.length,
                              (index) => AnimatedContainer(
                            duration:const  Duration(milliseconds: 250),
                            margin: const EdgeInsets.only(right: 5),
                            height: 6,
                            width: currentPage == index ? 20 : 6,
                            decoration: BoxDecoration(
                              color: currentPage == index
                                  ? gradient3
                                  : const Color(0xFFD8D8D8),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(flex: 3),
                      ElevatedButton(
                        style:  ElevatedButton.styleFrom(
                        backgroundColor: gradient3, // Background color
                      ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, loginPage);
                        },
                        child: const Text("  Continue  "),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}