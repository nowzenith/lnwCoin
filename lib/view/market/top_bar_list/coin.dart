import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lnwCoin/model/market_model.dart';
import 'package:lnwCoin/utils/extensions/lottie_extension.dart';
import 'package:lnwCoin/view_model/market_view_model.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

part '../components/market_data_card.dart';

class CoinPage extends StatefulWidget {
  const CoinPage({super.key});

  @override
  State<CoinPage> createState() => _CoinPageState();
}

class _CoinPageState extends State<CoinPage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  Timer? _timer; // Define a Timer object
  @override
  void initState() {
    print("coin_view");
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));
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
        _timer = Timer.periodic(const Duration(seconds: 300), (timer) async {
          try {
            await marketViewModel.getMarketData();
            setState(() {});
          } catch (e) {
            print(e);
          }
        });
        return StreamBuilder(
          stream: marketViewModel.getMarketData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<Market> coins = snapshot.data;
              return ListView.separated(
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
