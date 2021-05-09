import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:giphy_app/constants/gif_bank.dart';

GifBank gifBank = GifBank();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Giphy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  GifController controller;
  String title = 'Waiting to download';
  String gifPath = '';
  String gifUrl = '';
  var bytes;

  bool isGif1Downloaded = false;
  bool isGif2Downloaded = false;

  void initState() {
    controller = GifController(vsync: this);
    super.initState();
  }

  playGif(String gifToPlay, bool isLocal) async {
    double frameNum = 0.0;
    controller.value = 0;

    gifBank.gifs.forEach((gif) {
      if (gifToPlay == gif.name) {
        if (isLocal) {
          setState(() => gifPath = 'images/${gif.image(gif.name, gif.frames)}');
        }

        frameNum = gif.frames - 1;
        controller.animateTo(frameNum,
            duration: Duration(milliseconds: (140 * frameNum).toInt()));
      }
    });
  }

  Widget loadingWidget() {
    if (title == 'Downloading...') {
      return CircularProgressIndicator();
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giphy'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(child: Text(title)),
            SizedBox(
              height: 20.0,
            ),
            gifPath != ''
                ? Card(
                    child: GifImage(
                      controller: controller,
                      image: gifPath.contains('images/')
                          ? AssetImage(gifPath)
                          : MemoryImage(bytes),
                    ),
                    elevation: 7,
                  )
                : loadingWidget(),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () {
                playGif('no', true);
              },
              child: Container(
                color: Colors.blue,
                padding: EdgeInsets.all(5.0),
                child: Text(
                  'Local Gif',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () async {
                setState(() {
                  imageCache.clear();
                  title = 'Downloading...';
                  gifUrl =
                      'https://firebasestorage.googleapis.com/v0/b/app-lsc-7310d.appspot.com/o/antecedentes_familiares_23.gif?alt=media';
                });
                var fetchedFile =
                    await DefaultCacheManager().getSingleFile(gifUrl);
                setState(() {
                  title = 'File fetched: ${fetchedFile.path}';
                  gifPath = fetchedFile.path;
                  bytes = fetchedFile.readAsBytesSync();
                });

                if (!isGif1Downloaded) {
                  setState(() {
                    isGif1Downloaded = true;
                  });
                  Timer(const Duration(seconds: 2),
                      () => playGif('antecedentes_familiares', false));
                }
                playGif('antecedentes_familiares', false);
              },
              child: Container(
                color: Colors.blueGrey,
                padding: EdgeInsets.all(5.0),
                child: Text(
                  'Download Gif',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () async {
                setState(() {
                  imageCache.clear();
                  title = 'Downloading...';
                  gifUrl =
                      'https://firebasestorage.googleapis.com/v0/b/app-lsc-7310d.appspot.com/o/antecedentes_ginecobstetricos_25.gif?alt=media';
                });
                var fetchedFile =
                    await DefaultCacheManager().getSingleFile(gifUrl);
                setState(() {
                  title = 'File fetched: ${fetchedFile.path}';
                  gifPath = fetchedFile.path;
                  bytes = fetchedFile.readAsBytesSync();
                });

                if (!isGif2Downloaded) {
                  setState(() {
                    isGif2Downloaded = true;
                  });
                  Timer(const Duration(seconds: 2),
                      () => playGif('antecedentes_ginecobstetricos', false));
                }
                playGif('antecedentes_ginecobstetricos', false);
              },
              child: Container(
                color: Colors.green,
                padding: EdgeInsets.all(5.0),
                child: Text(
                  'Download Gif 2',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
