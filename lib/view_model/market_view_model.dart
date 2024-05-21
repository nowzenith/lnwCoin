import 'dart:async';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:lnwCoin/model/market_model.dart';
import 'package:lnwCoin/service/binance/dio_service.dart';
import 'package:lnwCoin/utils/packages/url_launcher.dart';
import 'package:flutter/material.dart';

class MarketViewModel extends ChangeNotifier with LaunchMixin {
  MarketViewModel() {
    _dioService = DioService();
    getMarketData();
  }

  late final IDioService _dioService;
  //late Timer _timer;
  double money = 0.0;
  bool _isVisible = true;

  bool get isVisible => _isVisible;

  Stream<List<Market>> getMarketData() async* {
    const List<String> coinLogos = [
      "BTCUSDT",
      "ADAUSDT",
      "ATOMUSDT",
      "AVAXUSDT",
      "BNBUSDT",
      "BUSDUSDT",
      "DARUSDT",
      "DOGEUSDT",
      "ETHUSDT",
      "FETUSDT",
      "FTMUSDT",
      "LINKUSDT",
      "LTCUSDT",
      "MATICUSDT",
      "NEARUSDT",
      "OPUSDT",
      "SANDUSDT",
      "SCUSDT",
      "SHIBUSDT",
      "SOLUSDT",
      "STORJUSDT",
      "TRXUSDT",
      "XRPUSDT",
      "EOSUSDT",
      "ETCUSDT",
      "VETUSDT",
      "USDCUSDT",
      "WAVESUSDT",
      "ZILUSDT",
      "ZRXUSDT",
      "THETAUSDT",
      "ENJUSDT",
      "TFUELUSDT",
      "ONEUSDT",
      "ALGOUSDT",
      "DUSKUSDT",
      "ANKRUSDT",
      "COSUSDT",
      "MTLUSDT",
      "KEYUSDT",
      "CHZUSDT",
      "RENUSDT",
      "RVNUSDT",
      "HBARUSDT",
      "NKNUSDT",
      "STXUSDT",
      "KAVAUSDT",
      "ARPAUSDT",
      "IOTXUSDT",
      "CTXCUSDT",
      "BCHUSDT",
      "OGNUSDT",
      "COTIUSDT",
      "MDTUSDT",
      "KNCUSDT",
      "COMPUSDT",
      "SNXUSDT",
      "DGBUSDT",
      "MKRUSDT",
      "KMDUSDT",
      "CRVUSDT",
      "OCEANUSDT",
      "DOTUSDT",
      "LUNAUSDT",
      "TRBUSDT",
      "EGLDUSDT",
      "RUNEUSDT",
      "BELUSDT",
      "UNIUSDT",
      "ORNUSDT",
      "XVSUSDT",
      "AAVEUSDT",
      "FILUSDT",
      "INJUSDT",
      "AXSUSDT",
      "ROSEUSDT",
      "SKLUSDT",
      "GRTUSDT",
      "CELOUSDT",
      "TRUUSDT",
      "CKBUSDT",
      "TWTUSDT",
      "CAKEUSDT",
      "OMUSDT",
      "LINAUSDT",
      "PERPUSDT",
      "CFXUSDT",
      "BURGERUSDT",
      "ICPUSDT",
      "MASKUSDT",
      "LPTUSDT",
      "XVGUSDT",
      "BONDUSDT",
      "MINAUSDT",
      "MBOXUSDT",
      "GHSTUSDT",
      "XECUSDT",
      "DYDXUSDT",
      "ILVUSDT",
      "YGGUSDT",
    ];
    var streamController = StreamController<List<Market>>();
    List<Market> lastSuccessfulData = [];
    int retryCount = 0;
    const maxRetries = 3; // Maximum number of retries

    while (retryCount < maxRetries) {
      try {
        List<Market> markets = [];

        List<dynamic> list = await _dioService.get24hrData(coinLogos);
        var filteredList = list.where((element) =>
            element['symbol'].toString().contains("USDT") &&
            element['lastPrice'].toString().contains(RegExp(r'[1-9]')) &&
            (element['count'] > 54022));

        markets = filteredList.map((e) {
          return Market(
            symbol: e['symbol'],
            lastPrice: e['lastPrice'],
            priceChangePercent: e['priceChangePercent'],
          );
        }).toList();

        lastSuccessfulData = markets;
        streamController.add(markets);
        break; // Exit the loop on success
      } catch (e) {
        retryCount++;
        print('Attempt $retryCount failed: $e');

        if (e is DioError && retryCount < maxRetries) {
          // If the error is a DioError of type other, retry after a delay
          await Future.delayed(Duration(seconds: 2));
          continue; // Proceed to the next iteration of the loop
        } else {
          // For other errors or when retries are exhausted, handle gracefully
          if (lastSuccessfulData.isNotEmpty) {
            streamController.add(lastSuccessfulData);
          } else {
            streamController.addError(
                'Failed to fetch market data after $maxRetries attempts');
          }
          break; // Exit the loop on failure
        }
      }
    }

    yield* streamController.stream;
  }

  void goToWebsite({required String url}) {
    launchTheURL(url);
  }

  void changeVisibility() {
    _isVisible = !_isVisible;
    notifyListeners();
  }

  // @override
  // void dispose() {
  //   _timer.cancel();
  //   super.dispose();
  // }
  Stream<List<Market>> getMakeupData() async* {
    const List<String> coinLogos = [
      "AAVEUSDT",
      "AKROUSDT",
      "ALGOUSDT",
      "ANKRUSDT",
      "ARPAUSDT",
      "AXSUSDT",
      "BADGERUSDT",
      "BCHUSDT",
      "BELUSDT",
      "BONDUSDT",
      "BURGERUSDT",
      "CAKEUSDT",
      "CELOUSDT",
      "CFXUSDT",
      "CKBUSDT",
      "COMPUSDT",
      "COTIUSDT",
      "CRVUSDT",
      "CTXCUSDT",
      "DGBUSDT",
      "DOTUSDT",
      "DYDXUSDT",
      "EGLDUSDT",
      "ENJUSDT",
      "ETCUSDT",
      "FIDAUSDT",
      "FILUSDT",
      "GHSTUSDT",
      "GRTUSDT",
      "HBARUSDT",
      "ICPUSDT",
      "ILVUSDT",
      "INJUSDT",
      "IOTXUSDT",
      "KAVAUSDT",
      "KMDUSDT",
      "KNCUSDT",
      "LINAUSDT",
      "LPTUSDT",
      "LUNAUSDT",
      "MASKUSDT",
      "MBOXUSDT",
      "MDTUSDT",
      "MINAUSDT",
      "MKRUSDT",
      "MTLUSDT",
      "NKNUSDT",
      "OCEANUSDT",
      "OGNUSDT",
      "OMUSDT",
      "ONEUSDT",
      "ORNUSDT",
      "PERPUSDT",
      "RENUSDT",
      "ROSEUSDT",
      "RSRUSDT",
      "RUNEUSDT",
      "RVNUSDT",
      "SKLUSDT",
      "STXUSDT",
      "TFUELUSDT",
      "THETAUSDT",
      "TRBUSDT",
      "TRUUSDT",
      "TWTUSDT",
      "UNIUSDT",
      "USDCUSDT",
      "VETUSDT",
      "VTHOUSDT",
      "WAVEUSDT",
      "XECUSDT",
      "XVGUSDT",
      "XVSUSDT",
      "YGGUSDT",
      "ZILUSDT",
      "ZRXUSDT",
    ];
    var rng = Random();

    // Use a loop to continuously emit data
    while (true) {
      List<String> shuffledCoinLogos = List<String>.from(coinLogos)
        ..shuffle(rng);
      List<Market> markets = shuffledCoinLogos.map((symbol) {
        // Generating random last price and price change percent
        var lastPrice =
            rng.nextDouble() * 1000; // Random price between 0 and 1000
        var priceChangePercent =
            rng.nextDouble() * 100 - 50; // Random change between -50% and 50%

        return Market(
          symbol: symbol,
          lastPrice: lastPrice.toStringAsFixed(2), // Keeping two decimal places
          priceChangePercent: priceChangePercent.toStringAsFixed(2),
        );
      }).toList();

      // Yielding a new list of markets
      yield markets;

      // Print for debugging (optional)
      print("Markets data emitted at ${DateTime.now()}");

      // Wait for a period before emitting the next set of data
      await Future.delayed(Duration(seconds: 10));
    }
  }

  Stream<List<Market>> getOwncoinData() async* {
    const List<String> coinLogos = [
      "ATIDUSDT",
      "AYCUSDT",
      "BIADUSDT",
      "BTADUSDT",
      "CCCUSDT",
      "CGDUSDT",
      "CHDUSDT",
      "CHGDUSDT",
      "CHGPCUSDT",
      "CHPCUSDT",
      "DINCUSDT",
      "DNCUSDT",
      "FNGUSDT",
      "FTDUSDT",
      "GMDUSDT",
      "HMIDUSDT",
      "IPCUSDT",
      "JWCUSDT",
      "KHPNUSDT",
      "KPCUSDT",
      "KPPUSDT",
      "LOSCUSDT",
      "MDCUSDT",
      "MHTUSDT",
      "MIDUSDT",
      "MKCUSDT",
      "MKDUSDT",
      "MNDUSDT",
      "MNYUSDT",
      "NKPUSDT",
      "NTNUSDT",
      "OMCUSDT",
      "PAIUSDT",
      "PDCUSDT",
      "PKDUSDT",
      "PKSCUSDT",
      "PLIDUSDT",
      "PLNGCUSDT",
      "PLODUSDT",
      "PMCUSDT",
      "PMJCUSDT",
      "PNCUSDT",
      "PPDCUSDT",
      "PPDUSDT",
      "PRCUSDT",
      "PTNUSDT",
      "PYDUSDT",
      "PYKTUSDT",
      "RCWCUSDT",
      "REDUSDT",
      "RMKUSDT",
      "RRUUSDT",
      "RSRUSDT",
      "RYCUSDT",
      "SABUSDT",
      "SATIUSDT",
      "SAYUSDT",
      "SBDUSDT",
      "SDSUSDT",
      "SFACUSDT",
      "SFCUSDT",
      "SGDUSDT",
      "SIDUSDT",
      "SISPCUSDT",
      "SKDUSDT",
      "SMNCUSDT",
      "SNDUSDT",
      "SNUCUSDT",
      "SRJUSDT",
      "SSDUSDT",
      "SSMCUSDT",
      "STGUSDT",
      "STWCUSDT",
      "SUVCUSDT",
      "SVLDUSDT",
      "SVYPUSDT",
      "SWCUSDT",
      "SWTCUSDT",
      "TBMUSDT",
      "TDDUSDT",
      "THCUSDT",
      "THDKUSDT",
      "TKCUSDT",
      "TKDUSDT",
      "TLDUSDT",
      "TLNUSDT",
      "TNGUSDT",
      "TTCUSDT",
      "TWECUSDT",
      "TYCUSDT",
      "UDSCUSDT",
      "VYDUSDT",
      "YIMUSDT",
      "YNGUSDT"
    ];
    var rng = Random();

    // Use a loop to continuously emit data
    while (true) {
      List<Market> markets = coinLogos.map((symbol) {
        // Generating random last price and price change percent
        var lastPrice =
            rng.nextDouble() * 1000; // Random price between 0 and 1000
        var priceChangePercent =
            rng.nextDouble() * 100 - 50; // Random change between -50% and 50%

        return Market(
          symbol: symbol,
          lastPrice: lastPrice.toStringAsFixed(2), // Keeping two decimal places
          priceChangePercent: priceChangePercent.toStringAsFixed(2),
        );
      }).toList();

      // Yielding a new list of markets
      yield markets;

      // Print for debugging (optional)
      print("Markets data emitted at ${DateTime.now()}");

      // Wait for a period before emitting the next set of data
      await Future.delayed(Duration(seconds: 10));
    }
  }
}
