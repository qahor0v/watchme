import 'dart:math';
import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:watch_me/pages/login_pages/sign_up.dart';
import 'package:watch_me/pages/login_pages/sign_in.dart';

class StartPage extends StatefulWidget {
  static const String id = "StartPage";

  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  PageController pageController = PageController();
  int pIndex = 0;
  String logo = "WatchMe";
  List<String> lens = ['EN', 'UZ', 'RU'];
  String currentLang = 'EN';
  double viewportFraction = 0.8;
  late double pageoffset = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController(
      initialPage: 0,
      viewportFraction: viewportFraction,
    )..addListener(() {
        setState(() {
          pageoffset = pageController.page!;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xff2b333e),
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              "assets/images/background.jpg",
              fit: BoxFit.cover,
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 15,
              sigmaY: 15,
            ),
            child: Container(
              padding: const EdgeInsets.only(),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xff16172B).withOpacity(0.5),
                    const Color(0xff16172B).withOpacity(0.5),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 50,
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      logo,
                      style: GoogleFonts.aBeeZee(
                        fontSize: 25,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    changeLanguage(),
                  ],
                ),
              ),
              Expanded(
                child: PageViewWidget(
                  pageController: pageController,
                  pageoffset: pageoffset,
                  viewportFraction: viewportFraction,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 12,
              ),

              ///arrow container
              Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white38, width: 2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: GestureDetector(
                    child: const Icon(
                      IconlyBold.arrow_right_3,
                      size: 25,
                      color: Colors.white,
                    ),
                    onTap: () {
                      if (pIndex < 3) {
                        setState(() {
                          pIndex++;
                        });
                        pageController.animateToPage(
                          pIndex,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOutQuad,
                        );
                      } else {
                        setState(() {
                          pIndex = 0;
                        });
                        pageController.animateToPage(
                          0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOutQuad,
                        );
                      }
                    },
                  )),
              const SizedBox(
                height: 12,
              ),

              Text(
                "See what's next".tr(),
                style: GoogleFonts.aBeeZee(
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),

              SizedBox(
                height: height * 0.02,
              ),

              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  "about".tr(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xff757c86),
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 50, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //SignUP
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, SignUpPage.id);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 28, right: 28),
                        height: height * 0.08,
                        //width: width * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            width: 2,
                            color: Colors.white38,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "signup".tr(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    //SignIN
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, SignInPage.id);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 32, right: 32),
                        height: height * 0.08,
                       // width: width * 0.2,
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            "signin".tr(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget changeLanguage() {
    return DropdownButton<String>(
      dropdownColor: Colors.black,
      value: currentLang,
      icon: const Icon(Icons.language),
      elevation: 16,
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          currentLang = value!;
        });
      },
      items: List<DropdownMenuItem<String>>.generate(
        lens.length,
        (int index) {
          return DropdownMenuItem<String>(
            onTap: () {
              context.locale = Locale(trLang[index], tRLang[index]);
            },
            value: lens[index],
            child: Text(
              "${lens[index]} ",
              style: const TextStyle(
                color: Colors.white60,
                fontWeight: FontWeight.w800,
              ),
            ),
          );
        },
      ),
    );
  }
}

/////PAGE builder

class PageViewWidget extends StatefulWidget {
  static const String id = "page_view";

  const PageViewWidget(
      {required this.pageController,
      required this.pageoffset,
      required this.viewportFraction,
      Key? key})
      : super(key: key);
  final PageController pageController;
  final double pageoffset;
  final double viewportFraction;

  @override
  State<PageViewWidget> createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget> {
  final List _list = [
    "assets/images/img.png",
    "assets/images/img_3.png",
    "assets/images/img_2.png",
  ];
  List nameofmov = ["Wednesday", "Red Notice", "Top Gun: Maverick"];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.height;
    return PageView.builder(
      controller: widget.pageController,
      itemCount: _list.length,
      itemBuilder: (context, index) {
        double scale = max(widget.viewportFraction,
            (1 - (widget.pageoffset - index).abs()) + widget.viewportFraction);

        double angle = (widget.pageoffset - index).abs();

        if (angle > 0.5) {
          angle = 1 - angle;
        }

        return Container(
          padding: EdgeInsets.only(
            right: 20,
            left: 10,
            top: 100 - scale * 50,
          ),
          child: Column(
            children: [
              Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0)
                  ..rotateY(angle),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.red.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 20,
                              offset: const Offset(5, 5)),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                          _list[index],
                          fit: BoxFit.cover,
                          height: height * 0.3,
                          width: width * 0.25,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Text(
                        nameofmov[index],
                        style: GoogleFonts.aBeeZee(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

const trLang = ['en', 'uz', 'ru'];
const tRLang = ['US', 'UZ', 'BL'];
