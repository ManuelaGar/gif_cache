class Gif {
  final String name;
  final double frames;

  Gif({
    this.name,
    this.frames,
  });

  String image(String n, double f) {
    return n + '_' + f.round().toString() + '.gif';
  }
}
