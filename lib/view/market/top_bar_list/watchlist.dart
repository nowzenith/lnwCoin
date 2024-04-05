import 'package:flutter/material.dart';

class WatchlistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.star,
            size: 100.0,
            color: Colors.amber,
          ),
          // You would usually load an actual image instead of an Icon
          Text(
            'Your watchlist is empty',
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          Text(
            'Start building your watchlist by clicking button below',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20.0), // Spacing
          ElevatedButton(
            onPressed: () {
              // Implement your add coins action
            },
            child: Text('Add Coins'),
          ),
          TextButton(
            onPressed: () {
              // Implement your log in action
            },
            child: Text('Log in'),
          ),
        ],
      ),
    );
  }
}
