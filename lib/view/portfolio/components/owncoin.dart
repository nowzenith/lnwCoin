
import 'package:flutter/material.dart';
import 'package:lnwCoin/model/market_model.dart';
import 'package:lnwCoin/utils/extensions/lottie_extension.dart';
import 'package:lnwCoin/view_model/market_view_model.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
part 'package:lnwCoin/view/portfolio/components/market_data_card.dart';

class OwnCoinPage extends StatefulWidget {
  const OwnCoinPage({super.key});

  @override
  State<OwnCoinPage> createState() => _OwnCoinPageState();
}

class _OwnCoinPageState extends State<OwnCoinPage> with TickerProviderStateMixin {
  late AnimationController _animationController;
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MarketViewModel>(
      builder: (context, marketViewModel, child) {
        return StreamBuilder(
          stream: marketViewModel.getOwncoinData(),
          builder: (context, AsyncSnapshot snapshot) {
            print(snapshot.data);
            if (snapshot.hasData) {
              List<Market> coins = snapshot.data;
              return ListView.separated(
                itemBuilder: (context, index) {
                  return _MarketDataCard(
                    marketViewModel: marketViewModel,
                    index: index,
                    coins: coins,
                    function: () {
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
