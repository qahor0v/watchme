import 'dart:developer';
import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watch_me/pages/language_page.dart';
import 'package:watch_me/pages/login_pages/start_page.dart';
import 'package:watch_me/pages/secret/change_index.dart';
import 'package:watch_me/providers/history_provider.dart';
import 'package:watch_me/screens/history_screen.dart';

class Account extends StatefulWidget {
  static const String id = "account_id";

  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String name = "";
  String mail = "";

  Future<void> userName() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      String? tempName = prefs.getString('name');
      String? tempMail = prefs.getString('email');
      setState(() {
        name = tempName!;
        mail = tempMail!;
      });
    } catch (e) {
      log("$e");
    }
  }

  Future signOut(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("email");
    prefs.remove("password");
    prefs.remove("logged");
    prefs.remove('history');
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, StartPage.id);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userName();
    context.read<HistoryProvider>().getHistory();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/background.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 20,
              sigmaY: 20,
            ),
            child: SizedBox(
              height: height,
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.2,
                    width: height * 0.2,
                    child: Icon(
                      Icons.account_circle,
                      size: height * 0.2,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  name != ""
                      ? Text(
                          name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        )
                      : const SizedBox.shrink(),

                  const SizedBox(height: 8),
                  mail == ""
                      ? const SizedBox.shrink()
                      : Text(
                          mail,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                  const SizedBox(height: 8),
                  widgetTile(
                    height,
                    width,
                    context,
                    "Language".tr(),
                    Icons.language,
                    openLang,
                  ),
                  widgetTile(
                    height,
                    width,
                    context,
                    "History".tr(),
                    Icons.history,
                    openHistory,
                  ),
                  // widgetTile(
                  //   height,
                  //   width,
                  //   context,
                  //   "Exit".tr(),
                  //   IconlyLight.logout,
                  //   signOut,
                  // ),
                  GestureDetector(
                    onLongPress: () {
                      showBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Center(
                              child: MaterialButton(
                                onLongPress: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const ChangeAppbarIndex(),
                                    ),
                                  );
                                },
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "WatchMe!",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 20),
                                ),
                              ),
                            );
                          });
                    },
                    onTap: () {
                      signOut(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 36,
                        right: 36,
                        top: 8,
                        bottom: 8,
                      ),
                      height: height * 0.08,
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(IconlyLight.logout,
                                color: Colors.red, size: 30),
                            const SizedBox(width: 8),
                            Text(
                              "Exit".tr(),
                              style: const TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget widgetTile(double height, double width, BuildContext context,
      String title, icon, onTap) {
    return GestureDetector(
      onLongPress: () {
        showBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Center(
                child: MaterialButton(
                  onLongPress: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ChangeAppbarIndex(),
                      ),
                    );
                  },
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "WatchMe!",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w800,
                        fontSize: 20),
                  ),
                ),
              );
            });
      },
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(
          left: 36,
          right: 36,
          top: 8,
          bottom: 8,
        ),
        height: height * 0.08,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.red, size: 30),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void openLang() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const LanguagePage(),
      ),
    );
  }

  void openHistory() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const HistoryScreen(),
      ),
    );
  }
}
