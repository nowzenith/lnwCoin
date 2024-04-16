import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lnwCoin/model/crypto_model.dart';

class CoinGeckoApi {
  static const String baseUrl = 'https://pro-api.coingecko.com/api/v3';
  static const Map<String, String> headers = {
    'accept': 'application/json',
    'x-cg-pro-api-key': 'CG-bdPgXL3cWbb2TbopKgcj8FDC'
  };

  // Get markets
  Future<List<CryptoCurrency>> fetchCurrencies() async {
    var url = Uri.parse('$baseUrl/coins/markets?vs_currency=usd&sparkline=true&precision=2');
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> currenciesJson = json.decode(response.body);
      List<CryptoCurrency> currencies = currenciesJson.map((json) => CryptoCurrency.fromJson(json)).toList();
      return currencies;
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Get markets
  Future<List<CryptoCurrency>> fetchCategory(String category) async {
    var url = Uri.parse('$baseUrl/coins/categories?vs_currency=usd&sparkline=true&precision=2&category=$category');
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> currenciesJson = json.decode(response.body);
      List<CryptoCurrency> currencies = currenciesJson.map((json) => CryptoCurrency.fromJson(json)).toList();
      return currencies;
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Add more methods for other endpoints
}
