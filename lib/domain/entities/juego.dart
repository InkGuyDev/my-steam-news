class Juego {
  final int? id;
  final String titulo;

  Juego({this.id, required this.titulo});

  Map<String, dynamic> toMap() {
    return {'id': id, 'titulo': titulo};
  }

  static Juego fromMap(Map<String, dynamic> map) {
    return Juego(id: map['id'], titulo: map['titulo']);
  }
}
