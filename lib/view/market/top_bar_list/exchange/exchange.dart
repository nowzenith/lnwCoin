import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lnwCoin/model/exchange.dart';

import 'package:lnwCoin/model/market_model.dart';
import 'package:lnwCoin/service/coingecko/coingecko_api.dart';
import 'package:lnwCoin/utils/extensions/lottie_extension.dart';
import 'package:lnwCoin/view_model/market_view_model.dart';
import 'package:lottie/lottie.dart';
part 'market_data_card.dart';

class ExchangePage extends StatefulWidget {
  const ExchangePage({super.key});

  @override
  State<ExchangePage> createState() => _ExchangePageState();
}

class _ExchangePageState extends State<ExchangePage>
    with TickerProviderStateMixin {
  late Future<List<dynamic>> _exchangeFuture;
  late AnimationController _animationController;
  @override
  void initState() {
    print("exchange_view");
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));
    _exchangeFuture =
        CoinGeckoApi().fetchExchange(); // Ensure the future is initialized here
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<Exchange> cleanseData(List<dynamic> rawData) {
    List<Exchange> exchanges = rawData.map((dataJson) => Exchange.fromJson(Map<String, dynamic>.from(dataJson))).toList();

    for (int i = 1; i < exchanges.length - 1; i++) {
      if (exchanges[i - 1].trustScore == exchanges[i + 1].trustScore && 
          exchanges[i].trustScore != exchanges[i - 1].trustScore) {
        exchanges[i].trustScore = exchanges[i - 1].trustScore;
      }
    }

    return exchanges;
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _exchangeFuture,
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
        } else if (snapshot.hasData) {
          List<Exchange> cleanedExchanges = cleanseData(snapshot.data!);
          int? old_data = 10;
          return Column(
            children: [
              Container(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Card(
                    color: Color.fromARGB(53, 30, 42, 56),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child: Center(
                              child: Text(
                                'Exchange',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Center(
                              child: Text(
                                '24h Volume',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize
                                    .min, // Center-align the row's content
                                children: [
                                  Text(
                                    'Score',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                      width:
                                          4), // Add some space between the text and the icon
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Theme(
                                            data: ThemeData.dark().copyWith(
                                              dialogBackgroundColor: Colors
                                                  .grey[900], // Dark background
                                              textTheme: TextTheme(
                                                titleLarge: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight
                                                        .bold), // Title text style
                                                bodyMedium: TextStyle(
                                                    color: Colors
                                                        .white70), // Content text style
                                              ),
                                              dialogTheme: DialogTheme(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                              ),
                                            ),
                                            child: AlertDialog(
                                              title: Text(
                                                  'Trust Score Information'),
                                              content: Text(
                                                'Trust Score is a rating algorithm developed by CoinGecko to evaluate the legitimacy of an exchange’s trading volume. Trust Score is calculated on a range of metrics such as liquidity, scale of operations, cybersecurity score, and more.',
                                              ),
                                              actions: [
                                                TextButton(
                                                  child: Text('Close'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Icon(
                                      Icons.info_outline,
                                      color: Colors.white,
                                      size: 16, // Adjust the size of the icon
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: cleanedExchanges.length,
                  itemBuilder: (context, index) {
                    var data = cleanedExchanges[index];
                    Widget card = NftCard(data: data);

                    if (index > 0 && old_data != null && old_data != data.trustScore) {
                      old_data = data.trustScore;
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: Divider(height: 10),
                          ),
                          card,
                        ],
                      );
                    }

                    return card;
                  },
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return const Center(child: Text('No categories available'));
        }
      },
    );
  }
}

class NftCard extends StatelessWidget {
  final Exchange data;

  const NftCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isMinus = data.trustScore! < 5;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: InkWell(
          onTap: () {},
          child: Card(
              color: Color(0x1E2A38).withOpacity(0.5),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                        flex: 5,
                        child: Center(
                          child: Row(
                            children: [
                              SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: Image.network(data.image!)),
                              const SizedBox(
                                width: 10,
                              ),
                              SplitTextWidget(
                                text: data.name!,
                                splitLength: 20,
                              ),
                            ],
                          ),
                        )),
                    Expanded(
                      flex: 3,
                      child: Center(
                        child: Text(
                          "\$${NumberFormat('#,##0.##', 'en_US').format(data.tradeVolume24hBtcNormalized)}",
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Container(
                          height: 30,
                          width: 60,
                          decoration: BoxDecoration(
                            color: isMinus
                                ? const Color.fromARGB(255, 232, 22, 64)
                                : const Color.fromARGB(255, 4, 209, 109),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                              child: Text(
                            "${data.trustScore}/10",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                        )),
                  ],
                ),
              )),
        ));
  }
}

class SplitTextWidget extends StatelessWidget {
  final String text;
  final int splitLength;

  const SplitTextWidget({Key? key, required this.text, this.splitLength = 20})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      _splitTextWithCondition(text, splitLength),
      style: const TextStyle(
          fontWeight: FontWeight.w600, color: Colors.white, fontSize: 12),
    );
  }

  String _splitTextWithCondition(String text, int maxLength) {
    // This function inserts newline characters at spaces if the preceding text is longer than maxLength
    List<String> words = text.split(' ');
    String result = '';
    String currentLine = '';

    for (String word in words) {
      if ((currentLine + word).length > maxLength) {
        result += (result.isEmpty ? '' : '\n') + currentLine.trim();
        currentLine = '';
      }
      currentLine += word + ' ';
    }

    if (currentLine.isNotEmpty) {
      result += (result.isEmpty ? '' : '\n') + currentLine.trim();
    }

    return result;
  }
}
