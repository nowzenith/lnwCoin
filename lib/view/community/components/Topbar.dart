import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
                isScrollable: false,
                labelPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                labelColor: const Color.fromARGB(255, 170, 0, 28),
                unselectedLabelColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: Colors.white),
                tabs: const [
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Metaverse"),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Game"),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Post"),
                    ),
                  ),
                ],
                indicatorColor: const Color.fromARGB(255, 170, 0, 28)),
          ),
          // This Expanded widget lets the TabBarView take up the remaining space.
          Expanded(
            child: TabBarView(
              controller: widget.tabController,
              children: const [
                Center(child: Text('Metaverse')),
                Center(child: Text('Game')),
                Center(child: Text('Post')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
