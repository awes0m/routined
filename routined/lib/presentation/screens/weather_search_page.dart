import 'package:flutter/material.dart';
import '../../core/widgets/custom_appbar.dart';

class WeatherSearchPage extends StatelessWidget {
  const WeatherSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(titleText: 'Weather Search'),
      body: Container(),
    );
  }
}
