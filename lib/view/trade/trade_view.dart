import 'dart:ui';
import 'package:lnwCoin/model/candle_model.dart';
import 'package:lnwCoin/service/coingecko/coingecko_api.dart';
import 'package:lnwCoin/view/trade/components/chart2.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:lnwCoin/model/watchlistProvider.dart';
import '../../utils/constants.dart';
import '../../utils/extensions/lottie_extension.dart';


part 'components/price_label.dart';
part 'components/app_bar.dart';
part 'components/info_body.dart';


class TradeView extends StatefulWidget {
  const TradeView(
      {super.key,
      required this.id,
      required this.symbol,});
  final String id;
  final String symbol;

  @override
  State<TradeView> createState() => _TradeViewState();
}

class _TradeViewState extends State<TradeView> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Future<dynamic> futureTradeViewModel;

  @override
  void initState() {
    print("trade_view");
    futureTradeViewModel = CoinGeckoApi().fetchTradeViewModel(widget.id);
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImage(),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: FutureBuilder<dynamic>(
                future: futureTradeViewModel,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
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
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}',style: TextStyle(color: Colors.white),));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No data available'));
                  } else {
                    // print("Here:");
                    // print(widget.id);
                    return Column(
                      children: [
                        AppBarWithStar(symbol: widget.symbol,id: widget.id),
                        // Image.asset(
                        //   "assets/icon/960x960.png",
                        //   height: 100,
                        // ),
                        _PriceLabel(price: snapshot.data.usdPrice,price_change_percentage_24h: snapshot.data.price_change_percentage_24h,),
                        Chart2(name: snapshot.data.symbol),
                        // _InfoBody(candle: candle),
                        // _TradeButtons(
                        //     index: widget.index,
                        //     symbol: widget.symbol,
                        //     tradeViewModel: widget.tradeViewModel,
                        //     marketViewModel: widget.marketViewModel,
                        //     walletViewModel: widget.walletViewModel)
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}