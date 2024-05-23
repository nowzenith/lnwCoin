class DerivativesModel {
  final String name;
  final String id;
  final double openInterestBtc;
  final double tradeVolume24hBtc;
  final int numberOfPerpetualPairs;
  final int numberOfFuturesPairs;
  final String image;
  final int? yearEstablished;
  final String? country;
  final String description;
  final String url;

  DerivativesModel({
    required this.name,
    required this.id,
    required this.openInterestBtc,
    required this.tradeVolume24hBtc,
    required this.numberOfPerpetualPairs,
    required this.numberOfFuturesPairs,
    required this.image,
    this.yearEstablished,
    this.country,
    required this.description,
    required this.url,
  });

  factory DerivativesModel.fromJson(Map<String, dynamic> json) {
    return DerivativesModel(
      name: json['name'] ?? '',
      id: json['id'] ?? '',
      openInterestBtc: (json['open_interest_btc'] ?? 0.0).toDouble(),
      tradeVolume24hBtc: double.tryParse(json['trade_volume_24h_btc']) ?? 0.0,
      numberOfPerpetualPairs: json['number_of_perpetual_pairs'] ?? 0,
      numberOfFuturesPairs: json['number_of_futures_pairs'] ?? 0,
      image: json['image'] ?? '',
      yearEstablished: json['year_established'],
      country: json['country'],
      description: json['description'] ?? '',
      url: json['url'] ?? '',
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
