class Exchange {
  String? id;
  String? name;
  int? yearEstablished;
  String? country;
  String? description;
  String? url;
  String? image;
  bool? hasTradingIncentive;
  int? trustScore;
  int? trustScoreRank;
  double? tradeVolume24hBtc;
  double? tradeVolume24hBtcNormalized;

  Exchange({
    this.id,
    this.name,
    this.yearEstablished,
    this.country,
    this.description,
    this.url,
    this.image,
    this.hasTradingIncentive,
    this.trustScore,
    this.trustScoreRank,
    this.tradeVolume24hBtc,
    this.tradeVolume24hBtcNormalized,
  });

  factory Exchange.fromJson(Map<String, dynamic> json) {
    return Exchange(
      id: json['id'] as String?,
      name: json['name'] as String?,
      yearEstablished: json['year_established'] as int?,
      country: json['country'] as String?,
      description: json['description'] as String? ?? "",
      url: json['url'] as String?,
      image: json['image'] as String?,
      hasTradingIncentive: json['has_trading_incentive'] as bool?,
      trustScore: json['trust_score'] as int?,
      trustScoreRank: json['trust_score_rank'] as int?,
      tradeVolume24hBtc: (json['trade_volume_24h_btc'] as num?)?.toDouble(),
      tradeVolume24hBtcNormalized: (json['trade_volume_24h_btc_normalized'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'year_established': yearEstablished,
      'country': country,
      'description': description,
      'url': url,
      'image': image,
      'has_trading_incentive': hasTradingIncentive,
      'trust_score': trustScore,
      'trust_score_rank': trustScoreRank,
      'trade_volume_24h_btc': tradeVolume24hBtc,
      'trade_volume_24h_btc_normalized': tradeVolume24hBtcNormalized,
    };
  }
}
