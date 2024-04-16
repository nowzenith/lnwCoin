import 'package:lnwCoin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../utils/extensions/lottie_extension.dart';

class No_Internet_Page extends StatefulWidget {
  const No_Internet_Page({super.key});

  @override
  State<No_Internet_Page> createState() => _No_Internet_PageState();
}

class _No_Internet_PageState extends State<No_Internet_Page>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: DurationConstants.lottieMedium());
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 150),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset(
            "assets/lottie/no_internet.json",
            fit: BoxFit.cover,
            repeat: true,
            animate: true,
            controller: _animationController,
            onLoaded: (p0) {
              _animationController.forward();
              _animationController.repeat();
            },
          ),
        ],
      ),
    );
  }
}
