import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lnwCoin/service/coingecko/coingecko_api.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class OverviewPage extends StatefulWidget {
  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  late Future<double> futureMarketCapChangePercentage;
  late Future<List<FlSpot>> futureMarketCapChart;

  @override
  void initState() {
    super.initState();

    futureMarketCapChangePercentage = CoinGeckoApi().fetchMarketCapChangePercentage();
    futureMarketCapChart = CoinGeckoApi().fetchMarketCapChart();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        HalvingCountdown(),
        SizedBox(height: 16),
        FutureBuilder<double>(
          future: futureMarketCapChangePercentage,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error fetching data: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final percent = snapshot.data!;
              return MarketCapChartWidget(
                futureMarketCapChart: futureMarketCapChart,
                percent: percent,
              );
            } else {
              return Text('No data available');
            }
          },
        ),
        // ... other widgets ...
      ],
    );
  }
}

class HalvingCountdown extends StatelessWidget {
  final int days = 25;
  final int hours = 22;
  final int minutes = 50;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 170, 0, 28),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.monetization_on, color: Colors.orange),
            VerticalDivider(color: Colors.white54),
            Text(
              '$days days | $hours hours | $minutes mins',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            VerticalDivider(color: Colors.white54),
          ],
        ),
      ),
    );
  }
}

class MarketCapChartWidget extends StatelessWidget {
  final Future<List<FlSpot>> futureMarketCapChart;
  final double percent;

  MarketCapChartWidget({required this.futureMarketCapChart, required this.percent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blueGrey[800],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Market Cap >',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          SizedBox(height: 4),
          Text(
            '\$2.55 T', // Replace with dynamic data if needed
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            '${percent.toStringAsFixed(2)}%',
            style: TextStyle(
                color: percent >= 0 ? Colors.greenAccent : Colors.redAccent,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          FutureBuilder<List<FlSpot>>(
            future: futureMarketCapChart,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return AspectRatio(
                  aspectRatio: 1.7,
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(show: false),
                      titlesData: FlTitlesData(show: false),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: snapshot.data!,
                          isCurved: true,
                          color: Colors.tealAccent,
                          dotData: FlDotData(show: false),
                          belowBarData: BarAreaData(show: false),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Text('No data available');
              }
            },
          ),
        ],
      ),
    );
  }
}
