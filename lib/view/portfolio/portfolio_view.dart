import 'package:lnwCoin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:lnwCoin/view/portfolio/components/owncoin.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

part 'components/app_bar.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> with TickerProviderStateMixin {

  @override
  void initState() {
    print("portfolio_view");
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        BackgroundImage(),
        Scaffold(
          appBar: _AppBar(),
          backgroundColor: Colors.transparent,
          body: const OwnCoinPage(),
        ),
      ],
    );
  }
}
