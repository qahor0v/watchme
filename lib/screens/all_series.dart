import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_me/providers/movies_provider.dart';
import 'package:watch_me/screens/loading_widget.dart';
import 'package:watch_me/screens/serie_screen.dart';

class AllSeries extends StatelessWidget {
  const AllSeries({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff38404b).withOpacity(0.8),
      appBar: AppBar(
        backgroundColor: const Color(0xff38404b),
        title: const Text("All Series"),
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
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    var serie = context.watch<MoviesProvider>().series[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SerieScreen(serie: serie),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                          left: 6,
                          right: 6,
                          top: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 15,
                              sigmaY: 15,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 8,
                                right: 8,
                                top: 6,
                                bottom: 6,
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      height:
                                      MediaQuery.of(context).size.height *
                                          0.18,
                                      width:
                                      MediaQuery.of(context).size.height *
                                          0.18,
                                      fit: BoxFit.cover,
                                      imageUrl: serie.imgUrl,
                                      placeholder: (context, url) =>
                                          Loading.loading(),
                                      errorWidget: (context, url, error) =>
                                      const Icon(
                                        Icons.movie,
                                        size: 50,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width -
                                        MediaQuery.of(context).size.height *
                                            0.24,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            const SizedBox(width: 8),
                                            Text(
                                              serie.name,
                                              maxLines: 2,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                left: 8,
                                                right: 8,
                                                top: 2,
                                                bottom: 8,
                                              ),
                                              padding: const EdgeInsets.only(
                                                left: 8,
                                                right: 8,
                                                top: 6,
                                                bottom: 6,
                                              ),
                                              decoration: BoxDecoration(
                                                color: const Color(0xff38404b),
                                                borderRadius:
                                                BorderRadius.circular(5),
                                              ),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    serie.rating.toString(),
                                                    maxLines: 2,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                    ),
                                                  ),
                                                  const Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                left: 8,
                                                right: 8,
                                                top: 2,
                                                bottom: 8,
                                              ),
                                              padding: const EdgeInsets.only(
                                                left: 8,
                                                right: 8,
                                                top: 6,
                                                bottom: 6,
                                              ),
                                              decoration: BoxDecoration(
                                                color: const Color(0xff38404b),
                                                borderRadius:
                                                BorderRadius.circular(5),
                                              ),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    serie.year.toString(),
                                                    maxLines: 2,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                    ),
                                                  ),
                                                  const Icon(
                                                    Icons
                                                        .calendar_month_outlined,
                                                    color: Colors.amber,
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  // 40 list items
                  childCount: context.watch<MoviesProvider>().series.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
