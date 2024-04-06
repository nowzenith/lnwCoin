import 'package:coingecko_api/coingecko_api.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:lnwCoin/model/market_model.dart';
import 'package:lnwCoin/utils/extensions/lottie_extension.dart';
import 'package:lnwCoin/view_model/market_view_model.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
part 'market_data_card.dart';


class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage>
    with TickerProviderStateMixin {
  late Future<List<dynamic>> _categoriesFuture;
  CoinGeckoApi api = CoinGeckoApi();
  late AnimationController _animationController;

  // Future<List<dynamic>?> trackerData() async {
  //   String apiEndpoint = "https://api.coingecko.com/api/v3/coins/categories";
  //   var url = Uri.parse(apiEndpoint);
  //   var response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     var res = response.body;
  //     cryptoList = cryptoTrackerFromJson(res);
  //     setState(() {
  //       cryptoList;
  //     });
  //     return cryptoList;
  //   } else {
  //     return null;
  //   }
  // }
  Future<List<dynamic>> fetchCategories() async {
      String apiEndpoint = "https://api.coingecko.com/api/v3/coins/categories";
    var url = Uri.parse(apiEndpoint);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return [{}];
    }
  }

  @override
  void initState() {
    print("categories_view");
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));
    _categoriesFuture = fetchCategories(); // Ensure the future is initialized here
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
        future: _categoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var category = snapshot.data![index];
                return CryptoCategoryCard(
                  name: category['name'],
                  marketCap: category['market_cap'],
                  marketCapChange: category['market_cap_change_24h'],
                  top3CoinsUrls: List<String>.from(category['top_3_coins']),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Center(child: Text('No categories available'));
          }
        },
      );
  }
}

class CryptoCategoryCard extends StatelessWidget {
  final String name;
  final num marketCap;
  final num marketCapChange;
  final List<String> top3CoinsUrls;

  const CryptoCategoryCard({
    Key? key,
    required this.name,
    required this.marketCap,
    required this.marketCapChange,
    required this.top3CoinsUrls,
  }) : super(key: key);

  String getFormattedMarketCap(num marketCap) {
    return NumberFormat('#,##0', 'en_US').format(marketCap);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[850], // Dark card background
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Market Cap: \$${getFormattedMarketCap(marketCap)}',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '24h Change: ${marketCapChange.toStringAsFixed(2)}%',
              style: TextStyle(
                color: marketCapChange >= 0 ? Colors.green : Colors.red,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: top3CoinsUrls.map((url) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Image.network(
                    url,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}