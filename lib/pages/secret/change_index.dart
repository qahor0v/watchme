import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_me/pages/home_page.dart';
import 'package:watch_me/providers/change_index_provider.dart';

class ChangeAppbarIndex extends StatefulWidget {
  const ChangeAppbarIndex({Key? key}) : super(key: key);

  @override
  State<ChangeAppbarIndex> createState() => _ChangeAppbarIndexState();
}

class _ChangeAppbarIndexState extends State<ChangeAppbarIndex> {
  TextEditingController movie = TextEditingController();
  TextEditingController serie = TextEditingController();
  TextEditingController cartoon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Hello Admin"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              children: [
                TextField(
                  controller: movie,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Movie "),
                ),
                TextField(
                  controller: serie,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Serie "),
                ),
                TextField(
                  controller: cartoon,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Cartoon "),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (serie.text.isNotEmpty &&
                        movie.text.isNotEmpty &&
                        cartoon.text.isNotEmpty) {
                      context
                          .read<IndexProvider>()
                          .updateIndex(
                            int.parse(movie.text),
                            int.parse(serie.text),
                            int.parse(cartoon.text),
                          )
                          .then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.green,
                            content: Text('All indexes updated'),
                          ),
                        );
                        Timer(const Duration(seconds: 3), () {
                          Navigator.pushReplacementNamed(context, HomePage.id);
                        });
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please, enter index'),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Update",
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
