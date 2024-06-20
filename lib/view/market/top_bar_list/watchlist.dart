import 'dart:async';

import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lnwCoin/model/crypto_model.dart';
import 'package:lnwCoin/service/coingecko/coingecko_api.dart';
import 'package:lnwCoin/utils/extensions/lottie_extension.dart';
import 'package:lnwCoin/view/mywallet/wallet_view.dart';
import 'package:lnwCoin/view/trade/trade_view.dart';
import 'package:lnwCoin/view_model/bottom_bar_view_model.dart';
import 'package:lnwCoin/view_model/market_view_model.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:lnwCoin/model/watchlistProvider.dart';


class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  Timer? _timer; // Define a Timer object
  late Future<List<CryptoCurrency>> futureCurrencies;
  @override
  void initState() {
    print("coin_view");
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));
    futureCurrencies = CoinGeckoApi().fetchWatchlist(watchListProvider().watchlist);  // Initialize data fetch on load
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
    final bottomBarViewModel =
        Provider.of<BottomBarViewModel>(context, listen: false);
    if (watchListProvider().watchlist.isNotEmpty) {
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
                children: [
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
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return MarketDataCard(
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
    else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.star,
              size: 100.0,
              color: Colors.amber,
            ),
            // You would usually load an actual image instead of an Icon
            const Text(
              'Your watchlist is empty',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const Text(
              'Start building your watchlist by clicking button below',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20.0), // Spacing
            ElevatedButton(
              onPressed: () {
                bottomBarViewModel.changePage(2);
              },
              child: const Text('Add Coins'),
            ),
            TextButton(
              onPressed: () {
                bottomBarViewModel.changePage(3);
              },
              child: const Text('Log in'),
            )
          ],
        ),
      );
    }

  }
}

class MarketDataCard extends StatelessWidget {
  const MarketDataCard(
      {required this.marketViewModel,
      required this.index,
      required this.coins,
      required this.function});
  final MarketViewModel marketViewModel;
  final int index;
  final List<CryptoCurrency> coins;
  final Function function;

  @override
  Widget build(BuildContext context) {
    print(coins[index].symbol);
    final bool isMinus =
        coins[index].priceChangePercentage24h.toString().startsWith('-');
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: InkWell(
          onTap: () {
            function();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TradeView(id: coins[index].id,symbol: coins[index].symbol,)),
            );
          },
          child: Card(
              color: Color(0x1E2A38).withOpacity(0.5),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Center(
                          child: Row(
                            children: [
                              SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: Image.network(coins[index].image)),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                coins[index].symbol.toUpperCase(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                        )),
                    Expanded(
                      flex: 3,
                      child: Center(
                        child: Container(
                          height: 50,
                          child: Sparkline(
                            data: coins[index].sparklineIn7d,
                            useCubicSmoothing: true,
                            cubicSmoothingFactor: 0.2,
                            lineGradient: isMinus
                                ? const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Colors.redAccent, Colors.red])
                                : const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Colors.greenAccent, Colors.green]),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Center(
                        child: Text(
                          coins[index].currentPrice != null
                              ? "\$${NumberFormat('#,##0.##', 'en_US').format(coins[index].currentPrice)}"
                              : "\$-", // Handles null case by displaying a placeholder
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Container(
                          height: 30,
                          width: 60,
                          decoration: BoxDecoration(
                            color: isMinus
                                ? const Color.fromARGB(255, 232, 22, 64)
                                : const Color.fromARGB(255, 4, 209, 109),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: isMinus
                                ? Text(
                                    coins[index].priceChangePercentage24h !=
                                            null
                                        ? coins[index]
                                            .priceChangePercentage24h!
                                            .toStringAsFixed(2)
                                        : '', // Format to two decimal places if not null, else provide an empty string
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : Text(
                                    coins[index].priceChangePercentage24h !=
                                            null
                                        ? '+${coins[index].priceChangePercentage24h!.toStringAsFixed(2)}'
                                        : '', // Format to two decimal places if not null, else provide an empty string
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        )),
                  ],
                ),
              )),
        ));
  }
}
