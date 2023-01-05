import 'dart:async';
import 'dart:ui';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watch_me/pages/home_page.dart';
import 'package:watch_me/pages/login_pages/sign_up.dart';
import 'package:watch_me/screens/loading_widget.dart';

class SignInPage extends StatefulWidget {
  static const String id = "wv937547534h8n";

  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var emailcontrol = TextEditingController();
  var passwordcontrol = TextEditingController();
  bool hidetext = true;
  int index = 0;
  List<String> images = [
    "assets/images/img_1.png",
    "assets/images/img.png",
    "assets/images/img_3.png",
    "assets/images/img_2.png",
  ];

  void slideshow() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (index < images.length - 1) {
        setState(() {
          index++;
        });
      } else {
        setState(() {
          index = 0;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    slideshow();
  }

  final auth = FirebaseAuth.instance;

  Future signIn() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white24,
            child: Center(
              child: Loading.loading(),
            ),
          );
        });
    final prefs = await SharedPreferences.getInstance();
    String email = emailcontrol.text.trim();
    String password = passwordcontrol.text.trim();
    try {
      await auth.signIn(email, password).then((value) {
        prefs.setString("password", password);
        prefs.setString("email", email);
        prefs.setBool("logged", true);
        setState(() {
          prefs.setBool("logged", true);
        });
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, HomePage.id);
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Error! Check your password or email and try again'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 1,
          width: MediaQuery.of(context).size.width * 1,
          decoration: BoxDecoration(
            color: Colors.grey,
            image: DecorationImage(
              image: AssetImage(images[index]),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 15,
                        sigmaY: 15,
                      ),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                              left: 16, top: 12,
                            ),
                            child: Text(
                              "Hi!",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          // glassmorphizm UI
                          Container(
                            margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.02,
                              right: MediaQuery.of(context).size.width * 0.02,
                            ),
                            height: MediaQuery.of(context).size.height * 0.36,
                            child: SizedBox(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.027,
                                  ),
                                  // email
                                  Container(
                                    padding: const EdgeInsets.only(left: 14, right: 14),
                                    height: MediaQuery.of(context).size.height * 0.068,
                                    width: MediaQuery.of(context).size.width * 0.83,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                        7,
                                      ),
                                    ),
                                    child: TextField(
                                      showCursor: true,
                                      cursorColor: Colors.red,
                                      textAlign: TextAlign.start,
                                      controller: emailcontrol,
                                      //obscureText: false, textni yashirish
                                      style: const TextStyle(
                                        fontSize: 17,
                                      ),
                                      textInputAction: TextInputAction.done,
                                      decoration: InputDecoration(
                                        hintText: "Email",
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                          fontSize: 17,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.022,
                                  ),
                                  // password
                                  Container(
                                    padding: const EdgeInsets.only(left: 14, right: 14),
                                    height: MediaQuery.of(context).size.height * 0.068,
                                    width: MediaQuery.of(context).size.width * 0.83,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(7)),
                                    child: TextField(
                                      showCursor: true,
                                      cursorColor: Colors.red,
                                      textAlign: TextAlign.start,
                                      controller: passwordcontrol,
                                      obscureText: hidetext,
                                      //textni yashirish
                                      style: const TextStyle(
                                        fontSize: 17,
                                      ),
                                      textInputAction: TextInputAction.done,
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                hidetext = !hidetext;
                                              });
                                            },
                                            icon: hidetext
                                                ? const Icon(
                                              Icons.visibility_off,
                                              color: Colors.grey,
                                            )
                                                : const Icon(
                                              Icons.visibility,
                                              color: Colors.grey,
                                            )),
                                        hintText: "Password",
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                          fontSize: 17,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.022,
                                  ),
                                  //continue
                                  Container(
                                    height: MediaQuery.of(context).size.height * 0.068,
                                    width: MediaQuery.of(context).size.width * 0.83,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(
                                        7,
                                      ),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        signIn();
                                      },
                                      child: const Text(
                                        "Continue",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.022,
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.03,
                                    width: MediaQuery.of(context).size.width * 0.83,
                                    // color: Colors.lightBlue,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Don't have an account?",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushReplacementNamed(
                                              context,
                                              SignUpPage.id,
                                            );
                                          },
                                          child: const Text(
                                            "Sign Up",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.red,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //width: MediaQuery.of(context).size.width,
                          ),
                        ],
                      )
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
