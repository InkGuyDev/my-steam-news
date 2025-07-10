class Noticia {
  final String gid;
  final String title;
  final String url;
  final String date;
  final String? image;
  final String feedLabel;
  final bool? favorite;

  Noticia({
    required this.gid,
    required this.title,
    required this.url,
    required this.date,
    this.image,
    required this.feedLabel,
    this.favorite,
  });

  factory Noticia.fromJson(Map<String, dynamic> json) {
    return Noticia(
      gid: json['gid'] ?? '',
      title: json['title'] ?? '',
      url: json['url'] ?? '',
      date:
          DateTime.fromMillisecondsSinceEpoch(
            (json['date'] ?? 0) * 1000,
          ).toString(),
      feedLabel: json['feedlabel'] ?? '',
    );
  }
}
