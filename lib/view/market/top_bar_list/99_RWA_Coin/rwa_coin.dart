import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'data.dart';

class Rwa_Coin extends StatefulWidget {
  const Rwa_Coin({super.key});

  @override
  State<Rwa_Coin> createState() => _Rwa_CoinState();
}

class _Rwa_CoinState extends State<Rwa_Coin> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    print("RWA_Coin");
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      flex: 6,
                      child: Center(
                        child: Text(
                          'Coin',
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
                          'Buy',
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
            itemCount: mockRWAData.length,
            itemBuilder: (context, index) {
              return NftCard(
                data: mockRWAData[index],
              );
            },
          ),
        ),
      ],
    );
  }
}

class NftCard extends StatelessWidget {
  final RWAData data;

  const NftCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Card(
            color: const Color(0x1E2A38).withOpacity(0.5),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Center(
                        child: SizedBox(
                            height: 30,
                            width: 30,
                            child: Image.asset("assets/rwacoin/${data.image}")),
                      )),
                  Expanded(
                    flex: 5,
                    child: Center(
                      child: SplitTextWidget(
                                  text: data.symbol,
                                  splitLength: 20,
                                ),
                    ),
                  ),
                  const Expanded(
                    flex: 3,
                    child: Center(
                      child: Text(
                        "\$0.00",
                        style: TextStyle(
                            fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: const StadiumBorder(),
                          side: const BorderSide(
                              width: 2,
                              color: Color.fromARGB(173, 97, 255, 147)),
                        ),
                        onPressed: (){},
                        child: const Text(
                          "Buy",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ],
              ),
            )));
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
          fontWeight: FontWeight.w600, color: Colors.white, fontSize: 16),
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
