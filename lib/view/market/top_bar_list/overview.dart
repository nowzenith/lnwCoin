import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
// Additional packages for charts and indicators may be imported as needed.

class OverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      // Using ListView to allow scrolling
      children: <Widget>[
        HalvingCountdown(),
        SizedBox(height: 16),
        MarketCapChartWidget(),

        // ... other widgets ...
      ],
    );
  }
}

class HalvingCountdown extends StatelessWidget {
  // Mock data for countdown
  final int days = 25;
  final int hours = 22;
  final int minutes = 50;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Color(
            0xFF1A237E), // Dark blue color, replace with actual color code
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.monetization_on,
                color: Colors.orange), // BTC Icon, replace with actual BTC icon
            VerticalDivider(color: Colors.white54),
            Text(
              '$days days | $hours hours | $minutes mins',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            VerticalDivider(color: Colors.white54),
            IconButton(
              icon: Icon(Icons.settings, color: Colors.white),
              onPressed: () {
                // Handle settings tap
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MarketCapChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors
            .blueGrey[800], // Replace with the color that matches your theme
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
            '\$2.55 T',
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            '+9.32%', // You might want to make this dynamic based on data
            style: TextStyle(
                color: Colors.greenAccent,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          AspectRatio(
            aspectRatio: 1.7, // Aspect ratio of the chart
            child: LineChart(
              LineChartData(
                // You would need to set up your LineChartData here
                // This is a very basic setup. For detailed configuration,
                // refer to the fl_chart documentation
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      // Replace these with your data points
                      FlSpot(0, 3),
                      FlSpot(1, 2),
                      FlSpot(2, 5),
                      FlSpot(3, 3.1),
                      // etc...
                    ],
                    isCurved: true,
                    color: Colors.tealAccent,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
