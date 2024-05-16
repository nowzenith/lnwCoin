class FuturesExchange {
  String? name;
  String? id;
  double? openInterestBtc;
  String? tradeVolume24hBtc;
  int? numberOfPerpetualPairs;
  int? numberOfFuturesPairs;
  String? image;
  int? yearEstablished;
  String? country;
  String? description;
  String? url;

  FuturesExchange({
    this.name,
    this.id,
    this.openInterestBtc,
    this.tradeVolume24hBtc,
    this.numberOfPerpetualPairs,
    this.numberOfFuturesPairs,
    this.image,
    this.yearEstablished,
    this.country,
    this.description,
    this.url,
  });

  factory FuturesExchange.fromJson(Map<String, dynamic> json) {
    return FuturesExchange(
      name: json['name'] as String?,
      id: json['id'] as String?,
      openInterestBtc: (json['open_interest_btc'] as num?)?.toDouble(),
      tradeVolume24hBtc: json['trade_volume_24h_btc'] as String?,
      numberOfPerpetualPairs: json['number_of_perpetual_pairs'] as int?,
      numberOfFuturesPairs: json['number_of_futures_pairs'] as int?,
      image: json['image'] as String?,
      yearEstablished: json['year_established'] as int?,
      country: json['country'] as String?,
      description: json['description'] as String? ?? "",
      url: json['url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'open_interest_btc': openInterestBtc,
      'trade_volume_24h_btc': tradeVolume24hBtc,
      'number_of_perpetual_pairs': numberOfPerpetualPairs,
      'number_of_futures_pairs': numberOfFuturesPairs,
      'image': image,
      'year_established': yearEstablished,
      'country': country,
      'description': description,
      'url': url,
    };
  }
}