import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_me/providers/history_provider.dart';

import 'loading_widget.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff38404b).withOpacity(0.8),
      appBar: AppBar(
        backgroundColor: const Color(0xff38404b),
        title: Text("History".tr()),
        actions: [
          IconButton(
            onPressed: () async {
              context.read<HistoryProvider>().onAClearHistory();
            },
            icon: const Icon(
              Icons.delete_sweep,
              color: Colors.red,
              size: 32,
            ),
          ),
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
          filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
          child: ListView.builder(
            itemBuilder: (context, index) {
              var movie = context.watch<HistoryProvider>().history[index];
              return Container(
                height: MediaQuery.of(context).size.height * 0.15,
                padding: const EdgeInsets.only(
                  left: 4,
                  right: 4,
                  top: 4,
                  bottom: 4,
                ),
                margin: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width * 0.36,
                        height: MediaQuery.of(context).size.height * 0.15,
                        imageUrl: movie.imgUrl,
                        placeholder: (context, url) => Loading.loading(),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.movie,
                          size: 50,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            movie.name,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  context
                                      .read<HistoryProvider>()
                                      .onADeleteHistory(movie)
                                      .then((value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(
                                            'Movie successfully deleted!'.tr()),
                                      ),
                                    );
                                  });
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 30,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: context.watch<HistoryProvider>().history.length,
          ),
        ),
      ),
    );
  }
}
