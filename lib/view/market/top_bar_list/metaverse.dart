import 'package:flutter/material.dart';
import 'package:lnwCoin/utils/constants.dart';

class Metaverse_page extends StatelessWidget {
  const Metaverse_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImage(),
        Scaffold(
          backgroundColor: const Color.fromARGB(255, 24, 24, 24),
          body: Column(
            children: [
              Image.asset("assets/images/metaverse.png"),
              const SizedBox(
                height: 20,
              ),
              FilledButton(
                onPressed: () {},
                child: const Text('Soon',style: TextStyle(color: Colors.grey),),
                style: FilledButton.styleFrom(
                    backgroundColor: Color.fromARGB(194, 170, 0, 28)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
