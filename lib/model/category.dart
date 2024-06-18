class CryptoCategory {
  final String id;
  final String name;
  final num marketCap;
  final num marketCapChange24h;
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
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unknown',
      marketCap: json['market_cap'] ?? 0,
      marketCapChange24h: json['market_cap_change_24h'] ?? 0,
      content: json['content'] ?? '',
      top3Coins: json['top_3_coins'] != null ? List<String>.from(json['top_3_coins']) : [],
      volume24h: (json['volume_24h'] as num?)?.toDouble() ?? 0.0,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'market_cap': marketCap,
      'market_cap_change_24h': marketCapChange24h,
      'content': content,
      'top_3_coins': top3Coins,
      'volume_24h': volume24h,
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
