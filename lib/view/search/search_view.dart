import 'package:flutter/material.dart';
import 'package:lnwCoin/model/search_model.dart';
import 'package:lnwCoin/service/coingecko/coingecko_api.dart';
import 'package:lnwCoin/utils/constants.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<Search> _searchResults = [];

  @override
  void initState() {
    print("search");
    _searchController.addListener(_onSearchChanged);
    super.initState();
  }

  Future<void> _fetchData(String query) async {
    try {
      var results = await CoinGeckoApi().searchCurrencies(query);
      setState(() {
        _searchResults = results;
        print(results);
      });
    } catch (e) {
      // Consider adding error handling logic here
      print('Error fetching data: $e');
    }
  }

  void _onSearchChanged() async {
    if (_searchController.text.isEmpty) {
      setState(() => _searchResults = []);
    } else {
      _fetchData(_searchController.text);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      const BackgroundImage(),
      Scaffold(
          backgroundColor: const Color.fromARGB(255, 24, 24, 24),
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
                      controller: _searchController,
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
                  Expanded(
                    child: ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_searchResults[index].name, style: TextStyle(color: Colors.white)),
                          subtitle: Text(
                              _searchResults[index].symbol, style: TextStyle(color: Colors.white60),),
                          leading: Image.network(_searchResults[index].thumb),
                          trailing: Text('#${_searchResults[index].marketCapRank}', style: TextStyle(color: Colors.white60),),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          )),
    ]);
  }
}
