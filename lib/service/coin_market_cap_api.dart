import 'package:http/http.dart' as http;
import 'dart:convert';

class CoinMarketCapApi {
  final String _apiKey = ""; // Your API key for CoinMarketCap
  final String _apiUrl = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest';

  CoinMarketCapApi();

  Future<List<dynamic>> getCryptoData() async {
    try {
      var response = await http.get(
        Uri.parse(_apiUrl),
        headers: {"X-CMC_PRO_API_KEY": _apiKey},
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        return jsonResponse['data'];
      } else {
        // Handle the case when the server returns a non-200 status code
        print('Failed to load data with status code: ${response.statusCode}');
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Handle any errors that occur during the HTTP request
      print(e.toString());
      throw Exception('Failed to load data');
    }
  }
}