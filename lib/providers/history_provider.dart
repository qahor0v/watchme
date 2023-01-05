// ignore_for_file: unrelated_type_equality_checks

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:watch_me/models/history_model.dart';

class  HistoryProvider extends ChangeNotifier {
  final List<HistoryModel> hs = [];

  List<HistoryModel> get history => hs;

  Future<void> getHistory() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      final movies = preferences.getStringList('history');
      for (final mov in movies!) {
        hs.add(HistoryModel.fromJson(jsonDecode(mov)));
      }
    } catch (e) {
      log('$e');
    }
    notifyListeners();
  }

  Future<void> onAddHistory(HistoryModel movie) async {
    hs.clear();
    List<String> list = [];
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      final movies = preferences.getStringList('history');
      for (final mov in movies!) {
        hs.add(HistoryModel.fromJson(jsonDecode(mov)));
      }
    } catch (e) {
      log('$e');
    }
    hs.add(movie);

    for (HistoryModel model in hs) {
      list.add(jsonEncode(model.toJson()));
    }

    preferences.setStringList('history', list).then((value) {
      value ? log("Added to history") : log('Save to history: Unknown error!');
    });
    hs.clear();
    notifyListeners();
  }

  Future<void> onADeleteHistory(HistoryModel movie) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> list = [];
    for (int i = 0; i < hs.length; i++) {
      if (movie.id == hs[i].id) {
        hs.removeAt(i);
      }
    }
    for (HistoryModel model in hs) {
      list.add(jsonEncode(model.toJson()));
    }

    preferences.setStringList('history', list).then((value) {
      value ? log(">>>>> Deleted from history") : log('>>>>> Do not to history: Unknown error!');
    });
    notifyListeners();
  }

  Future<void> onAClearHistory() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    hs.clear();
    preferences.remove('history');
    notifyListeners();
  }
}
