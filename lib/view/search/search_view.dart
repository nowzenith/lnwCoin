import 'package:flutter/material.dart';
import 'package:lnwCoin/utils/constants.dart';
import 'package:lnwCoin/view/search/components/owncoin.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchQuery = ''; // Step 2: Add this line
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      const BackgroundImage(),
      Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple[
                          700], // Adjust color to match the screenshot
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      onChanged: (value) {
                      setState(() {
                        _searchQuery = value; // Update the search query
                      });
                    },
                      decoration: InputDecoration(
                        hintText: 'Search coins or exchanges...',
                        border: InputBorder.none,
                        icon: Icon(Icons.search, color: Colors.white54),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 30),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed:
                              () {}, // Placeholder function for button press
                          child: Text('Trending',
                              style: TextStyle(color: Colors.white)),
                        ),
                        TextButton(
                          onPressed:
                              () {}, // Placeholder function for button press
                          child: Text('Recently Added',
                              style: TextStyle(color: Colors.white)),
                        ),
                        TextButton(
                          onPressed:
                              () {}, // Placeholder function for button press
                          child: Text('Top Gainers',
                              style: TextStyle(color: Colors.white)),
                        ),
                        TextButton(
                          onPressed:
                              () {}, // Placeholder function for button press
                          child: Text('Top Losers',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                  OwnCoinPage(searchQuery: _searchQuery)
                ],
              ),
            ),
          )),
    ]);
  }
}
