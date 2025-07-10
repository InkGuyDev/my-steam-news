import 'package:flutter/material.dart';

Color colorCards = Colors.blue;
TextStyle cardTitleTextStyle = TextStyle(fontSize: 30);

//Formato de la Card que muestra la noticia
Card cardFormat() {
  return Card(
    elevation: 4,
    color: colorCards,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: InkWell(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [SizedBox(width: 10), Text('Publisher de la noticia')],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('Titulo', style: cardTitleTextStyle)],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [SizedBox(width: 10), Text('Imagen')],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(width: 10),
              Text('Fecha'),
              Spacer(),
              IconButton(onPressed: () {}, icon: Icon(Icons.share, size: 20)),
            ],
          ),
        ],
      ),
    ),
  );
}
