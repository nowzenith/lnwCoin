part of 'coin.dart';
class _MarketDataCard extends StatelessWidget {
  const _MarketDataCard({
      required this.index,
      required this.coins,
      required this.function});
  final int index;
  final List<CryptoCurrency> coins;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0), // Adjust padding here
      child: InkWell(
        onTap: () {
          function();
        },
        child: Card(
          color: Color(0x1E2A38).withOpacity(0.5),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      coins[index].displayMarketCapRank,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 18),
                    ),
                  )),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Row(
                      children: [
                        SizedBox(
                            height: 30,
                            width: 30,
                            child: Image.network(coins[index].image)),
                        SizedBox(width: 10),
                        Text(
                          coins[index].symbol,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 18),
                        ),
                      ],
                    ),
                  )),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Container(
                      height: 50,
                      width: double.infinity, // Ensures it uses all available space
                      child: Sparkline(
                        data: coins[index].sparklineIn7d,
                        useCubicSmoothing: true,
                        cubicSmoothingFactor: 0.2,
                        lineGradient: coins[index].priceChangePercentage24h.toString().startsWith('-')
                            ? const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.redAccent, Colors.red])
                            : const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.greenAccent, Colors.green]),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      "\$${coins[index].currentPrice.toString().replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "")}",
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                      color: coins[index].priceChangePercentage24h.toString().startsWith('-')
                          ? const Color.fromARGB(255, 232, 22, 64)
                          : const Color.fromARGB(255, 4, 209, 109),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        coins[index].priceChangePercentage24h.toString().startsWith('-')
                            ? coins[index].priceChangePercentage24h!.toStringAsFixed(2)
                            : '+${coins[index].priceChangePercentage24h!.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
