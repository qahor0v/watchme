import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firedart/auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watch_me/pages/home_page.dart';
import 'package:watch_me/pages/navbar_pages/download_page.dart';
import 'package:watch_me/pages/secret/offline.dart';

class LottiePage extends StatefulWidget {
  static const String id = "lottie_page";

  const LottiePage({Key? key}) : super(key: key);

  @override
  State<LottiePage> createState() => _LottiePageState();
}

class _LottiePageState extends State<LottiePage> {
  final auth = FirebaseAuth.instance;

  Future login() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        final prefs = await SharedPreferences.getInstance();
        String email = prefs.getString("email")!;
        String password = prefs.getString("password")!;
        auth.signIn(email, password).then((value) {
          Navigator.pushReplacementNamed(context, HomePage.id);
        });
      }
    } on SocketException catch (_) {
      log('not connected');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Not internet connection".tr()),
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const OfflinePage(),
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    login();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset(
          "assets/lotties/movie.json",
        ),
      ),
    );
  }
}
