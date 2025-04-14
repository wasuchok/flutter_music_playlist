import 'package:flutter/material.dart';

class Lyrices extends StatefulWidget {
  List<dynamic> music = [];
  Lyrices({super.key, required this.music});

  @override
  State<Lyrices> createState() => _LyricesState();
}

class _LyricesState extends State<Lyrices> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.music.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Image.network(widget.music[index]['image']),
          title: Text(
            widget.music[index]['name'],
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }
}
