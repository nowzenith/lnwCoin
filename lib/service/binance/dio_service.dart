import 'dart:developer';
import 'dart:io';

import 'package:lnwCoin/service/binance/api_keys.dart';
import 'package:dio/dio.dart';
import 'package:lnwCoin/utils/cache/shared_manager.dart';

abstract class IDioService {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiKeys.baseURL));
  Future<List<dynamic>> get24hrData(List<String> symbols);
  Future<List<dynamic>> getCandleData(
      {required String symbol, required String interval});
  Future<List<dynamic>> getSymbolData({required String symbol});
}

class DioService extends IDioService {
  final String _path24Hour = "/api/v3/ticker/24hr";
  final String _pathCandle = "/api/v3/klines?";
  final String _pathSymbol = "/api/v3/ticker/price?";

  @override
  Future<List<dynamic>> get24hrData(List<String> symbols) async {
    if(GlobalStateManager.instance.check){
      log("error req so much");
      throw "error";
    }
    print(symbols.map((e) => '"$e"').join(','));
    String s = symbols.map((e) => '"$e"').join(',');
    try {
      final response = await _dio.get(_path24Hour+'?symbols=[$s]');

      if (response.statusCode == HttpStatus.ok) {
        return response.data;
      }else if (response.statusCode == 429 || response.statusCode == 419 || response.statusCode == 418) {
        GlobalStateManager.instance.setCheck(true);
      } else {
        log("Status Code: ${response.statusCode} \n Status Message: ${response.statusMessage}");
      }
    } on DioError catch (e) {
      log("Error Message: $e");
    }

    throw UnimplementedError();
  }


  @override
  Future<List<dynamic>> getCandleData(
      {required String symbol, required String interval}) async {
    try {
      final response = await _dio.get(_pathCandle, queryParameters: {
        "symbol": symbol,
        "interval": interval,
        "limit": 20
      });

      if (response.statusCode == HttpStatus.ok) {
        return response.data;
      } else {
        log("Status Code: ${response.statusCode} \n Status Message: ${response.statusMessage}");
      }
    } on DioError catch (e) {
      log("Error Message: $e");
    }

    throw UnimplementedError();
  }

  @override
  Future<List> getSymbolData({required String symbol}) async {
    try {
      final response =
          await _dio.get(_pathSymbol, queryParameters: {"symbol": symbol});

      if (response.statusCode == HttpStatus.ok) {
        return response.data;
      } else {
        log("Status Code: ${response.statusCode} \n Status Message: ${response.statusMessage}");
      }
    } on DioError catch (e) {
      log("Error Message: $e");
    }
    throw UnimplementedError();
  }
}
