import 'package:flutter/material.dart';

class BacktestPage extends StatelessWidget {
  const BacktestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('backtest')),
      body: Center(
        child: Text(
          'backtest_page',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
