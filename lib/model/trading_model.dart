class Trending {
  List<Coin> coins;

  Trending({required this.coins});

  factory Trending.fromJson(Map<String, dynamic> json) {
    return Trending(
      coins: List<Coin>.from(json['coins'].map((coin) => Coin.fromJson(coin['item']))),
    );
  }
}

class Coin {
  String id;
  String name;
  String symbol;
  String thumb;
  double marketCapRank;

  Coin({
    required this.id,
    required this.name,
    required this.symbol,
    required this.thumb,
    required this.marketCapRank,
  });

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      id: json['id'],
      name: json['name'],
      symbol: json['symbol'],
      thumb: json['thumb'],
      marketCapRank: json['market_cap_rank'].toDouble(),
    );
  }
}
