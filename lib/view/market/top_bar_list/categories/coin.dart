import 'dart:async';

import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:lnwCoin/model/category.dart';
import 'package:lnwCoin/model/crypto_model.dart';
import 'package:lnwCoin/model/market_model.dart';
import 'package:lnwCoin/service/coingecko/coingecko_api.dart';
import 'package:lnwCoin/utils/extensions/lottie_extension.dart';
import 'package:lnwCoin/view_model/market_view_model.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
part 'market_data_card.dart';

class Cate_coin_page extends StatefulWidget {
  final CryptoCategory category;
  const Cate_coin_page({super.key, required this.category});

  @override
  State<Cate_coin_page> createState() => _Cate_coin_pageState();
}

class _Cate_coin_pageState extends State<Cate_coin_page>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  Timer? _timer; // Define a Timer object
  late Future<List<CryptoCurrency>> futureCurrencies;
  @override
  void initState() {
    print("category_coin_view");
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));
    futureCurrencies = CoinGeckoApi()
        .fetchCategoryCoin(widget.category.id); // Initialize data fetch on load
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer?.cancel(); // Cancel the Timer when disposing the widget
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: const Color.fromARGB(255, 24, 24, 24),
    appBar: AppBar(
      backgroundColor: const Color.fromARGB(255, 24, 24, 24),
      title: const Text('รายละเอียดหมวดหมู่'),
      titleTextStyle: const TextStyle(color: Colors.white),
      iconTheme: const IconThemeData(color: Colors.white),
      actions: [
        IconButton(
          icon: const Icon(Icons.share),
          onPressed: () {
            // Logic to share cryptocurrency details
          },
        ),
      ],
    ),
    body: Column(
      children: [
        MyCustomWidget(category: widget.category), // Static widget
        const SizedBox(height: 15,),
        Expanded(
          child: FutureBuilder<List<CryptoCurrency>>(
            future: futureCurrencies,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List<CryptoCurrency> coins = snapshot.data;
                return ListView.separated(
                  itemBuilder: (context, index) {
                    return _MarketDataCard(
                      index: index,
                      coins: coins,
                      function: () {
                        _timer?.cancel();
                      },
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 6),
                  itemCount: coins.length,
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Center(
                  child: LottieBuilder.asset(
                    LottieEnum.loading.lottiePath,
                    height: 80,
                    width: 80,
                    repeat: true,
                    animate: true,
                    controller: _animationController,
                    onLoaded: (p0) {
                      _animationController.forward();
                    },
                  ),
                );
              }
            },
          ),
        ),
      ],
    ),
  );
  }
}

class MyCustomWidget extends StatelessWidget {
  final CryptoCategory category;
  const MyCustomWidget({
    Key? key,
    required this.category,
  }) : super(key: key);

  String getFormattedMarketCap(num marketCap) {
    return NumberFormat('#,##0', 'en_US').format(marketCap);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            category.name,
            style: const TextStyle(color: Colors.white, fontSize: 24),
          ),
          const SizedBox(height: 8),
          // const Text(
          //   '1194 โพสต์',
          //   style: TextStyle(color: Colors.white54, fontSize: 18),
          // ),
          const Divider(color: Colors.grey),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'ราคาตลาด',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              Text(
                '\$${getFormattedMarketCap(category.marketCap)}',
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'ราคา 24 ชม. ที่ผ่านมา',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              Text(
                '\$${getFormattedMarketCap(category.volume24h)}',
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
          // const SizedBox(height: 8),
          //  Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: <Widget>[
          //     Text(
          //       'การเปลี่ยนแปลงราคาตลาด',
          //       style: TextStyle(color: Colors.red, fontSize: 18),
          //     ),
          //     Text(
          //       '▼ 0.84%',
          //       style: TextStyle(color: Colors.red, fontSize: 18),
          //     ),
          //   ],
          // ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'การเปลี่ยนแปลงราคาตลาด 24 ชม.',
                style: TextStyle(
                    color: category.marketCapChange24h >= 0
                        ? Colors.green
                        : Colors.red,
                    fontSize: 18),
              ),
              Text(
                '${category.marketCapChange24h.toStringAsFixed(2)}%',
                style: TextStyle(
                    color: category.marketCapChange24h >= 0
                        ? Colors.green
                        : Colors.red,
                    fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(// foreground (text) color
                ),
            onPressed: () {},
            child: const Text('แจ้งเมื่อมีเทรน'),
          ),
        ],
      ),
    );
  }
}
