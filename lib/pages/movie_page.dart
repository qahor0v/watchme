import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:watch_me/models/movie_model.dart';
import 'package:watch_me/player/player.dart';
import 'package:watch_me/providers/movies_provider.dart';
import 'package:watch_me/screens/loading_widget.dart';
import 'package:watch_me/screens/movie_screen.dart';
import '../providers/download_manager.dart';

class MoviePage extends StatefulWidget {
  static const String id = "page";

  const MoviePage({required this.movie, super.key});

  final Document movie;

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  PageController controller = PageController();
  bool showInfo = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    String genre = '';

    if (widget.movie.map['movie']['isThriller']) {
      genre = " Thriller";
    }
    if (widget.movie.map['movie']['isHorror']) {
      genre = " Horror";
    }
    if (widget.movie.map['movie']['isAction']) {
      genre = " Action";
    }
    if (widget.movie.map['movie']['isComedic']) {
      genre = " Comedy";
    }
    if (widget.movie.map['movie']['isFantastic']) {
      genre = " Fantastic";
    }
    if (widget.movie.map['movie']['isDrama']) {
      genre = " Drama";
    }

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
                    imageUrl: widget.movie.map['movie']['imgUrl'],
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
                              setState(
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Player(
                                        vd_url: widget.movie.map['movie']
                                            ['videoUrl'],
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
                                  widget.movie.map['movie']['name'],
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
                                  widget.movie.map['movie']['year'].toString(),
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
                                  widget.movie.map['movie']['rating']
                                      .toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
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
                                const SizedBox(
                                  width: 5,
                                ),
                                const Icon(
                                  IconlyBold.video,
                                  color: Colors.red,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  genre,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
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
                                children: const [
                                  Icon(
                                    Icons.info_outline,
                                    color: Colors.red,
                                  ),
                                  Text(
                                    " About ",
                                    style: TextStyle(
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
                                      MovieModel movie = MovieModel(
                                          id: widget.movie.id,
                                          name: widget.movie.map['movie']
                                              ['name'],
                                          year: widget.movie.map['movie']
                                              ['year'],
                                          rating: widget.movie.map['movie']
                                              ['rating'],
                                          title: widget.movie.map['movie']
                                              ['title'],
                                          imgUrl: widget.movie.map['movie']
                                              ['imgUrl'],
                                          videoUrl: widget.movie.map['movie']
                                              ['videoUrl'],
                                          path: "");

                                      bool res = DownloadManager.instance
                                          .downloadMovie(movie);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.green,
                                          content: Text(
                                            res
                                                ? 'Movie successfully added to downloads'
                                                : "Already in progress or multiple movies are being downloaded",
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
                                    onPressed: () async  {
                                      await Share.share(
                                          '${widget.movie.map['movie']['name']} \nYear: ${widget.movie.map['movie']['year']} | Rating: ${widget.movie.map['movie']['rating']}\n\nWatch in WatchMe! \nhttps://fluttuz.t.me');
                                    },
                                    icon: const Icon(
                                      Icons.share,
                                      color: Colors.red,
                                      size: 28,
                                    ),
                                  ),
                                ],
                              )
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
                widget.movie.map['movie']['title'],
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
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 16,
                      bottom: 12,
                    ),
                    child: Text(
                      "Recommended",
                      style: TextStyle(
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
                        if(context
                            .watch<MoviesProvider>()
                            .movies[index].id != widget.movie.id){
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => MovieScreen(
                                    movie: context
                                        .watch<MoviesProvider>()
                                        .movies[index],
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
                                            .movies[index]
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
                                        width: MediaQuery.of(context).size.width *
                                            0.32,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          //  crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                              const BorderRadius.only(
                                                bottomRight: Radius.circular(12),
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
                                                          .watch<MoviesProvider>()
                                                          .movies[index]
                                                          .name,
                                                      textAlign: TextAlign.center,
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
                          context.watch<MoviesProvider>().movies.length - 4,
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
