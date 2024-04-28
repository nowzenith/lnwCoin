import 'dart:ui';

import 'package:lnwCoin/utils/constants.dart';
import 'package:lnwCoin/view_model/market_view_model.dart';
import 'package:lnwCoin/view_model/wallet_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:web3modal_flutter/web3modal_flutter.dart';

import '../../model/market_model.dart';

part 'components/grid_view.dart';
part 'components/wallet_card.dart';

class MyWalletView extends StatefulWidget {
  const MyWalletView({super.key});

  @override
  State<MyWalletView> createState() => _MyWalletViewState();
}

class _MyWalletViewState extends State<MyWalletView>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  late W3MService w3mServices;

  void initializeService() async {
    w3mServices = W3MService(
      projectId: '7cb46dad9b7e8c69ea65c450b55fe035',
      metadata: const PairingMetadata(
        name: 'lnwCoin',
        description: 'lnwCoin',
        url: 'https://www.walletconnect.com/',
        icons: [
          'https://docs.walletconnect.com/assets/images/web3modalLogo-2cee77e07851ba0a710b56d03d4d09dd.png'
        ],
        redirect: Redirect(
          native: 'lnwCoin://',
          universal: 'https://www.walletconnect.com',
        ),
      ),
    );

// Register callbacks on the Web3App you'd like to use. See `Events` section.

    await w3mServices.init();
  }

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));
    super.initState();
    initializeService();
  }

  @override
  dispose() {
    _animationController.dispose(); // you need this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Keep the AppBar simple

      body: Stack(
        children: [
          const BackgroundImage(), // Assuming you have a background image defined
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment
                  .start, // Align to the top of the center area
              children: [
                SizedBox(height: 50), // Space from the top
                // Logo, lnwCoin name, and description
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/icon/960x960.png", // Ensure the logo path is correct
                      height: 60, // Adjust size to fit your design
                    ),
                    SizedBox(height: 10), // Space between the logo and the name
                    const Text(
                      'lnwCoin',
                      style: TextStyle(
                        fontSize: 24, // Adjust text size to match your design
                        color: Colors
                            .white, // Ensure text is visible against background
                      ),
                    ),
                    SizedBox(
                        height:
                            5), // Space between the name and the description
                    Text(
                      'Large Network Wallet Coin',
                      style: TextStyle(
                        fontSize: 18, // Adjust text size for the description
                        color: Colors.white.withOpacity(
                            0.7), // Slightly faded to differentiate from the main title
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    height:
                        30), // Space between the header and the next component
                W3MConnectWalletButton(service: w3mServices),
                const SizedBox(height: 16),
                W3MNetworkSelectButton(service: w3mServices),
                const SizedBox(height: 16),
                W3MAccountButton(service: w3mServices),
                // More widgets can be added here
              ],
            ),
          ),
        ],
      ),
    );
  }

  BackdropFilter _backdropFilter() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: const BorderRadius.all(Radius.circular(16))),
      ),
    );
  }

  Padding _assetsLabel(WalletViewModel walletViewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          const Text(
            "My Assets",
            style: TextStyle(color: Colors.white, fontSize: 26),
          ),
          const SizedBox(width: 15),
          Text(
            '( ${walletViewModel.appWallet.length.toString()} )',
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ],
      ),
    );
  }

  Padding _getTestTokenButton(WalletViewModel walletViewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: InkWell(
        onTap: () {
          walletViewModel.changeTotalBalance(20000);
        },
        child: Container(
          height: 60,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15)),
          child: const Center(
            child: Text(
              "Get Test Tokens",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
