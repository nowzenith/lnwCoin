import 'package:lnwCoin/view/onboard/onboarding_view.dart';
import 'package:lnwCoin/view_model/onboard/onboarding_view_model.dart';
import 'package:lnwCoin/view_model/wallet_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

void main() async {
  await Future.delayed(Duration(seconds: 2));
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WalletViewModel()),
        ChangeNotifierProvider(create: (context) => OnBoardingViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Web3ModalTheme(
      isDarkMode: true,
      child: MaterialApp(
        title: 'Crypto Wallet App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: "Orbitron",
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.black,
          ),
        ),
        home: const OnBoardingView(),
      ),
    );
  }
}
