import 'package:flutter/material.dart';

class CryptoTrackerPage extends StatelessWidget {
  const CryptoTrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 24, 24),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 24, 24, 24),
        title: const Text('รายละเอียดหมวดหมู่'),
        titleTextStyle: const TextStyle(color: Colors.white),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Logic to share cryptocurrency details
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            MyCustomWidget(), // Your custom widget at the top
            ListView.builder(
              physics:
                  const NeverScrollableScrollPhysics(), // to disable ListView's scrolling
              shrinkWrap:
                  true, // Required to use ListView inside Column/SingleChildScrollView
              itemCount: cryptoList.length,
              itemBuilder: (context, index) {
                final crypto = cryptoList[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white, // For better visibility
                    child: Image.network(
                      crypto.iconUrl,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                            Icons.error); // Icon if image fails to load
                      },
                    ),
                  ),
                  title: Text(
                    crypto.name,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    '\$${crypto.price.toStringAsFixed(2)}',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                  trailing: Text(
                    '${crypto.percentChange24h.toStringAsFixed(2)}%',
                    style: TextStyle(
                      color: crypto.percentChange24h >= 0
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Rest of the code for Crypto class, cryptoList, and MyCustomWidget remains the same...

class Crypto {
  final String name;
  final String iconUrl;
  final double price;
  final double percentChange24h;

  Crypto({
    required this.name,
    required this.iconUrl,
    required this.price,
    required this.percentChange24h,
  });
}

// Sample data
final cryptoList = [
  Crypto(
      name: 'DOGE',
      iconUrl: 'https://example.com/path_to_doge_icon',
      price: 0.1476,
      percentChange24h: -2.24),
  Crypto(
      name: 'BTC',
      iconUrl: 'https://example.com/path_to_btc_icon',
      price: 40000.00,
      percentChange24h: 1.50),
  // Add other cryptocurrencies here
];

class MyCustomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text(
            'Memes',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          const SizedBox(height: 8),
          const Text(
            '1194 โพสต์',
            style: TextStyle(color: Colors.white54, fontSize: 18),
          ),
          const Divider(color: Colors.grey),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'ราคาตลาด',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              Text(
                '\$47,109,262,204',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'ราคา 24 ชม. ที่ผ่านมา',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              Text(
                '\$6,188,169,776',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'การเปลี่ยนแปลงราคาตลาด',
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
              Text(
                '▼ 0.84%',
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'การเปลี่ยนแปลงราคาตลาด 24 ชม.',
                style: TextStyle(color: Colors.green, fontSize: 18),
              ),
              Text(
                '▼ 0.29%',
                style: TextStyle(color: Colors.green, fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(// foreground (text) color
                ),
            onPressed: () {},
            child: const Text('แจ้งเมื่อมีเทรน'),
          ),
        ],
      ),
    );
  }
}
