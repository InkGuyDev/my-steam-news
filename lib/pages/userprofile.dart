import 'package:flutter/material.dart';


class UserProfilePage extends StatelessWidget{
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        backgroundColor: const Color.fromARGB(255, 11, 40, 64),
        titleTextStyle: TextStyle(fontSize: 25),
      ),
      body: Center(
        child: Text('Page en development process . . . papu', style: TextStyle(color: Colors.white),),
      ),
    );
  }
}