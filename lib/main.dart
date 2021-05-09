import 'package:flutter/material.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
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
  String currentGif = 'no';
  double frameNum = 14.0;

  String gifPath;

  void initState() {
    controller = GifController(vsync: this);
    super.initState();
  }

  playGif(String gifToPlay) async {
    controller.value = 0;
    controller.animateTo(frameNum - 1,
        duration: Duration(milliseconds: (160 * (frameNum - 1)).toInt()));
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
            CachedNetworkImage(
              placeholder: (context, url) => CircularProgressIndicator(),
              imageUrl: gifPath,
            ),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  gifPath =
                      'https://firebasestorage.googleapis.com/v0/b/app-lsc-7310d.appspot.com/o/antecedentes_familiares_23.gif?alt=media';
                });
                playGif(currentGif);
              },
              child: Container(
                color: Colors.blueGrey,
                padding: EdgeInsets.all(5.0),
                child: Text(
                  'Download Gif 1',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  gifPath =
                      'https://firebasestorage.googleapis.com/v0/b/app-lsc-7310d.appspot.com/o/antecedentes_ginecobstetricos_25.gif?alt=media';
                });
                playGif(currentGif);
              },
              child: Container(
                color: Colors.blueGrey,
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

/*Card(
              child: GifImage(
                controller: controller,
                image: AssetImage('images/${currentGif}_$frameNum.gif'),
              ),
              elevation: 7,
            ),*/
/*CachedNetworkImage(
              imageUrl:
                  'https://firebasestorage.googleapis.com/v0/b/app-lsc-7310d.appspot.com/o/${currentGif}_${frameNum.toInt()}.gif?alt=media',
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      colorFilter:
                          ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
                ),
              ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),*/
