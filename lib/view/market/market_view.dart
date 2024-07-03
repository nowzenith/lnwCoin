import 'package:carousel_slider/carousel_slider.dart';
import 'package:lnwCoin/utils/dummy/dummy_news.dart';
import 'package:lnwCoin/view/internet/no_internet.dart';
import 'package:lnwCoin/view/market/components/Topbar.dart';
import 'package:lnwCoin/view/market/components/market_stat.dart';
import 'package:lnwCoin/view/market/top_bar_list/99_RWA_Coin/rwa_coin.dart';
import 'package:lnwCoin/view/market/top_bar_list/categories/categories.dart';
import 'package:lnwCoin/view/market/top_bar_list/Derivatives/Derivatives.dart';
import 'package:lnwCoin/view/market/top_bar_list/coin.dart';
import 'package:lnwCoin/view/market/top_bar_list/exchange/exchange.dart';
import 'package:lnwCoin/view/market/top_bar_list/nft/nft.dart';
import 'package:lnwCoin/view/market/top_bar_list/overview.dart';
import 'package:lnwCoin/view/market/top_bar_list/watchlist.dart';
import 'package:lnwCoin/view_model/market_view_model.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'dart:async';
import '../../utils/constants.dart';
part 'components/news_carousel.dart';
part 'components/app_bar.dart';

class MarketView extends StatefulWidget {
  const MarketView({super.key});

  @override
  State<MarketView> createState() => _MarketViewState();
}

class _MarketViewState extends State<MarketView> with TickerProviderStateMixin {
  bool? _isConnected;
  Timer? _timer;

  Future<void> _checkInternetConnection() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (mounted) {
      // Check if the widget is still in the widget tree
      setState(() {
        _isConnected = result;
      });
    }
    if (!result) {
      Future.delayed(const Duration(seconds: 5), () {
        // This block of code will be executed after a 2-second delay.
        if (mounted) {
          // Check again before making recursive call
          _checkInternetConnection();
        }
      });
    }
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      _checkInternetConnection();
    }
  }

  late TabController _tabController;
  final List<Widget> pages = [
    const CoinPage(),
    WatchlistPage(),
    OverviewPage(),
    const NftPage(),
    const ExchangePage(),
    const DerivativesPage(),
    const CategoriesPage(),
    const Rwa_Coin(),
  ];

  @override
  void initState() {
    print("market_view");
    super.initState();
    _tabController = TabController(length: 8, vsync: this);
    _tabController.addListener(_handleTabSelection);
    _checkInternetConnection();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _tabController.removeListener(_handleTabSelection);
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImage(),
        Scaffold(
          appBar: const _AppBar(),
          backgroundColor: Color.fromARGB(255, 24, 24, 24),
          body: Column(
            children: [
              const MarketStatsWidget(),
              TopBarWidget(tabController: _tabController),
              const SizedBox(
                height: 14,
              ),
              // const CoinPage()
              _isConnected == null
                  ? const Text('Checking connection...',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ))
                  : _isConnected!
                      ? Expanded(
                          child: TabBarView(
                              controller: _tabController, children: pages))
                      : const No_Internet_Page()
            ],
          ),
        ),
      ],
    );
  }
}
