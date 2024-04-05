import 'package:lnwCoin/view/News/newspage.dart';
import 'package:lnwCoin/view/community/communitypage.dart';

import 'package:lnwCoin/view/market/market_view.dart';
import 'package:lnwCoin/view/mywallet/wallet_view.dart';
import 'package:lnwCoin/view/search/search_view.dart';

import 'package:lnwCoin/view_model/bottom_bar_view_model.dart';
import 'package:lnwCoin/view_model/market_view_model.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class BottomBarView extends StatelessWidget {
  BottomBarView({super.key});

  final List<Widget> pages = [
    const MarketView(),
    NewsFeedPage(),
    const SearchPage(),
    const MyWalletView(),
    CommunityBlockPage(),
    // const WalletView(),
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
              body: pages[bottomBarViewModel.index],
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed, // Add this line
                backgroundColor: const Color.fromARGB(255, 21, 21, 21),
                elevation: 0,
                currentIndex: bottomBarViewModel.index,
                // selectedIconTheme:
                //     const IconThemeData(color: Colors.white, size: 26),
                // unselectedIconTheme:
                //     const IconThemeData(color: Colors.white, size: 26),
                selectedFontSize: 11,
                unselectedFontSize: 10,
                selectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.w600),
                selectedItemColor: Colors.green,
                unselectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.w600),
                unselectedItemColor: Colors.white,
                onTap: (value) {
                  bottomBarViewModel.changePage(value);
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.show_chart),
                    label: 'Markets',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.newspaper),
                    label: 'News',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: 'Search',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_balance_wallet),
                    label: 'Portfolio',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.people),
                    label: 'Community',
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
