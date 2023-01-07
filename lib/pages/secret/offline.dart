import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watch_me/models/movie_model.dart';
import 'package:watch_me/pages/lottie_page.dart';
import 'package:watch_me/providers/download_manager.dart';
import 'package:watch_me/screens/downloaded_item_screen.dart';

import '../../screens/download_item_screen.dart';

class OfflinePage extends StatefulWidget {
  static const String id = "s34c5t9342";

  const OfflinePage({Key? key}) : super(key: key);

  @override
  State<OfflinePage> createState() => _OfflinePageState();
}

class _OfflinePageState extends State<OfflinePage> {
  List<MovieModel> movies = [];

  Future<void> getSavedMovies() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      List<String>? tempList = preferences.getStringList('movies');

      for (var item in tempList!) {
        var tempMov = MovieModel.fromJson(jsonDecode(item));
        setState(() {
          movies.add(tempMov);
        });
      }
    } catch (e) {
      log("$e");
    }
    log("Movies: ${movies.length}");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSavedMovies();
  }

  @override
  Widget build(BuildContext context) {
    log('Came to download page: downloading movie length: ${DownloadManager.instance.movies.length}');
    return Scaffold(
      backgroundColor: const Color(0xff38404b).withOpacity(0.8),
      appBar: AppBar(
        title: Text("Not internet connection".tr()),
        backgroundColor: const Color(0xff38404b),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const LottiePage(),
                ),
              );
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 8)
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/background.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaY: 15,
            sigmaX: 15,
          ),
          child: StreamBuilder<int>(
            stream: DownloadManager.instance.onUpdate.stream,
            builder: (context, snapshot) {
              log('Progress updated: movie length: ${DownloadManager.instance.movies.length}');

              if (DownloadManager.instance.movies.isEmpty && movies.isEmpty) {
                return Center(
                  child: SizedBox(
                    height: 300,
                    width: 300,
                    child: Lottie.asset(
                      'assets/lotties/empty.json',
                    ),
                  ),
                );
              }
              return CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return DownloadItemScreen(
                          movie: DownloadManager.instance.movies[index],
                        );
                      },
                      childCount: DownloadManager.instance.movies.length,
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return DownloadedItem(
                          movie: movies[index],
                        );
                      },
                      childCount: movies.length,
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 200,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
