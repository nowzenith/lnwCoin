import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lnwCoin/service/newsapi/news_service.dart';
import 'package:lnwCoin/utils/extensions/lottie_extension.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsFeedPage extends StatefulWidget {
  @override
  _NewsFeedPageState createState() => _NewsFeedPageState();
}

class _NewsFeedPageState extends State<NewsFeedPage>
    with TickerProviderStateMixin {
  final NewsService _newsService = NewsService();
  late AnimationController _animationController;
  bool? _isConnected;

  Future<void> _checkInternetConnection() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (mounted) {
      // Check if the widget is still in the widget tree
      setState(() {
        _isConnected = result;
      });
    }
    if (!result) {
      Future.delayed(const Duration(seconds: 5), () {
        // This block of code will be executed after a 2-second delay.
        if (mounted) {
          // Check again before making recursive call
          _checkInternetConnection();
        }
      });
    }
  }

  @override
  void initState() {
    print("news_view");
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));
    _checkInternetConnection();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(
            255, 24, 24, 24), // Scaffold background color is black
        appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle:
            false, // Change this to false to align the title to the start
        title: Center(
          child: Row(
            mainAxisSize:
                MainAxisSize.min, // Constrain the Row's size to its children
            mainAxisAlignment:
                MainAxisAlignment.center, // Center the children in the Row

            children: [
              Image.asset(
                "assets/icon/960x960.png", // Path to your logo asset
                height: 20, // Set a suitable height for the logo
              ),
              SizedBox(width: 10),
              const Text(
                'Crypto News Feed 2024',
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 24, 24, 24),
      ),
        body: _isConnected == null
            ? const Text('Checking connection...',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ))
            : _isConnected!
                ? FutureBuilder<dynamic>(
                    future: _newsService
                        .getNews(), // Corrected: Make sure to call the method on an instance
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
                      }
                      if (snapshot.hasData) {
                        final data = snapshot.data as Map<String, dynamic>;
                        final List<dynamic> articles = data['articles'];
                        return ListView.builder(
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            final Map<String, dynamic> article =
                                articles[index];
                            print(article);
                            try {
                              return MyNewsCard(
                                title: article[
                                    'title'], // Adjust according to your data structure
                                summary: article[
                                    'description'], // Adjust according to your data structure
                                imageUrl: article['urlToImage'] ??
                                    "https://builtin.com/sites/www.builtin.com/files/styles/ckeditor_optimize/public/inline-images/inside-crypto-cryptocurrency.png", // Adjust according to your data structure
                                date: DateTime.parse(article[
                                    'publishedAt']), // Adjust according to your data structure
                                url: article['url'],
                              );
                            } catch (e) {
                              print(e);
                            }
                          },
                        );
                      } else {
                        // Consider adding better error handling for non-data cases.
                        return const Center(child: Text("No news available."));
                      }
                    },
                  )
                : const Text(
                    "Can't access the internet, Please connect to the internet network.",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    )));
  }
}

// return MyNewsCard(title:newsItem.title,summary:newsItem.summary,imageUrl:newsItem.imageUrl,date:newsItem.date);
class MyNewsCard extends StatelessWidget {
  const MyNewsCard({
    super.key,
    required this.title,
    required this.summary,
    required this.imageUrl,
    required this.date,
    required this.url,
  });
  final String title;
  final String summary;
  final String imageUrl;
  final String url;
  final DateTime date;

  Future<void> launchTheURL(String url1) async {
    final Uri url = Uri.parse(url1);
    try {
      bool launched = await launchUrl(url);
      if (!launched) {
        print('Could not launch $url');
      }
    } catch (e) {
      print('Exception launching $url: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[850], // Card widget background color
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: Container(
          width: 100,
          height: 100,
          child: Image.network(
            imageUrl,
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
              // Fallback to another image URL when the primary image fails to load
              return Image.network(
                "https://builtin.com/sites/www.builtin.com/files/styles/ckeditor_optimize/public/inline-images/inside-crypto-cryptocurrency.png",
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  // If the fallback image also fails to load, show an error icon
                  return const Icon(Icons.error, color: Colors.white);
                },
              );
            },
          ),
        ),
        title: Text(
          title,
          style:
              const TextStyle(color: Colors.white), // Title text color is white
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              summary,
              style: const TextStyle(
                  color: Colors
                      .white70), // Summary text color is white with some transparency
            ),
            const SizedBox(height: 8),
            Text(
              'Date: ${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}',
              style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 12,
                  color: Colors
                      .white54), // Date text color is white with more transparency
            ),
          ],
        ),
        isThreeLine: true,
        onTap: () {
          launchTheURL(url);
        },
      ),
    );
  }
}

// class _NewsFeedPageState extends State<NewsFeedPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black, // Scaffold background color is black
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//         title: Text(
//           'Crypto News Feed 2024',
//           style: TextStyle(
//               color: Colors.white), // App bar title text color is white
//         ),
//         backgroundColor: Colors.grey[900], // App bar background color
//       ),
//       body: ListView.builder(
//         itemCount: mockCryptoNews.length,
//         itemBuilder: (context, index) {
//           final newsItem = mockCryptoNews[index];
//           return Card(
//             color: Colors.grey[850], // Card widget background color
//             margin: EdgeInsets.all(8),
//             child: ListTile(
//               leading: Image.network(
//                 newsItem.imageUrl,
//                 width: 100,
//                 height: 100,
//                 fit: BoxFit.cover,
//                 loadingBuilder: (BuildContext context, Widget child,
//                     ImageChunkEvent? loadingProgress) {
//                   if (loadingProgress == null) return child;
//                   return Center(
//                     child: CircularProgressIndicator(
//                       value: loadingProgress.expectedTotalBytes != null
//                           ? loadingProgress.cumulativeBytesLoaded /
//                               loadingProgress.expectedTotalBytes!
//                           : null,
//                     ),
//                   );
//                 },
//                 errorBuilder: (BuildContext context, Object exception,
//                     StackTrace? stackTrace) {
//                   return Icon(Icons.error,
//                       color: Colors.white); // Error icon color is white
//                 },
//               ),
//               title: Text(
//                 newsItem.title,
//                 style:
//                     TextStyle(color: Colors.white), // Title text color is white
//               ),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     newsItem.summary,
//                     style: TextStyle(
//                         color: Colors
//                             .white70), // Summary text color is white with some transparency
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     'Date: ${newsItem.date.day.toString().padLeft(2, '0')}/${newsItem.date.month.toString().padLeft(2, '0')}/${newsItem.date.year}',
//                     style: TextStyle(
//                         fontWeight: FontWeight.w300,
//                         fontSize: 12,
//                         color: Colors
//                             .white54), // Date text color is white with more transparency
//                   ),
//                 ],
//               ),
//               isThreeLine: true,
//               onTap: () {
//                 // Handle tap event, e.g., navigate to a detail page
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }