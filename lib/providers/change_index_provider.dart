import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:watch_me/models/cartoon_model.dart';
import 'package:watch_me/models/serie_model.dart';

class IndexProvider extends ChangeNotifier {
  final List<Document> _movies = [];
  final List<CartoonModel> _cartoons = [];
  final List<SerieModel> _series = [];

  List<Document> get movies => _movies;

  List<CartoonModel> get cartoons => _cartoons;

  List<SerieModel> get series => _series;

  Future getIndex() async {
    Document? mov;
    CartoonModel? cm;
    SerieModel? sm;

    CollectionReference map = Firestore.instance.collection("appbar");
    final data = await map.orderBy("index").get();
    int mIndex = data.first.map['index']['movie'];
    mov = _movies[mIndex];
    cm = _cartoons[data.first.map['index']['cartoon']];
    sm = _series[data.first.map['index']['serie']];

    _movies.clear();
    _cartoons.clear();
    _series.clear();

    _movies.add(mov);
    _cartoons.add(cm);
    _series.add(sm);
  }

  Future updateIndex(int movie, int serie, int cartoon) async {
    CollectionReference map = Firestore.instance.collection("appbar");
    map.document('YFSxJX5OuebxbypBSyeR').update({
      "index": {
        "serie": serie,
        "cartoon": cartoon,
        "movie": movie,
      }
    });
  }
}
