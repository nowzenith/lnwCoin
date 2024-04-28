class CryptoCurrency {
  String id;
  String symbol;
  String name;
  String image;
  double? currentPrice;
  double? marketCap;
  int? marketCapRank;
  double? fullyDilutedValuation;
  double? totalVolume;
  double? high24h;
  double? low24h;
  double? priceChange24h;
  double? priceChangePercentage24h;
  double? marketCapChange24h;
  double? marketCapChangePercentage24h;
  double? circulatingSupply;
  double? totalSupply;
  double? maxSupply;
  double? ath;
  double? athChangePercentage;
  DateTime? athDate;
  double? atl;
  double? atlChangePercentage;
  DateTime? atlDate;
  ReturnOnInvestment? roi;
  DateTime? lastUpdated;
  List<double> sparklineIn7d;
  String get displayMarketCapRank => marketCapRank?.toString() ?? "-";

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
    // print("Parsing: ${json['id']}");  // Log the ID being parsed

    try {
      return CryptoCurrency(
        id: json['id'],
        symbol: json['symbol'].length > 4 ? '${json['symbol'].substring(0, 3)}..' : json['symbol'],
        name: json['name'],
        image: json['image'],
        currentPrice: json['current_price']?.toDouble() ?? 0.0,
        marketCap: json['market_cap']?.toDouble() ?? 0.0,
        marketCapRank: json['market_cap_rank'] as int?,
        fullyDilutedValuation: json['fully_diluted_valuation']?.toDouble(),
        totalVolume: json['total_volume']?.toDouble() ?? 0.0,
        high24h: json['high_24h']?.toDouble() ?? 0.0,
        low24h: json['low_24h']?.toDouble() ?? 0.0,
        priceChange24h: json['price_change_24h']?.toDouble() ?? 0.0,
        priceChangePercentage24h:
            json['price_change_percentage_24h']?.toDouble() ?? 0.0,
        marketCapChange24h: json['market_cap_change_24h']?.toDouble() ?? 0.0,
        marketCapChangePercentage24h:
            json['market_cap_change_percentage_24h']?.toDouble() ?? 0.0,
        circulatingSupply: json['circulating_supply']?.toDouble() ?? 0.0,
        totalSupply: json['total_supply']?.toDouble(),
        maxSupply: json['max_supply']?.toDouble(),
        ath: json['ath']?.toDouble() ?? 0.0,
        athChangePercentage: json['ath_change_percentage']?.toDouble() ?? 0.0,
        athDate: json['ath_date'] != null
            ? DateTime.parse(json['ath_date'])
            : DateTime.now(),
        atl: json['atl']?.toDouble() ?? 0.0,
        atlChangePercentage: json['atl_change_percentage']?.toDouble() ?? 0.0,
        atlDate: json['atl_date'] != null
            ? DateTime.parse(json['atl_date'])
            : DateTime.now(),
        roi: json['roi'] != null
            ? ReturnOnInvestment.fromJson(json['roi'])
            : null,
        lastUpdated: json['last_updated'] != null
            ? DateTime.parse(json['last_updated'])
            : DateTime.now(),
        sparklineIn7d: json['sparkline_in_7d'] != null
            ? List<double>.from(
                json['sparkline_in_7d']['price'].map((x) => x.toDouble()))
            : [],
      );
    } catch (e) {
      print('General parsing failure: $e');
      print('Failed to parse currency: ${json['id']} with error: $e');
      rethrow; // To allow upstream error handling
    }
  }
}

class ReturnOnInvestment {
  double times;
  String currency;
  double percentage;

  ReturnOnInvestment(
      {required this.times, required this.currency, required this.percentage});

  factory ReturnOnInvestment.fromJson(Map<String, dynamic> json) {
    return ReturnOnInvestment(
      times: json['times'].toDouble(),
      currency: json['currency'],
      percentage: json['percentage'].toDouble(),
    );
  }
}
