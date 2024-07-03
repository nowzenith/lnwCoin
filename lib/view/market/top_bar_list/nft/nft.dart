import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:lnwCoin/model/market_model.dart';
import 'package:lnwCoin/model/nft_model.dart';
import 'package:lnwCoin/service/coingecko/coingecko_api.dart';
import 'package:lnwCoin/utils/extensions/lottie_extension.dart';
import 'package:lnwCoin/view_model/market_view_model.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
part 'market_data_card.dart';

class NftPage extends StatefulWidget {
  const NftPage({super.key});

  @override
  State<NftPage> createState() => _NftPageState();
}

class _NftPageState extends State<NftPage> with TickerProviderStateMixin {
  late Future<List<dynamic>> _nftFuture;
  late AnimationController _animationController;
  @override
  void initState() {
    print("nft_view");
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));
    _nftFuture = CoinGeckoApi()
        .fetchNft(); // Ensure the future is initialized here
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _nftFuture,
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
          return Column(
            children: [
              Container(
                    height: 50,
                    child: const Padding(
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
                                    'NFT',
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
                                    'Price',
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
                                    'Change',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
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
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    print(snapshot.data![index]);
                    var dataJson = Map<String, dynamic>.from(snapshot.data![index]);
                    var data = NFT
                        .fromJson(dataJson); // Correctly converts to CryptoCategory
                    return NftCard(
                      data: data,
                    );
                  },
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Center(child: Text('No categories available'));
        }
      },
    );
  }
}

class NftCard extends StatelessWidget {
  final NFT data;

  const NftCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isMinus = data.marketCapUsd24hPercentageChange < 0;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: InkWell(
          onTap: () {

          },
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
                                  child: Image.network(data.image)),
                              SizedBox(
                                width: 10,
                              ),
                              SplitTextWidget(
                                text : data.name,
                                splitLength: 20,
                              ),
                            ],
                          ),
                        )),
                    Expanded(
                      flex: 3,
                      child: Center(
                        child: Text(
                          "\$${NumberFormat('#,##0.##', 'en_US').format(data.floorPriceUsd)}",
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
                            child: isMinus
                                ? Text(
                                    '${NumberFormat('#,##0.##', 'en_US').format(data.marketCapUsd24hPercentageChange)}%',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: data.marketCapUsd24hPercentageChange > 1000 ? 10 : 14
                                    ),
                                  )
                                : Text(
                                    '+${NumberFormat('#,##0.##', 'en_US').format(data.marketCapUsd24hPercentageChange)}%',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: data.marketCapUsd24hPercentageChange > 1000 ? 10 : 14
                                    ),
                                  ),
                          ),
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

  const SplitTextWidget({Key? key, required this.text, this.splitLength = 20}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      _splitTextWithCondition(text, splitLength),
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        color: Colors.white,
        fontSize: 12),
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