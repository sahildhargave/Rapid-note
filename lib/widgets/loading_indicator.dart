import 'package:flutter/material.dart';
import 'package:colorful_circular_progress_indicator/colorful_circular_progress_indicator.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: ColorfulCircularProgressIndicator(
        colors: [Colors.blue, Colors.red, Colors.amber, Colors.green],
        strokeWidth: 5,
        indicatorHeight: 40,
        indicatorWidth: 40,
      ),
    );
  }
}
