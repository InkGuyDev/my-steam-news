class Noticia {
  final int? gid;
  final String titulo;
  final String url;
  final String formacion;

  Noticia({
    this.gid,
    required this.titulo,
    required this.url,
    required this.formacion,
  });

  Map<String, dynamic> toMap() {
    return {'gid': gid, 'titulo': titulo, 'url': url, 'formacion': formacion};
  }

  static Noticia fromMap(Map<String, dynamic> map) {
    return Noticia(
      gid: map['gid'],
      titulo: map['titulo'],
      url: map['url'],
      formacion: map['formacion'],
    );
  }
}
