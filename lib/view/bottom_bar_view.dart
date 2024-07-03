import 'package:lnwCoin/view/News/newspage.dart';
import 'package:lnwCoin/view/community/communitypage.dart';

import 'package:lnwCoin/view/market/market_view.dart';
import 'package:lnwCoin/view/mywallet/wallet_view.dart';
import 'package:lnwCoin/view/search/search_view.dart';

import 'package:lnwCoin/view_model/bottom_bar_view_model.dart';
import 'package:lnwCoin/view_model/market_view_model.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomBarView extends StatelessWidget {
  BottomBarView({super.key});

  final List<Widget> pages = [
    const MarketView(),
    NewsFeedPage(),
    const SearchPage(),
    const MyWalletView(),
    CommunityPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomBarViewModel()),
        ChangeNotifierProvider(create: (context) => MarketViewModel()),
      ],
      builder: (context, child) {
        return Consumer<BottomBarViewModel>(
          builder: (context, bottomBarViewModel, child) {
            return Scaffold(
              body: pages[bottomBarViewModel.index],  // Using the index from ViewModel
              backgroundColor: const Color.fromARGB(255, 24, 24, 24),
              bottomNavigationBar: CurvedNavigationBar(
                height: 70,
                index: bottomBarViewModel.index,
                backgroundColor: const Color.fromARGB(255, 24, 24, 24),
                buttonBackgroundColor: const Color.fromARGB(255, 170, 0, 28),
                color: const Color.fromARGB(255, 170, 0, 28),
                animationDuration: const Duration(milliseconds: 300),
                onTap: (value) {
                  bottomBarViewModel.changePage(value);  // Changing the page index
                },
                items: const <Widget>[
                  Icon(Icons.show_chart, size: 26, color: Colors.white),
                  Icon(Icons.newspaper, size: 26, color: Colors.white),
                  Icon(Icons.search, size: 26, color: Colors.white),
                  Icon(Icons.account_balance_wallet, size: 26, color: Colors.white),
                  Icon(Icons.people, size: 26, color: Colors.white),
                ],
              ),
            );
          },
        );
      },
    );
  }
}