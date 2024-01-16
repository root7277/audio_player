import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MusicApp(),
    );
  }
}

class MusicApp extends StatefulWidget {
  const MusicApp({super.key});

  @override
  State<MusicApp> createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {
  bool playing = false;
  IconData playBtn = Icons.play_arrow;

  // Audioplayer slideri uchun kerakli funksiyalar;

  late AudioPlayer _player;
  late AudioCache cache;

  Duration position = const Duration();
  Duration musicLength = const Duration();

  // sliderni yasaymiz;

  Widget slider() {
    return Slider.adaptive(
      activeColor: Colors.blue,
      inactiveColor: Colors.grey,
      value: position.inSeconds.toDouble(),
      max: musicLength.inSeconds.toDouble(),
      onChanged: (value) {
        seekToSec(value.toInt());
      },
    );
  }

  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    _player.seek(newPos);
  }

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    cache = AudioCache();
    cache.load('ex_odamlar.mp3');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 0, 93, 168),
              Color.fromARGB(255, 5, 44, 76),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 48.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Text(
                  'Music Beats',
                  style: TextStyle(fontSize: 38.0, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Text(
                  'Listen to yout favorite Music',
                  style: TextStyle(fontSize: 38.0, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              Center(
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    image: DecorationImage(
                      image: AssetImage('assets/image.jpg'),
                    ),
                  ),
                ),
              ),
              const Center(
                child: Text(
                  'Stargazer',
                  style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
              const SizedBox(height: 30.0),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${position.inMinutes}:${position.inSeconds.remainder(60)}"),
                          slider(),
                          Text("${musicLength.inMinutes}:${musicLength.inSeconds.remainder(60)}"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            iconSize: 45.0,
                            color: Colors.black,
                            onPressed: () {},
                            icon: const Icon(Icons.skip_previous),
                          ),
                          IconButton(
                            iconSize: 62.0,
                            color: Colors.black,
                            onPressed: () {
                              if (!playing) {
                                setState(() {
                                  playBtn = Icons.pause;
                                  playing = true;
                                });
                              } else {
                                setState(() {
                                  playBtn = Icons.play_arrow;
                                  playing = false;
                                });
                              }
                            },
                            icon: Icon(playBtn),
                          ),
                          IconButton(
                            iconSize: 45.0,
                            color: Colors.black,
                            onPressed: () {},
                            icon: const Icon(Icons.skip_next),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
