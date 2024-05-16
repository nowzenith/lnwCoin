import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lnwCoin/model/crypto_model.dart';
import 'package:lnwCoin/model/search_model.dart';

class CoinGeckoApi {
  static const String baseUrl = 'https://pro-api.coingecko.com/api/v3';
  static const Map<String, String> headers = {
    'accept': 'application/json',
    'x-cg-pro-api-key': 'CG-bdPgXL3cWbb2TbopKgcj8FDC'
  };

  // Get markets
  Future<List<CryptoCurrency>> fetchCurrencies() async {
    var url = Uri.parse(
        '$baseUrl/coins/markets?vs_currency=usd&sparkline=true&precision=2');
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> currenciesJson = json.decode(response.body);
      List<CryptoCurrency> currencies =
          currenciesJson.map((json) => CryptoCurrency.fromJson(json)).toList();
      return currencies;
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Get markets
  Future<List<CryptoCurrency>> fetchCategoryCoin(String category) async {
    print(category);
    var encodedCategory = Uri.encodeComponent(category);
    var url = Uri.parse(
        '$baseUrl/coins/markets?vs_currency=usd&category=$encodedCategory&sparkline=true&precision=2');
    var response = await http.get(url, headers: headers);
    print(response.statusCode);

    if (response.statusCode == 200) {
      List<dynamic> currenciesJson = json.decode(response.body);
      List<CryptoCurrency> currencies =
          currenciesJson.map((json) => CryptoCurrency.fromJson(json)).toList();
      return currencies;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<Search>> searchCurrencies(String search) async {
    var url = Uri.parse('$baseUrl/search?query=$search');
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
        final parsed = (json.decode(response.body)['coins'] as List)
            .map((item) => Search.fromJson(item))
            .toList();
        return parsed;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<dynamic>> fetchCategories() async {
      String apiEndpoint = "$baseUrl/coins/categories";
    var url = Uri.parse(apiEndpoint);
    var response = await http.get(url,headers: headers);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return [{}];
    }
  }

  Future<List<dynamic>> fetchNft() async {
      String apiEndpoint = "$baseUrl/nfts/markets";
    var url = Uri.parse(apiEndpoint);
    var response = await http.get(url,headers: headers);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return [{"e":response.statusCode}];
    }
  }

  Future<List<dynamic>> fetchExchange() async {
      String apiEndpoint = "$baseUrl/exchanges";
    var url = Uri.parse(apiEndpoint);
    var response = await http.get(url,headers: headers);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return [{"e":response.statusCode}];
    }
  }

  // Add more methods for other endpoints
}
