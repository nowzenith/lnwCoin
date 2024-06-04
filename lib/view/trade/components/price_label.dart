
part of 'package:lnwCoin/view/trade/trade_view.dart';

class _PriceLabel extends StatelessWidget {
  const _PriceLabel({required this.price, required this.price_change_percentage_24h});
  final double price;
  final double price_change_percentage_24h;
  @override
  Widget build(BuildContext context) {
    final bool isMinus = price_change_percentage_24h.toString().startsWith('-');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Current Price",
            style: TextStyle(color: Colors.white),
          ),
          Row(
            children: [
              Text(
                "\$${price.toString().replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "")}",
                style: const TextStyle(fontSize: 25, color: Colors.white),
              ),
              const SizedBox(width: 10),
              Container(
                height: 30,
                width: 80,
                decoration: BoxDecoration(
                  color: isMinus
                      ? Colors.redAccent.shade400
                      : Colors.greenAccent.shade400,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                    child: isMinus
                        ? Text(price_change_percentage_24h.toString())
                        : Text('+${price_change_percentage_24h}')),
              )
            ],
          ),
        ],
      ),
    );
  }
}
