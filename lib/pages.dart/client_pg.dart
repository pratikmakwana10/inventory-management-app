import 'package:flutter/material.dart';

class Salesman {
  final String name;
  final double amount;
  final bool isClaimed;
  final String? gstNumber;

  Salesman({
    required this.name,
    required this.amount,
    required this.isClaimed,
    this.gstNumber,
  });
}

class ClientPage extends StatefulWidget {
  const ClientPage({super.key});

  @override
  _ClientPageState createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
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

  @override
  Widget build(BuildContext context) {
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
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Amount: \$${salesmen[index].amount.toStringAsFixed(2)}'),
                  if (salesmen[index].gstNumber != null)
                    Text('GST Number: ${salesmen[index].gstNumber}'),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddClientDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddClientDialog(BuildContext context) {
    final nameController = TextEditingController();
    final amountController = TextEditingController();
    final gstNumberController = TextEditingController();
    bool isClaimed = false;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Client'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: amountController,
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: gstNumberController,
                decoration: const InputDecoration(labelText: 'GST Number (Optional)'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('Claimed:'),
                  Checkbox(
                    value: isClaimed,
                    onChanged: (bool? value) {
                      setState(() {
                        isClaimed = value ?? false;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final name = nameController.text;
                final amount = double.tryParse(amountController.text) ?? 0.0;
                final gstNumber =
                    gstNumberController.text.isNotEmpty ? gstNumberController.text : null;

                setState(() {
                  salesmen.add(Salesman(
                    name: name,
                    amount: amount,
                    isClaimed: isClaimed,
                    gstNumber: gstNumber,
                  ));
                });

                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
