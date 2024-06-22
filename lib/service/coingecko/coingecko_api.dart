import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lnwCoin/model/crypto_model.dart';
import 'package:lnwCoin/model/derivatives_model.dart';
import 'package:lnwCoin/model/search_model.dart';
import 'package:lnwCoin/model/tradeview_model.dart';
import 'package:lnwCoin/model/trading_model.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../view/market/top_bar_list/overview.dart';

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
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return [{}];
    }
  }

  Future<List<dynamic>> fetchNft() async {
    String apiEndpoint = "$baseUrl/nfts/markets";
    var url = Uri.parse(apiEndpoint);
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return [
        {"e": response.statusCode}
      ];
    }
  }

  Future<List<dynamic>> fetchExchange() async {
    String apiEndpoint = "$baseUrl/exchanges";
    var url = Uri.parse(apiEndpoint);
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return [
        {"e": response.statusCode}
      ];
    }
  }

  Future<TradeViewModel> fetchTradeViewModel(String name) async {
    String apiEndpoint = "$baseUrl/coins/$name";
    var url = Uri.parse(apiEndpoint);
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final jsonresponse = json.decode(response.body);
      print(jsonresponse['market_data']['low_24h']['usd'].toDouble());
      TradeViewModel tv = TradeViewModel(id: jsonresponse["id"], name: jsonresponse["name"], symbol: jsonresponse["symbol"], usdPrice: jsonresponse['market_data']['current_price']['usd'].toDouble(), high24h: jsonresponse['market_data']['high_24h']['usd'].toDouble(), low24h: jsonresponse['market_data']['low_24h']['usd'].toDouble(),price_change_percentage_24h: jsonresponse['market_data']['price_change_percentage_24h'].toDouble());
      return tv;
    } else {
      // Handle the error case by returning an empty list or throwing an exception
      throw Exception(
          'Failed to load exchanges with status code ${response.statusCode}');
    }
  }

  Future<List<dynamic>> fetchde() async {
    var url = Uri.parse('$baseUrl/derivatives/exchanges?per_page=100'); // Use the appropriate endpoint
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> marketDataJson = json.decode(response.body);
      return marketDataJson;
    } else {
      throw Exception('Failed to load market data');
    }
  }

  Future<double> fetchMarketCapChangePercentage() async {
    var url = Uri.parse('$baseUrl/global');
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body)['data'];
      double marketCapChangePercentage =
      responseData['market_cap_change_percentage_24h_usd'];
      return marketCapChangePercentage;
    } else {
      throw Exception('Failed to load market data');
    }
  }

  Future<List<ChartData>> fetchMarketCapChart() async {
    var url = Uri.parse('$baseUrl/global/market_cap_chart?days=1');
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData =
      json.decode(response.body)['market_cap_chart'];
      List<dynamic> marketCapData = responseData['market_cap'];

      List<ChartData> chartData = marketCapData.map((dataPoint) {
        int timestamp = dataPoint[0];
        double price = dataPoint[1].toDouble();
        DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);

        return ChartData(date, price);
      }).toList();

      return chartData;
    } else {
      print('Failed to load market data. Status Code: ${response.statusCode}');
      throw Exception('Failed to load market data');
    }
  }


  Future<List<CryptoCurrency>> fetchWatchlist(List<String> ids) async {
  String idsParam = ids.join('%2C');
  var url = Uri.parse(
      '$baseUrl/coins/markets?vs_currency=usd&sparkline=true&ids=$idsParam');
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



// Add more methods for other endpoints
}
