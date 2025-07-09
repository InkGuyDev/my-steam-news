import 'package:flutter/material.dart';

class OtherPage extends StatefulWidget{
  const OtherPage({super.key});

  @override
  State<OtherPage> createState() => _OtherPageState();
}

class _OtherPageState extends State<OtherPage>{

  @override
  Widget build(BuildContext context){
    return Center(
      child: DefaultTabController(
        length: 2, 
        child: Scaffold(
          appBar: PreferredSize(preferredSize:Size.fromHeight(60), 
            child: AppBar(
              bottom: const TabBar(
                tabs: [
                  Tab(text: 'Lista de desados'),
                  Tab(text: 'Seguidos'),
                ],
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Color.fromARGB(255, 250, 253, 255),
                labelColor: Color.fromARGB(255, 250, 253, 255),
              ),
              backgroundColor: const Color.fromARGB(253, 14, 56, 90),
            ),
          ),
          body: TabBarView(children: [
            wishListPageShow(),
            followedPageShow(),
          ])
        )
      ),
    );
  }
}


// Funciones que muestran el contenido en pantalla
// Para mostrar las noticias de los juegos principales del usuario
Widget wishListPageShow(){
  print('Estamos en la pagina de la lista de deseados del usuario');
  return Center(
    child: Text('Page in devolpment . . . papu', style: TextStyle(color: Colors.white)),
  );
}
// Para mostrar las noticias más recientes de varios juegos (populares o no)
Widget followedPageShow(){
  print('Estamos en la pagina de los juegos seguidos del usuario');
  return Center(
    child: Text('Page in devolpment . . . papu', style: TextStyle(color: Colors.white),),
  );
}
