import 'package:flutter/material.dart';

class CryptoNewsItem {
  final String title;
  final String summary;
  final String imageUrl;
  final DateTime date;

  CryptoNewsItem({
    required this.title,
    required this.summary,
    required this.imageUrl,
    required this.date,
  });
}

final List<CryptoNewsItem> mockCryptoNews = [
  CryptoNewsItem(
    title: 'Bitcoin Hits New All-Time High in 2024',
    summary:
        'The price of Bitcoin reached new heights today, signaling strong market confidence...',
    imageUrl: 'https://via.placeholder.com/150',
    date: DateTime(2024, 4, 1),
  ),
  CryptoNewsItem(
    title: 'Ethereum 2.0 Successfully Launches',
    summary:
        'The long-awaited upgrade to the Ethereum network promises to improve scalability and security...',
    imageUrl: 'https://via.placeholder.com/150',
    date: DateTime(2024, 5, 15),
  ),
  // Add more CryptoNewsItem instances here...
  CryptoNewsItem(
    title: 'Major Breakthrough in Blockchain Privacy',
    summary:
        'New privacy features promise to enhance security and anonymity on the blockchain...',
    imageUrl: 'https://via.placeholder.com/150',
    date: DateTime(2024, 6, 20),
  ),
  CryptoNewsItem(
    title:
        'Decentralized Finance (DeFi) Hits \$1 Trillion in Total Value Locked',
    summary:
        'The DeFi sector continues to grow, reaching a major milestone in total value locked (TVL)...',
    imageUrl: 'https://via.placeholder.com/150',
    date: DateTime(2024, 7, 5),
  ),
];

class NewsFeedPage extends StatefulWidget {
  @override
  _NewsFeedPageState createState() => _NewsFeedPageState();
}

class _NewsFeedPageState extends State<NewsFeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Scaffold background color is black
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Crypto News Feed 2024',
          style: TextStyle(
              color: Colors.white), // App bar title text color is white
        ),
        backgroundColor: Colors.grey[900], // App bar background color
      ),
      body: ListView.builder(
        itemCount: mockCryptoNews.length,
        itemBuilder: (context, index) {
          final newsItem = mockCryptoNews[index];
          return Card(
            color: Colors.grey[850], // Card widget background color
            margin: EdgeInsets.all(8),
            child: ListTile(
              leading: Image.network(
                newsItem.imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Icon(Icons.error,
                      color: Colors.white); // Error icon color is white
                },
              ),
              title: Text(
                newsItem.title,
                style:
                    TextStyle(color: Colors.white), // Title text color is white
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    newsItem.summary,
                    style: TextStyle(
                        color: Colors
                            .white70), // Summary text color is white with some transparency
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Date: ${newsItem.date.day.toString().padLeft(2, '0')}/${newsItem.date.month.toString().padLeft(2, '0')}/${newsItem.date.year}',
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 12,
                        color: Colors
                            .white54), // Date text color is white with more transparency
                  ),
                ],
              ),
              isThreeLine: true,
              onTap: () {
                // Handle tap event, e.g., navigate to a detail page
              },
            ),
          );
        },
      ),
    );
  }
}
