import 'package:flutter/material.dart';

class Song extends StatefulWidget {
  List<dynamic> music = [];
  Song({super.key, required this.music});

  @override
  State<Song> createState() => _SongState();
}

class _SongState extends State<Song> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.music.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Stack(
            children: [
              Stack(
                children: [
                  Image.network(
                    widget.music[index]['image'],
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  if (widget.music[index]['isPlaying'] == true)
                    Container(
                      width: 50,
                      height: 50,
                      color: Colors.black.withOpacity(0.4),
                    ),
                ],
              ),
              if (widget.music[index]['isPlaying'] == true)
                Positioned(
                  bottom: 5,
                  top: 5,
                  right: 5,
                  left: 5,
                  child: Icon(Icons.equalizer, color: Colors.white, size: 20),
                ),
            ],
          ),
          title: Text(
            widget.music[index]['name'],
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            widget.music[index]['genre'],
            style: TextStyle(color: Colors.white60),
          ),
        );
      },
    );
  }
}
