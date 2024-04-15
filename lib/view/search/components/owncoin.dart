import 'package:flutter/material.dart';
import 'package:lnwCoin/model/market_model.dart';
import 'package:lnwCoin/service/coin_market_cap_api.dart';
import 'package:lnwCoin/utils/extensions/lottie_extension.dart';
import 'package:lnwCoin/view_model/market_view_model.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
part 'market_data_card.dart';

class OwnCoinPage extends StatefulWidget {
  final String searchQuery;
  const OwnCoinPage({super.key, required this.searchQuery});

  @override
  State<OwnCoinPage> createState() => _OwnCoinPageState();
}

class _OwnCoinPageState extends State<OwnCoinPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late List cryptoData;
  final CoinMarketCapApi apiService = CoinMarketCapApi();
  @override
  void initState() {
    print("coin_view");
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));
        this.loadCryptoData();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void loadCryptoData() async {
    try {
      var data = await apiService.getCryptoData();
      setState(() {
        cryptoData = data;
      });
    } catch (e) {
      // Handle the error state
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cryptoData == null ? 0 : cryptoData.length,
      itemBuilder: (BuildContext context, int index) {
        // Build your custom crypto card widget here
        // Use the cryptoData[index] to populate the card
        return Card(
          child: ListTile(
            leading: Image.network('...'), // Logo URL
            title: Text(cryptoData[index]['name']),
            subtitle: Text(
                '\$${cryptoData[index]['quote']['USD']['price'].toStringAsFixed(2)}'),
            trailing: Text(
                '${cryptoData[index]['quote']['USD']['percent_change_24h'].toStringAsFixed(2)}%'),
          ),
        );
      },
    );
  }
}
