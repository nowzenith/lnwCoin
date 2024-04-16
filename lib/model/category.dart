class CryptoCategory {
  final String id;
  final String name;
  final double marketCap;
  final double marketCapChange24h;
  final String content;
  final List<String> top3Coins;
  final double volume24h;
  final DateTime updatedAt;

  CryptoCategory({
    required this.id,
    required this.name,
    required this.marketCap,
    required this.marketCapChange24h,
    required this.content,
    required this.top3Coins,
    required this.volume24h,
    required this.updatedAt,
  });

  factory CryptoCategory.fromJson(Map<String, dynamic> json) {
    return CryptoCategory(
      id: json['id'],
      name: json['name'],
      marketCap: json['market_cap'],
      marketCapChange24h: json['market_cap_change_24h'],
      content: json['content'],
      top3Coins: List<String>.from(json['top_3_coins']),
      volume24h: json['volume_24h'],
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
