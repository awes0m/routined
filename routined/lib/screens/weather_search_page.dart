import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/widgets/custom_appbar.dart';

class WeatherSearchPage extends StatefulWidget {
  const WeatherSearchPage({Key? key}) : super(key: key);

  @override
  _WeatherSearchPageState createState() => _WeatherSearchPageState();
}

class _WeatherSearchPageState extends State<WeatherSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Weather Search'),
      body: Container(),
    );
  }
}
