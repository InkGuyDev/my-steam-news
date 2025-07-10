import 'package:flutter/material.dart';
import 'package:my_steam_news/widgets/games_card_format.dart';

// Funciones que muestran el contenido en pantalla
// Para mostrar las noticias de los juegos principales del usuario
Widget yourGamesPageShow(int listGameCount) {
  return ListView.builder(
    itemCount: listGameCount,
    itemBuilder: (context, index) {
      return Padding(padding: const EdgeInsets.all(8.0), child: cardFormat());
    },
  );
}
