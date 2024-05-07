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
          return ListView.builder(
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

  String getFormattedMarketCap(num marketCap) {
    return NumberFormat('#,##0', 'en_US').format(marketCap);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => Cate_coin_page(category: category),
        //   ),
        // );
      },
      child: Card(
        color: Colors.grey[850], // Dark card background
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                data.name ?? 'N/A',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Market Cap: \$${getFormattedMarketCap(data.marketCapUsd)}',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '24h Change: ${data.marketCapUsd24hPercentageChange.toStringAsFixed(2)}%',
                style: TextStyle(
                  color:
                      data.marketCapUsd24hPercentageChange >= 0 ? Colors.green : Colors.red,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Image.network(
                data.image,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget build(BuildContext context) {
//     print(coins[index].symbol);
//     final bool isMinus =
//         coins[index].priceChangePercentage24h.toString().startsWith('-');
//     return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15),
//         child: InkWell(
//           onTap: () {

//           },
//           child: Card(
//               color: Colors.white.withOpacity(0.5),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   children: [
//                     Expanded(
//                         flex: 3,
//                         child: Center(
//                           child: Row(
//                             children: [
//                               SizedBox(
//                                   height: 30,
//                                   width: 30,
//                                   child: Image.network(coins[index].image)),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               Text(
//                                 coins[index].symbol,
//                                 style: const TextStyle(
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.white,
//                                     fontSize: 18),
//                               ),
//                             ],
//                           ),
//                         )),
//                     Expanded(
//                       flex: 3,
//                       child: Center(
//                         child: Text(
//                           "\$${coins[index].currentPrice.toString().replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "")}",
//                           style: const TextStyle(
//                               fontSize: 16, color: Colors.white),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                         flex: 2,
//                         child: Container(
//                           height: 30,
//                           width: 60,
//                           decoration: BoxDecoration(
//                             color: isMinus
//                                 ? const Color.fromARGB(255, 232, 22, 64)
//                                 : const Color.fromARGB(255, 4, 209, 109),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Center(
//                             child: isMinus
//                                 ? Text(
//                                     coins[index].priceChangePercentage24h !=
//                                             null
//                                         ? coins[index]
//                                             .priceChangePercentage24h!
//                                             .toStringAsFixed(2)
//                                         : '', // Format to two decimal places if not null, else provide an empty string
//                                     style: const TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   )
//                                 : Text(
//                                     coins[index].priceChangePercentage24h !=
//                                             null
//                                         ? '+${coins[index].priceChangePercentage24h!.toStringAsFixed(2)}'
//                                         : '', // Format to two decimal places if not null, else provide an empty string
//                                     style: const TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                           ),
//                         )),
//                   ],
//                 ),
//               )),
//         ));
//   }
// }