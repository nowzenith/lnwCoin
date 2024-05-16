class NFT {
  final String id;
  final String contractAddress;
  final String assetPlatformId;
  final String name;
  final String symbol;
  final String image;
  final String description;
  final String nativeCurrency;
  final String nativeCurrencySymbol;
  final double floorPriceUsd;
  final double marketCapUsd;
  final double volume24hUsd;
  final double floorPriceInUsd24hPercentageChange;
  final double floorPriceUsd24hPercentageChange;
  final double marketCapUsd24hPercentageChange;
  final double volume24hUsdPercentageChange;
  final double numberOfUniqueAddresses;
  final double numberOfUniqueAddresses24hPercentageChange;
  final double volumeInUsd24hPercentageChange;
  final double totalSupply;
  final double oneDaySales;
  final double oneDaySales24hPercentageChange;
  final double oneDayAverageSalePrice;
  final double oneDayAverageSalePrice24hPercentageChange;

  NFT({
    required this.id,
    required this.contractAddress,
    required this.assetPlatformId,
    required this.name,
    required this.symbol,
    required this.image,
    required this.description,
    required this.nativeCurrency,
    required this.nativeCurrencySymbol,
    required this.floorPriceUsd,
    required this.marketCapUsd,
    required this.volume24hUsd,
    required this.floorPriceInUsd24hPercentageChange,
    required this.floorPriceUsd24hPercentageChange,
    required this.marketCapUsd24hPercentageChange,
    required this.volume24hUsdPercentageChange,
    required this.numberOfUniqueAddresses,
    required this.numberOfUniqueAddresses24hPercentageChange,
    required this.volumeInUsd24hPercentageChange,
    required this.totalSupply,
    required this.oneDaySales,
    required this.oneDaySales24hPercentageChange,
    required this.oneDayAverageSalePrice,
    required this.oneDayAverageSalePrice24hPercentageChange,
  });

  factory NFT.fromJson(Map<String, dynamic> json) {
    return NFT(
      id: json['id'],
    contractAddress: json['contract_address'] ?? "",
    assetPlatformId: json['asset_platform_id'] ?? "",
    name: json['name'] ?? "",
    symbol: json['symbol'] ?? "",
    image: json['image']['small'] ?? "",
    description: json['description'] ?? "",
    nativeCurrency: json['native_currency'] ?? "",
    nativeCurrencySymbol: json['native_currency_symbol'] ?? "",
    floorPriceUsd: (json['floor_price']['usd'] as num?)?.toDouble() ?? 0.0,
    marketCapUsd: (json['market_cap']['usd'] as num?)?.toDouble() ?? 0.0,
    volume24hUsd: (json['volume_24h']['usd'] as num?)?.toDouble() ?? 0.0,
    floorPriceInUsd24hPercentageChange: (json['floor_price_in_usd_24h_percentage_change'] as num?)?.toDouble() ?? 0.0,
    floorPriceUsd24hPercentageChange: (json['floor_price_24h_percentage_change']['usd'] as num?)?.toDouble() ?? 0.0,
    marketCapUsd24hPercentageChange: (json['market_cap_24h_percentage_change']['usd'] as num?)?.toDouble() ?? 0.0,
    volume24hUsdPercentageChange: (json['volume_24h_percentage_change']['usd'] as num?)?.toDouble() ?? 0.0,
    numberOfUniqueAddresses: (json['number_of_unique_addresses'] as num?)?.toDouble() ?? 0.0,
    numberOfUniqueAddresses24hPercentageChange: (json['number_of_unique_addresses_24h_percentage_change'] as num?)?.toDouble() ?? 0.0,
    volumeInUsd24hPercentageChange: (json['volume_in_usd_24h_percentage_change'] as num?)?.toDouble() ?? 0.0,
    totalSupply: json['total_supply'],
    oneDaySales: json['one_day_sales'],
    oneDaySales24hPercentageChange: (json['one_day_sales_24h_percentage_change'] as num?)?.toDouble() ?? 0.0,
    oneDayAverageSalePrice: (json['one_day_average_sale_price'] as num?)?.toDouble() ?? 0.0,
    oneDayAverageSalePrice24hPercentageChange: (json['one_day_average_sale_price_24h_percentage_change'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
