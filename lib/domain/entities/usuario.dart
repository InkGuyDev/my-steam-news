class Tactica {
  final int? id;
  final String titulo;
  final String descripcion;
  final String formacion;

  Tactica({
    this.id,
    required this.titulo,
    required this.descripcion,
    required this.formacion,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'descripcion': descripcion,
      'formacion': formacion,
    };
  }

  static Tactica fromMap(Map<String, dynamic> map) {
    return Tactica(
      id: map['id'],
      titulo: map['titulo'],
      descripcion: map['descripcion'],
      formacion: map['formacion'],
    );
  }
}
