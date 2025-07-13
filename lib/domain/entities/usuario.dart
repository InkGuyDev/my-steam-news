class User {
  int? id;
  final String? name;
  final String? profileUrl;
  final String? avatarUrl;
  final List<int> idsGames;
  final int gameCount;
  //final List<int> idsFavoriteGames;
  //final List<int> idsWishList;
  //final List<int> idsFollowList;

  User({
    this.id,
    this.name,
    this.profileUrl,
    this.avatarUrl,
    required this.idsGames,
    required this.gameCount,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    // Datos de juegos
    final response = json['response'];
    final gamesList = response['games'] as List<dynamic>?;

    if (gamesList != null) {
      final ids = gamesList.map((game) => game['appid'] as int).toList();
      final count = response['game_count'] ?? ids.length;

      return User(idsGames: ids, gameCount: count);
    }

    // Datos del perfil
    final players = response['players'] as List<dynamic>?;
    if (players != null && players.isNotEmpty) {
      final player = players.first;
      return User(
        name: player['personaname'],
        avatarUrl: player['avatarfull'],
        profileUrl: player['profileurl'],
        idsGames: [],
        gameCount: 0,
      );
    }

    return User(idsGames: [], gameCount: 0);
  }
}
