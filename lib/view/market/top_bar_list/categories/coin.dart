import 'package:flutter/material.dart';
import 'package:lnwCoin/view/market/top_bar_list/categories/meme.dart';

class Cate_coin_page extends StatefulWidget {
  final String name;
  const Cate_coin_page({super.key, required this.name});

  @override
  State<Cate_coin_page> createState() => _Cate_coin_pageState();
}

class _Cate_coin_pageState extends State<Cate_coin_page> {
  @override
  Widget build(BuildContext context) {
    return CryptoTrackerPage();
  }
}
