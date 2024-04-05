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

class _MyWalletViewState extends State<MyWalletView> with TickerProviderStateMixin {
  late AnimationController _animationController;

  late W3MService w3mServices;

  void initializeService() async {
    w3mServices = W3MService(
      projectId: '7cb46dad9b7e8c69ea65c450b55fe035',
      metadata: const PairingMetadata(
        name: 'lnwCoin',
        description: 'lnwCoin',
        url: 'https://www.walletconnect.com/',
        icons: ['https://docs.walletconnect.com/assets/images/web3modalLogo-2cee77e07851ba0a710b56d03d4d09dd.png'],
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
    return Stack(
      children: [
        const BackgroundImage(),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              W3MConnectWalletButton(service: w3mServices),
              const SizedBox(height: 16),
              W3MNetworkSelectButton(service: w3mServices),
              const  SizedBox(height: 16),
              W3MAccountButton(service: w3mServices)
            ],
          ),
        ),
      ],
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
