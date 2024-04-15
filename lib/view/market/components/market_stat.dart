import 'package:flutter/material.dart';

class MarketStatsWidget extends StatelessWidget {
  const MarketStatsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
              child: MarketStatCard(
            title: 'Market Cap',
            value: '\$2.55 T',
            change: '+30.42%',
          )),
          Expanded(
              child: MarketStatCard(
                  title: 'Volume', value: '\$79.78 B', change: '+24.43%')),
          Expanded(
              child: MarketStatCard(
                  title: 'Dominance', value: '51.63%', change: 'BTC')),
        ],
      ),
    );
  }
}

class MarketStatCard extends StatelessWidget {
  final String title;
  final String value;
  final String change;

  const MarketStatCard({
    Key? key,
    required this.title,
    required this.value,
    required this.change,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 170, 0, 28),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,
              style: const TextStyle(color: Colors.white, fontSize: 14)),
          const SizedBox(height: 2),
          Text(value,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
          const SizedBox(height: 2),
          Text(change,
              style: const TextStyle(color: Colors.white, fontSize: 14)),
        ],
      ),
    );
  }
}