import 'package:flutter/material.dart';

class Salesman {
  final String name;
  final double amount;
  final bool isClaimed;

  Salesman({required this.name, required this.amount, required this.isClaimed});
}

class ClientPage extends StatelessWidget {
  const ClientPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Salesman> salesmen = [
      Salesman(name: 'John Doe', amount: 1500.0, isClaimed: true),
      Salesman(name: 'Jane Smith', amount: 1200.0, isClaimed: false),
      Salesman(name: 'Robert Brown', amount: 900.0, isClaimed: true),
      Salesman(name: 'Emily Davis', amount: 700.0, isClaimed: false),
      Salesman(name: 'Michael Wilson', amount: 1100.0, isClaimed: true),
      Salesman(name: 'Sarah Johnson', amount: 1300.0, isClaimed: false),
      Salesman(name: 'David Martinez', amount: 800.0, isClaimed: true),
      Salesman(name: 'Laura Garcia', amount: 950.0, isClaimed: false),
      Salesman(name: 'James Anderson', amount: 1250.0, isClaimed: true),
      Salesman(name: 'Patricia Thomas', amount: 1400.0, isClaimed: false),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Salesman Claims'),
      ),
      body: ListView.builder(
        itemCount: salesmen.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Icon(
                salesmen[index].isClaimed ? Icons.check_circle : Icons.cancel,
                color: salesmen[index].isClaimed ? Colors.green : Colors.red,
              ),
              title: Text(salesmen[index].name),
              subtitle: Text('Amount: \$${salesmen[index].amount.toStringAsFixed(2)}'),
            ),
          );
        },
      ),
    );
  }
}
