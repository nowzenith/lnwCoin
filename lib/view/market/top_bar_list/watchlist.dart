import 'package:flutter/material.dart';
import 'package:lnwCoin/view/mywallet/wallet_view.dart';
import 'package:lnwCoin/view_model/bottom_bar_view_model.dart';
import 'package:provider/provider.dart';

class WatchlistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bottomBarViewModel =
        Provider.of<BottomBarViewModel>(context, listen: false);
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
