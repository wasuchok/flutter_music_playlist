import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_playlist/widgets/lyrices.dart';
import 'package:flutter_music_playlist/widgets/song.dart';
import 'package:http/http.dart' as http;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  var apiUrl = "https://67fcd1601f8b41c816879f7d.mockapi.io/api/v1/music";
  bool isPlaying = false;
  List<Map<String, dynamic>> music = [];
  Map<String, dynamic> musicPlaying = {};

  void getMusic() async {
    try {
      var response = await http.get(Uri.parse(apiUrl));
      final List<Map<String, dynamic>> decodedList =
          List<Map<String, dynamic>>.from(jsonDecode(response.body));

      setState(() {
        music =
            decodedList.map((song) => {...song, 'isPlaying': false}).toList();
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    getMusic();
    _audioPlayer.onPlayerComplete.listen((event) async {
      await playNext();
    });
  }

  Future<void> playNext() async {
    int current = music.indexWhere((song) => song['isPlaying'] == true);
    if (current != -1 && current < music.length - 1) {
      int nextIndex = current + 1;
      await stopMusic();
      print('file music/${music[nextIndex]['music']}');

      playMusic(
        'music/${music[nextIndex]['music']}',
        music[nextIndex],
        nextIndex,
      );
    } else {
      await stopMusic();
    }

    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  void playMusic(String song, Map<String, dynamic> data, int index) async {
    await _audioPlayer.play(AssetSource(song));
    setState(() {
      isPlaying = true;
      musicPlaying = data;
      findMusicIsTrue();

      music[index]['isPlaying'] = true;
    });
  }

  Future<void> stopMusic() async {
    await _audioPlayer.stop();
    setState(() {
      isPlaying = false;
    });
  }

  void show() async {
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return DefaultTabController(
              length: 2,
              child: Container(
                color: const Color.fromARGB(255, 6, 34, 58),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 60),
                      Row(
                        children: [
                          Image.network(
                            musicPlaying['image'],
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                musicPlaying['name'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                musicPlaying['genre'],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (isPlaying) {
                                    pauseMusic();
                                  } else {
                                    resumeMusic();
                                  }

                                  setModalState(() {});
                                },
                                icon: Icon(
                                  isPlaying ? Icons.pause : Icons.play_arrow,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  playNext();
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.play_lesson),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      TabBar(
                        tabs: [Tab(text: 'Up NEXT'), Tab(text: 'LYRICS')],
                        indicatorColor: Colors.white,
                        labelColor: Colors.white,
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [Song(music: music), Lyrices(music: music)],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void pauseMusic() async {
    await _audioPlayer.pause();
    setState(() {
      isPlaying = false;
    });
  }

  void resumeMusic() async {
    await _audioPlayer.resume();
    setState(() {
      isPlaying = true;
    });
  }

  void findMusicIsTrue() {
    for (int i = 0; i < music.length; i++) {
      music[i]['isPlaying'] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'My Playlist',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: music.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> data = music[index];
                return ListTile(
                  leading: Image.network(data['image']),
                  title: Text(data['name']),
                  subtitle: Text(data['genre']),
                  trailing: IconButton(
                    onPressed: () {
                      playMusic('music/${data['music']}', data, index);
                    },
                    icon: Icon(Icons.play_arrow),
                  ),
                );
              },
            ),
          ),
          if (isPlaying)
            BottomAppBar(
              child: GestureDetector(
                onTap: () {
                  show();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.network(
                        musicPlaying['image'],
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 15),
                      Flexible(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                musicPlaying['name'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Text(
                                musicPlaying['genre'],
                                style: TextStyle(fontSize: 13),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          stopMusic();
                        },
                        icon: Icon(Icons.stop),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
