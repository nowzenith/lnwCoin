import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lnwCoin/view/community/game/game.dart';
import 'package:lnwCoin/view/community/metaverse/metaverse.dart';
import 'package:lnwCoin/view/internet/no_internet.dart';

import 'components/Topbar.dart';
import 'post/post.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> with TickerProviderStateMixin {
  bool? _isConnected;
  Timer? _timer;

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

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      _checkInternetConnection();
    }
  }
  late TabController _tabController;
  final List<Widget> pages = [
    const Metaverse(),
    const Game(),
    const Post()

  ];
  @override
  void initState() {
    print("community");
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
    _checkInternetConnection();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _tabController.removeListener(_handleTabSelection);
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 24, 24),
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
                'Community',
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 24, 24, 24),
      ),
      body: Column(
        children: [
          TopBarWidget(tabController: _tabController),
          const SizedBox(
                height: 14,
              ),
           _isConnected == null
                  ? const Text('Checking connection...',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ))
                  : _isConnected!
                      ? Expanded(
                          child: TabBarView(
                              controller: _tabController, children: pages))
                      : const No_Internet_Page()
        ],
      ),
    );
  }
}
