part of 'package:lnwCoin/view/trade/trade_view.dart';

class MinMaxResult {
  final double? minLow;
  final double? maxHigh;

  MinMaxResult({this.minLow, this.maxHigh});
}

class _Chart extends StatelessWidget {
  const _Chart({required this.tradeViewModel, required this.candle});
  final TradeViewModel tradeViewModel;
  final List<Candle> candle;

  @override
  Widget build(BuildContext context) {
    final interval =
        tradeViewModel.interval; // Ensure this exists in your ViewModel.
    DateTimeIntervalType intervalType = DateTimeIntervalType.minutes;
    double? intervalValue =
        15; // Default value, adjust based on actual selection.

    switch (interval) {
      case "15m":
        intervalType = DateTimeIntervalType.minutes;
        intervalValue = 15;
        print("15m");
        break;
      case "30m":
        intervalType = DateTimeIntervalType.minutes;
        intervalValue = 30;
        print("30m");
        break;
      case "1h":
        intervalType = DateTimeIntervalType.hours;
        intervalValue = 1;
        print("1h");
        break;
      case "4h":
        intervalType = DateTimeIntervalType.hours;
        intervalValue = 4;
        print("4h");
        break;
      case "8h":
        intervalType = DateTimeIntervalType.hours;
        intervalValue = 8;
        print("8h");
        break;
      case "12h":
        intervalType = DateTimeIntervalType.hours;
        intervalValue = 12;
        print("12h");
        break;
      case "1d":
        intervalType = DateTimeIntervalType.days;
        intervalValue = 1;
        print("1d");
        break;
      case "1w":
        intervalType = DateTimeIntervalType.days;
        intervalValue =
            7; // Assuming you want to show a label every 7 days for "1w".

        print("1w");
        break;
      default:
        // Handle default or unexpected case.
        break;
    }

    MinMaxResult findMinLowAndMaxHigh(List<Candle> candles) {
      double? mmin = null;
      double? mmax = null;

      for (var candle in candles) {
        // Assuming Candle's low and high can be null, convert them to double (if not null) for comparison
        final double? lowAsDouble = candle.low?.toDouble();
        final double? highAsDouble = candle.high?.toDouble();

        if (lowAsDouble != null) {
          mmin = (mmin == null)
              ? lowAsDouble
              : (lowAsDouble < mmin ? lowAsDouble : mmin);
        }
        if (highAsDouble != null) {
          mmax = (mmax == null)
              ? highAsDouble
              : (highAsDouble > mmax ? highAsDouble : mmax);
        }
      }

      return MinMaxResult(minLow: mmin, maxHigh: mmax);
    }

    MinMaxResult result = findMinLowAndMaxHigh(candle);

    // Assuming you have a way to get the selected interval. For example:
    // String selectedInterval = tradeViewModel.selectedInterval;
    // You would then adjust the interval and intervalType based on the selectedInterval.

    return SizedBox(
      height: 320,
      child: SfCartesianChart(
        trackballBehavior: tradeViewModel.trackballBehavior,
        zoomPanBehavior: tradeViewModel.zoomPanBehavior,
        onChartTouchInteractionUp: (tapArgs) {
          tradeViewModel.zoomPanBehavior.zoomOut();
        },
        backgroundColor: Colors.black12,
        plotAreaBorderWidth: 0.6,
        plotAreaBorderColor: Colors.greenAccent,
        borderWidth: 0,
        borderColor: Colors.transparent,
        series: <CandleSeries>[
          CandleSeries<Candle, DateTime>(
            dataSource: candle,
            xValueMapper: (Candle data, _) => data.x,
            highValueMapper: (Candle data, _) => data.high,
            lowValueMapper: (Candle data, _) => data.low,
            openValueMapper: (Candle data, _) => data.open,
            closeValueMapper: (Candle data, _) => data.close,
          ),
        ],
        primaryXAxis: DateTimeAxis(
          intervalType: intervalType,
          interval: intervalValue,
          // dateFormat: DateFormat('HH:mm'),
          majorGridLines: const MajorGridLines(width: 0),
          labelRotation: 45,
          labelIntersectAction: AxisLabelIntersectAction.rotate45,
          // Adjust other properties as needed.
        ),
        primaryYAxis: NumericAxis(
          axisLine: const AxisLine(color: Colors.transparent),
          opposedPosition: true,
          enableAutoIntervalOnZooming: true,
          labelStyle: const TextStyle(fontSize: 10, color: Colors.white),
          majorTickLines: const MajorTickLines(size: 2, width: 0),
          majorGridLines: const MajorGridLines(color: Colors.white, width: 0.2),
          minimum: (result.minLow! - (candle.last.low! * (1 / 100))),
          maximum: (result.maxHigh! + (candle.last.high! * (1 / 100))),
          interval: (((candle.last.high! + (candle.last.high! * (1 / 6))) -
                  (candle.last.low! - (candle.last.low! * (1 / 6)))) /
              60),
          numberFormat: NumberFormat.simpleCurrency(decimalDigits: 3),
        ),
      ),
    );
  }
}
