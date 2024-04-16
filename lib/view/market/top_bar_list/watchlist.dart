import 'package:flutter/material.dart';
import 'package:lnwCoin/view/mywallet/wallet_view.dart';

class WatchlistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              // Implement your add coins action
            },
            child: const Text('Add Coins'),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyWalletView()),
              );
            },
            child: const Text('Log in'),
          )
        ],
      ),
    );
  }
}
