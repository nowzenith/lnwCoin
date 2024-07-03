import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../service/coingecko/coingecko_api.dart';
import 'package:lnwCoin/utils/extensions/lottie_extension.dart';
import 'package:lottie/lottie.dart';


class ChartData {
  final DateTime date;
  final double price;

  ChartData(this.date, this.price);
}

class OverviewPage extends StatefulWidget {
  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage>
    with TickerProviderStateMixin {
  late Future<double> futureMarketCapChangePercentage;
  late Future<List<ChartData>> futureMarketCapChart;
  late TooltipBehavior _tooltipBehavior;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      header: "Market Cap",
    );
    futureMarketCapChangePercentage =
        CoinGeckoApi().fetchMarketCapChangePercentage();
    futureMarketCapChart = CoinGeckoApi().fetchMarketCapChart();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        // HalvingCountdown(),
        SizedBox(height: 16),
        FutureBuilder<double>(
          future: futureMarketCapChangePercentage,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: LottieBuilder.asset(
                  LottieEnum.loading.lottiePath,
                  height: 80,
                  width: 80,
                  repeat: true,
                  animate: true,
                  controller: _animationController,
                  onLoaded: (p0) {
                    _animationController.forward();
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error fetching data: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final percent = snapshot.data!;
              return MarketCapChartWidget(
                chartData: futureMarketCapChart,
                percent: percent,
                tool: _tooltipBehavior,
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
  final int days = 1395;
  final int hours = 15;
  final int minutes = 12;

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
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            VerticalDivider(color: Colors.white54),
          ],
        ),
      ),
    );
  }
}

class MarketCapChartWidget extends StatelessWidget {
  final double percent;
  final Future<List<ChartData>> chartData;
  late TooltipBehavior tool;

  MarketCapChartWidget(
      {required this.chartData, required this.percent, required this.tool});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ChartData>>(
      future: chartData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Failed to fetch data: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return SafeArea(
              child: Center(
                  child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16),
              Text(
                'Market Cap >',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 5),
              Text(
                '\$${(snapshot.data!.last.price / 1000000000000).toStringAsFixed(2)} T',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${(percent).toStringAsFixed(2)} %',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 24, 24, 24),
                ),
                child: SfCartesianChart(
                  margin: EdgeInsets.all(8),
                  palette: [Color.fromARGB(255, 170, 0, 28)],
                  backgroundColor: Colors.transparent,
                  primaryXAxis: DateTimeAxis(
                    dateFormat: DateFormat('dd/MM/yy HH:mm:ss'),
                    intervalType: DateTimeIntervalType.auto,
                    // Adjust interval type
                    labelRotation: 60,
                    labelStyle: TextStyle(fontSize: 12, color: Colors.white),
                    labelIntersectAction: AxisLabelIntersectAction.multipleRows,
                    axisLabelFormatter: (axisLabelRenderArgs) {
                      DateTime date = DateTime.fromMillisecondsSinceEpoch(
                          axisLabelRenderArgs.value.toInt());
                      String formattedDate =
                          DateFormat('dd/MM/yy').format(date);
                      String formattedTime =
                          DateFormat('HH:mm:ss').format(date);
                      return ChartAxisLabel('$formattedDate\n$formattedTime',
                          axisLabelRenderArgs.textStyle);
                    },
                    majorGridLines:
                        MajorGridLines(color: Colors.white.withOpacity(0.1)),
                  ),
                  primaryYAxis: NumericAxis(
                    opposedPosition: true,
                    numberFormat: NumberFormat.compact(),
                    labelStyle: TextStyle(fontSize: 12, color: Colors.white),
                    labelFormat: '{value}T',
                    // Custom format for trillions
                    // title: AxisTitle(text: 'Market Cap (in Trillions)'),
                    majorGridLines:
                        MajorGridLines(color: Colors.white.withOpacity(0.1)),
                  ),
                  tooltipBehavior: tool,
                  series: <CartesianSeries>[
                    LineSeries<ChartData, DateTime>(
                        dataSource: snapshot.data!,
                        xValueMapper: (ChartData data, _) => data.date,
                        yValueMapper: (ChartData data, _) =>
                            (data.price) / 1000000000000,
                        dataLabelSettings: DataLabelSettings(
                            isVisible: true,
                            textStyle: TextStyle(color: Colors.white)),
                        // Show data labels
                        enableTooltip: true,
                        markerSettings: MarkerSettings(
                          isVisible: true,
                          width: 5,
                          height: 5,
                          borderColor: Colors.pink,
                        ) // Enable tooltip for better interactivity
                        ),
                  ],
                ),
              )
            ],
          )));
        } else {
          return Center(child: Text('No data available'));
        }
      },
    );
  }
}
