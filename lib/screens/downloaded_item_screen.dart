import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:watch_me/models/history_model.dart';
import 'package:watch_me/models/movie_model.dart';
import 'package:watch_me/player/player_file.dart';
import 'package:watch_me/screens/loading_widget.dart';
import 'package:watch_me/services/preferences_services.dart';

class DownloadedItem extends StatelessWidget {
  const DownloadedItem({required this.movie, Key? key}) : super(key: key);
  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        var mov = HistoryModel(
          id: movie.id,
          name: movie.name,
          path: movie.path,
          url: movie.videoUrl,
          imgUrl: movie.imgUrl,
          isDownloaded: true,
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PlayerLocal(path: movie.path),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(
          left: 12,
          right: 12,
          top: 8,
        ),
        padding: const EdgeInsets.only(
          left: 8,
          right: 8,
          top: 8,
          bottom: 8,
        ),
        height: h * 0.18,
        width: w,
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            SizedBox(
              width: h * 0.16,
              height: h * 0.16,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: movie.imgUrl,
                  placeholder: (context, url) => Loading.loading(),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.movie,
                    size: 50,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Text(
                            "Downloaded ",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Icon(
                            Icons.done,
                            color: Colors.green,
                          )
                        ],
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        child: const Icon(Icons.delete, color: Colors.red),
                        onTap: () {
                          Preference.deleteMovie(movie);
                          ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(
                              backgroundColor: Colors.red,
                              content: Text('Movie successfully deleted!'.tr()),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
