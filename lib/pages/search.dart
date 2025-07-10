import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class GameSearch extends SearchDelegate<String> {
  final List<String> gamesNames;

  GameSearch(this.gamesNames);

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        systemOverlayStyle:
            colorScheme.brightness == Brightness.dark
                ? SystemUiOverlayStyle.light
                : SystemUiOverlayStyle.dark,
        backgroundColor:
            colorScheme.brightness == Brightness.dark ? Colors.white : const Color.fromARGB(255, 11, 40, 64),
        iconTheme: theme.primaryIconTheme.copyWith(color: Colors.white ),
        titleTextStyle: theme.textTheme.titleLarge,
        toolbarTextStyle: theme.textTheme.bodyMedium,
      ),
      inputDecorationTheme:
          searchFieldDecorationTheme ??
          InputDecorationTheme(
            hintStyle: searchFieldStyle ?? theme.inputDecorationTheme.hintStyle,
            border: InputBorder.none,
          ),
    );
  }

  @override
  String get searchFieldLabel => 'Buscar juego...';

  @override
  TextStyle? get searchFieldStyle => const TextStyle(
    color: Colors.white,
    fontSize: 18,
  );

  //Acciones del boton de la derecha
  @override
  List<Widget> buildActions(BuildContext context){
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      )
    ];
  }

  //Para volver y cerrar la busqueda
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, ''),
    );
  }


  //Resultados de la busqueda
  @override
  Widget buildResults(BuildContext context){
    final results = gamesNames.where((gameName) => gameName.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (_, index) => ListTile(
        title: Text(results[index]),
        onTap: () {
          close(context, results[index]);
        },
      )
    );
  }


  //Sugerencias en tiempo real
  @override
  Widget buildSuggestions(BuildContext context){
    final suggestions = gamesNames.where((gameName) => gameName.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (_, index) => ListTile(
        title: Text(suggestions[index], style: TextStyle(color: Colors.white),),
        onTap: () {
          query = suggestions[index]; 
          showSuggestions(context);       
        },
      ),
    );
  }
}

List<String> gamesToSearch = [
  'Half life',
  'Half mind eyes',
  'Dota',
  'Stardew Valley', 
  'Spiderman', 
  'Spider-man',
  'half life',
  'Team Fortress 2',
  'Fallout', 
  'Fallout tactics',
  'Fallout 2', 
  'Fallout 3',
  'Dead Cells',
  'Combo final', 
];


class SearchPage extends StatelessWidget{
  const SearchPage({super.key});

  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(const Color.fromARGB(255, 25, 68, 103),),
              foregroundColor: WidgetStateProperty.all(Colors.white),
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: GameSearch(gamesToSearch),
              );
            }, 
            child: Row(
              children: [
                Icon(Icons.search),
                SizedBox(width: 15,),
                Text('Buscar juego...'),
              ],
            ),
          ),
        backgroundColor: const Color.fromARGB(253, 14, 56, 90),
      ),
      body: Center(
        child: Text('Search Page on development process . . . papu', style: TextStyle(color: Colors.white),),
      ),
    );
  }
}