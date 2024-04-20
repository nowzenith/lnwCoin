class Search {
  final String id;
  final String name;
  final String apiSymbol;
  final String symbol;
  final int marketCapRank;
  final String thumb;
  final String large;

  Search({
    required this.id,
    required this.name,
    required this.apiSymbol,
    required this.symbol,
    required this.marketCapRank,
    required this.thumb,
    required this.large,
  });

  factory Search.fromJson(Map<String, dynamic> json) {
    return Search(
      id: json['id'],
      name: json['name'],
      apiSymbol: json['api_symbol'],
      symbol: json['symbol'],
      marketCapRank: json['market_cap_rank'],
      thumb: json['thumb'],
      large: json['large'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'api_symbol': apiSymbol,
      'symbol': symbol,
      'market_cap_rank': marketCapRank,
      'thumb': thumb,
      'large': large,
    };
  }
}