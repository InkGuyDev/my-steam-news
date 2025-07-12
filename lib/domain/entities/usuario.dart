class User {
  final int? id;
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
    final response = json['response'];
    final gamesList = json['response']['games'] as List<dynamic>? ?? [];

    final ids = gamesList.map((game) => game['appid'] as int).toList();
    final count = response['game_count'] ?? ids.length;

    return User(idsGames: ids, gameCount: count);
  }
}
