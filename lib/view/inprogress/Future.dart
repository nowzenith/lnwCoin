import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../utils/constants.dart';
part 'components/app_bar.dart';

class FutureFeatureScreen extends StatefulWidget {
  const FutureFeatureScreen({super.key});

  @override
  State<FutureFeatureScreen> createState() => _FutureFeatureScreenState();
}

class _FutureFeatureScreenState extends State<FutureFeatureScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImage(),
        Scaffold(
        appBar: _AppBar(),
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.hourglass_empty,
                size: 80, // Large icon to draw attention
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(height: 20),
              Text(
                'Feature in Progress',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color:Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                'This exciting feature is on its way. Stay tuned!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color:Colors.white),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),]
    );
  }
}
