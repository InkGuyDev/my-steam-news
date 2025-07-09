class Noticia {
  final int? gid;
  final String title;
  final String url;
  final String image;
  final String feedLabel;
  final bool favorite;

  Noticia({
    this.gid,
    required this.title,
    required this.url,
    required this.image,
    required this.feedLabel,
    required this.favorite
  });

  Map<String, dynamic> toMap() {
    return {'gid': gid, 'title': title, 'url': url, 'image': image, 'feedLabel' : feedLabel, 'favorite' : favorite};
  }

  static Noticia fromMap(Map<String, dynamic> map) {
    return Noticia(
      gid: map['gid'],
      title: map['title'],
      url: map['url'],
      image: map['image'],
      feedLabel: map['feedLabel'],
      favorite: map['favorite'],
    );
  }
}
