class CryptoCurrency {
  String id;
  String symbol;
  String name;
  String image;
  double currentPrice;
  double marketCap;
  int marketCapRank;
  double? fullyDilutedValuation;
  double totalVolume;
  double high24h;
  double low24h;
  double priceChange24h;
  double priceChangePercentage24h;
  double marketCapChange24h;
  double marketCapChangePercentage24h;
  double circulatingSupply;
  double? totalSupply;
  double? maxSupply;
  double ath;
  double athChangePercentage;
  DateTime athDate;
  double atl;
  double atlChangePercentage;
  DateTime atlDate;
  ReturnOnInvestment? roi;
  DateTime lastUpdated;
  List<double> sparklineIn7d;

  CryptoCurrency({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.marketCap,
    required this.marketCapRank,
    this.fullyDilutedValuation,
    required this.totalVolume,
    required this.high24h,
    required this.low24h,
    required this.priceChange24h,
    required this.priceChangePercentage24h,
    required this.marketCapChange24h,
    required this.marketCapChangePercentage24h,
    required this.circulatingSupply,
    this.totalSupply,
    this.maxSupply,
    required this.ath,
    required this.athChangePercentage,
    required this.athDate,
    required this.atl,
    required this.atlChangePercentage,
    required this.atlDate,
    this.roi,
    required this.lastUpdated,
    required this.sparklineIn7d,
  });

  factory CryptoCurrency.fromJson(Map<String, dynamic> json) {
    return CryptoCurrency(
      id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
      image: json['image'],
      currentPrice: json['current_price'].toDouble(),
      marketCap: json['market_cap'].toDouble(),
      marketCapRank: json['market_cap_rank'],
      fullyDilutedValuation: json['fully_diluted_valuation']?.toDouble(),
      totalVolume: json['total_volume'].toDouble(),
      high24h: json['high_24h'].toDouble(),
      low24h: json['low_24h'].toDouble(),
      priceChange24h: json['price_change_24h'].toDouble(),
      priceChangePercentage24h: double.parse(json['price_change_percentage_24h'].toStringAsFixed(2)),
      marketCapChange24h: json['market_cap_change_24h'].toDouble(),
      marketCapChangePercentage24h: json['market_cap_change_percentage_24h'].toDouble(),
      circulatingSupply: json['circulating_supply'].toDouble(),
      totalSupply: json['total_supply']?.toDouble(),
      maxSupply: json['max_supply']?.toDouble(),
      ath: json['ath'].toDouble(),
      athChangePercentage: json['ath_change_percentage'].toDouble(),
      athDate: DateTime.parse(json['ath_date']),
      atl: json['atl'].toDouble(),
      atlChangePercentage: json['atl_change_percentage'].toDouble(),
      atlDate: DateTime.parse(json['atl_date']),
      roi: json['roi'] != null ? ReturnOnInvestment.fromJson(json['roi']) : null,
      lastUpdated: DateTime.parse(json['last_updated']),
      sparklineIn7d: List<double>.from(json['sparkline_in_7d']['price'].map((x) => x.toDouble())),
    );
  }
}

class ReturnOnInvestment {
  double times;
  String currency;
  double percentage;

  ReturnOnInvestment({required this.times, required this.currency, required this.percentage});

  factory ReturnOnInvestment.fromJson(Map<String, dynamic> json) {
    return ReturnOnInvestment(
      times: json['times'].toDouble(),
      currency: json['currency'],
      percentage: json['percentage'].toDouble(),
    );
  }
}