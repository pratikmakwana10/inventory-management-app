import 'package:flutter/material.dart';
import 'package:inventory_management_app/component/bar_chart.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BarChartSample2(),
      ),
    );
  }
}
