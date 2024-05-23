class TradeViewModel {
  final String id;
  final String name;
  final String symbol;
  final double usdPrice;
  final double high24h;
  final double low24h;
  final double price_change_percentage_24h;

  TradeViewModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.usdPrice,
    required this.high24h,
    required this.low24h,
    required this.price_change_percentage_24h,
  });

  factory TradeViewModel.fromJson(Map<String, dynamic> json) {
    return TradeViewModel(
      id: json['id'],
      name: json['name'],
      symbol: json['symbol'],
      usdPrice: json['market_data']['current_price']['usd'].toDouble(),
      high24h: json['market_data']['high_24h']['usd'].toDouble(),
      low24h: json['market_data']['low_24h']['usd'].toDouble(),
      price_change_percentage_24h: json['market_data']['price_change_percentage_24h'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'symbol': symbol,
      'usdPrice': usdPrice,
      'high24h': high24h,
      'low24h': low24h
    };
  }
  bool get isEmpty {
    return id.isEmpty && name.isEmpty && symbol.isEmpty && usdPrice == 0.0 && high24h == 0.0 && low24h == 0.0;
  }
}
