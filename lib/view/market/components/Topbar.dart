import 'package:flutter/material.dart';

class TopBarWidget extends StatefulWidget {
  final TabController tabController;

  const TopBarWidget({Key? key, required this.tabController}) : super(key: key);

  @override
  _TopBarWidgetState createState() => _TopBarWidgetState();
}

class _TopBarWidgetState extends State<TopBarWidget> {
  @override
  Widget build(BuildContext context) {
    // Ensuring the entire widget is constrained properly.
    return Container(
      width: double.infinity,
      height: 50,
      color: Colors.transparent, // Optional: for visual debugging
      child: Column(
        children: <Widget>[
          Material(
            color: Colors.transparent,
            child: TabBar(
                controller: widget.tabController,
                isScrollable: true,
                labelPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                tabs: const [
                  Tab(text: 'Coin'),
                  Tab(text: 'Watchlist'),
                  Tab(text: 'Overview'),
                  Tab(text: 'NFT'),
                  Tab(text: 'Exchanges'),
                  Tab(text: 'Derivatives'),
                  Tab(text: 'Categories'),
                  Tab(text: '99 RWA Coin'),
                ],
                labelColor: Colors.white,
                indicatorColor: Color.fromARGB(255, 170, 0, 28)),
          ),
          // This Expanded widget lets the TabBarView take up the remaining space.
          Expanded(
            child: TabBarView(
              controller: widget.tabController,
              children: const [
                Center(child: Text('Coin')),
                Center(child: Text('Watchlist')),
                Center(child: Text('Overview')),
                Center(child: Text('NFT')),
                Center(child: Text('Exchanges')),
                Center(child: Text('Derivatives')),
                Center(child: Text('Categories')),
                Center(child: Text('99 RWA Coin')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
