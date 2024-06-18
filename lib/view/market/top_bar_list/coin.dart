import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:lnwCoin/model/crypto_model.dart';
import 'package:lnwCoin/service/coingecko/coingecko_api.dart';
import 'package:lnwCoin/utils/extensions/lottie_extension.dart';
import 'package:lnwCoin/view/trade/trade_view.dart';
import 'package:lnwCoin/view_model/market_view_model.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:chart_sparkline/chart_sparkline.dart';

part '../components/market_data_card.dart';

class CoinPage extends StatefulWidget {
  const CoinPage({super.key});

  @override
  State<CoinPage> createState() => _CoinPageState();
}

class _CoinPageState extends State<CoinPage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  Timer? _timer; // Define a Timer object
  late Future<List<CryptoCurrency>> futureCurrencies;

  @override
  void initState() {
    print("coin_view");
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));
    futureCurrencies = CoinGeckoApi().fetchCurrencies(); // Initialize data fetch on load
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
    return Consumer<MarketViewModel>(
      builder: (context, marketViewModel, child) {
        // _timer = Timer.periodic(const Duration(seconds: 300), (timer) async {
        //   try {
        //     await marketViewModel.getMarketData();
        //     setState(() {});
        //   } catch (e) {
        //     print(e);
        //   }
        // });
        return FutureBuilder<List<CryptoCurrency>>(
          future: futureCurrencies,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<CryptoCurrency> coins = snapshot.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header for columns
                  Container(
                    height: 50,
                    child: const Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Card(
                        color: Color.fromARGB(53, 30, 42, 56),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Center(
                                  child: Text(
                                    'Coin',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Center(
                                  child: Text(
                                    '7d Chart',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Center(
                                  child: Text(
                                    'Price',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Center(
                                  child: Text(
                                    'Change',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Content
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return _MarketDataCard(
                          marketViewModel: marketViewModel,
                          index: index,
                          coins: coins,
                          function: () {
                            _timer?.cancel();
                          },
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 6),
                      itemCount: coins.length,
                    ),
                  ),
                ],
              );
            }
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
          },
        );
      },
    );
  }
}
