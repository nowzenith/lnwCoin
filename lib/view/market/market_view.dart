import 'package:carousel_slider/carousel_slider.dart';
import 'package:lnwCoin/utils/dummy/dummy_news.dart';
import 'package:lnwCoin/view/market/components/Topbar.dart';
import 'package:lnwCoin/view/market/components/market_stat.dart';
import 'package:lnwCoin/view/market/top_bar_list/categories/categories.dart';
import 'package:lnwCoin/view/market/top_bar_list/chains/chains.dart';
import 'package:lnwCoin/view/market/top_bar_list/coin.dart';
import 'package:lnwCoin/view/market/top_bar_list/exchange/exchange.dart';
import 'package:lnwCoin/view/market/top_bar_list/nft/nft.dart';
import 'package:lnwCoin/view/market/top_bar_list/overview.dart';
import 'package:lnwCoin/view/market/top_bar_list/watchlist.dart';
import 'package:lnwCoin/view_model/market_view_model.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../utils/constants.dart';
part 'components/news_carousel.dart';
part 'components/app_bar.dart';

class MarketView extends StatefulWidget {
  const MarketView({super.key});

  @override
  State<MarketView> createState() => _MarketViewState();
}

class _MarketViewState extends State<MarketView> with TickerProviderStateMixin {
  late TabController _tabController;
  final List<Widget> pages = [
    const CoinPage(),
    WatchlistPage(),
    OverviewPage(),
    const NftPage(),
    const ExchangePage(),
    const ChainsPage(),
    const CategoriesPage(),
  ];

  @override
  void initState() {
    print("market_view");
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImage(),
        Scaffold(
          appBar: _AppBar(),
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              MarketStatsWidget(),
              TopBarWidget(tabController: _tabController),
              const SizedBox(
                height: 14,
              ),
              // const CoinPage()
              Expanded(
                  child:
                      TabBarView(controller: _tabController, children: pages)),
            ],
          ),
        ),
      ],
    );
  }
}



/*
StreamBuilder(
            stream: marketViewModel.getMarketData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List<Market> markets = snapshot.data;
                return Center(
                  child: Text(markets[0].symbol),
                );
              } else {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.greenAccent,
                ));
              }
            },
          );
 */
