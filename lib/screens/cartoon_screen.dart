import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:watch_me/models/cartoon_model.dart';
import 'package:watch_me/models/history_model.dart';
import 'package:watch_me/models/movie_model.dart';
import 'package:watch_me/player/player.dart';
import 'package:watch_me/providers/history_provider.dart';
import 'package:watch_me/providers/movies_provider.dart';
import 'package:watch_me/screens/loading_widget.dart';

import '../providers/download_manager.dart';

class CartoonScreen extends StatefulWidget {
  static const String id = "page";

  const CartoonScreen({required this.cartoon, super.key});

  final CartoonModel cartoon;

  @override
  State<CartoonScreen> createState() => _CartoonScreenState();
}

class _CartoonScreenState extends State<CartoonScreen> {
  PageController controller = PageController();
  bool showInfo = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xff38404b),
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: height * 0.55,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    height: height * 0.55,
                    fit: BoxFit.cover,
                    imageUrl: widget.cartoon.imgUrl,
                    placeholder: (context, url) => Loading.loading(),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.movie,
                      size: 50,
                      color: Colors.red,
                    ),
                  ),
                  Container(
                    height: height * 0.55,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.transparent,
                          Colors.transparent,
                          const Color(0xff38404b).withOpacity(0.4),
                          const Color(0xff38404b).withOpacity(0.6),
                          const Color(0xff38404b).withOpacity(0.8),
                          const Color(0xff38404b),
                          const Color(0xff38404b),
                          const Color(0xff38404b),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.55,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ////icon
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              var mov = HistoryModel(
                                id: '${widget.cartoon.name}id',
                                name: widget.cartoon.name,
                                path: 'null',
                                url: widget.cartoon.videoUrl,
                                imgUrl: widget.cartoon.imgUrl,
                                isDownloaded: false,
                              );
                              context.read<HistoryProvider>().onAddHistory(mov);
                              setState(
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Player(
                                        vd_url: widget.cartoon.videoUrl,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: const Icon(
                              IconlyBold.play,
                              color: Colors.red,
                              size: 50,
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.1,
                            left: 15,
                            right: 15,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  widget.cartoon.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30, right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  IconlyBold.calendar,
                                  color: Colors.red,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  widget.cartoon.year.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  "|",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const Icon(
                                  IconlyBold.star,
                                  color: Colors.amber,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  widget.cartoon.rating.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16,
                            right: 30,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children:  [
                                  const Icon(
                                    Icons.info_outline,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    "About".tr(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      var cartoon = MovieModel(
                                        id: widget.cartoon.name
                                            .replaceAll(" ", ""),
                                        name: widget.cartoon.name,
                                        year: widget.cartoon.year,
                                        rating: widget.cartoon.rating,
                                        title: widget.cartoon.title,
                                        imgUrl: widget.cartoon.imgUrl,
                                        videoUrl: widget.cartoon.videoUrl,
                                        path: '',
                                      );
                                      bool res = DownloadManager.instance
                                          .downloadMovie(cartoon);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.green,
                                          content: Text(
                                            res
                                                ? 'Movie successfully added to downloads'.tr()
                                                : "Already in progress or multiple movies are being downloaded".tr(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      IconlyLight.download,
                                      color: Colors.red,
                                      size: 28,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      await Share.share(
                                          '${widget.cartoon.name} \nYear: ${widget.cartoon.year} | Rating: ${widget.cartoon.rating}\n\nWatch in WatchMe! \nhttps://play.google.com/store/apps/details?id=com.watch.me');
                                    },
                                    icon: const Icon(
                                      Icons.share,
                                      color: Colors.red,
                                      size: 28,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(
                left: 12,
                right: 12,
                top: 8,
                bottom: 10,
              ),
              color: const Color(0xff38404b),
              child: Text(
                widget.cartoon.title,
                style: TextStyle(
                  color: Colors.grey.shade300,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: height * 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Padding(
                    padding:const EdgeInsets.only(
                      left: 16,
                      bottom: 12,
                    ),
                    child: Text(
                      "Recommended".tr(),
                      style:const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        if (context
                                .watch<MoviesProvider>()
                                .cartoons[index]
                                .name !=
                            widget.cartoon.name) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CartoonScreen(
                                    cartoon: context
                                        .watch<MoviesProvider>()
                                        .cartoons[index],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                left: index == 0 ? 16 : 8,
                                right: 8,
                              ),
                              //height: height * 0.3,
                              width: MediaQuery.of(context).size.width * 0.32,
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Stack(
                                children: [
                                  Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: CachedNetworkImage(
                                        height: height * 0.35,
                                        fit: BoxFit.cover,
                                        imageUrl: context
                                            .watch<MoviesProvider>()
                                            .cartoons[index]
                                            .imgUrl,
                                        placeholder: (context, url) =>
                                            Loading.loading(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(
                                          Icons.movie,
                                          size: 50,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        height: height * 0.3,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.32,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          //  crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(12),
                                                bottomLeft: Radius.circular(12),
                                              ),
                                              child: BackdropFilter(
                                                filter: ImageFilter.blur(
                                                  sigmaX: 15,
                                                  sigmaY: 15,
                                                ),
                                                child: Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 3,
                                                      right: 3,
                                                      top: 4,
                                                      bottom: 4,
                                                    ),
                                                    child: Text(
                                                      context
                                                          .watch<
                                                              MoviesProvider>()
                                                          .cartoons[index]
                                                          .name,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                      itemCount:
                          context.watch<MoviesProvider>().cartoons.length,
                    ),
                  )
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 100,
            ),
          )
        ],
      ),
    );
  }
}
