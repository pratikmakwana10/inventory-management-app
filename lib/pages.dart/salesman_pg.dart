import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_management_app/component/floating_button.dart';

// Define an enum for ClaimStatus
enum ClaimStatus { pending, received }

class Salesman {
  final String name;
  final double amount;
  final ClaimStatus claimStatus;
  final String? gstNumber;
  final String? mobileNumber;
  final String? productName;

  Salesman({
    required this.name,
    required this.amount,
    required this.claimStatus,
    this.gstNumber,
    this.mobileNumber,
    this.productName,
  });
}

class SlaesmanPg extends StatefulWidget {
  const SlaesmanPg({super.key});

  @override
  _SlaesmanPgState createState() => _SlaesmanPgState();
}

class _SlaesmanPgState extends State<SlaesmanPg> {
  List<Salesman> salesmen = [
    Salesman(name: 'John Doe', amount: 1500.0, claimStatus: ClaimStatus.received),
    Salesman(name: 'Jane Smith', amount: 1200.0, claimStatus: ClaimStatus.pending),
    Salesman(name: 'Robert Brown', amount: 900.0, claimStatus: ClaimStatus.received),
    Salesman(name: 'Emily Davis', amount: 700.0, claimStatus: ClaimStatus.pending),
    Salesman(name: 'Michael Wilson', amount: 1100.0, claimStatus: ClaimStatus.received),
    Salesman(name: 'Sarah Johnson', amount: 1300.0, claimStatus: ClaimStatus.pending),
    Salesman(name: 'David Martinez', amount: 800.0, claimStatus: ClaimStatus.received),
    Salesman(name: 'Laura Garcia', amount: 950.0, claimStatus: ClaimStatus.pending),
    Salesman(name: 'James Anderson', amount: 1250.0, claimStatus: ClaimStatus.received),
    Salesman(name: 'Patricia Thomas', amount: 1400.0, claimStatus: ClaimStatus.pending),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Salesman Claims',
          style: TextStyle(color: Colors.white, fontSize: 24.sp),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white, size: 24.sp),
      ),
      drawerScrimColor: Colors.transparent.withOpacity(.7),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 4, 116, 208),
              Color.fromARGB(255, 4, 147, 113),
            ],
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: salesmen.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(128, 175, 178, 177).withOpacity(0.15),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                leading: Icon(
                  salesmen[index].claimStatus == ClaimStatus.received
                      ? Icons.check_circle
                      : Icons.cancel,
                  color: salesmen[index].claimStatus == ClaimStatus.received
                      ? Colors.green
                      : Colors.red,
                ),
                title: Text(salesmen[index].name, style: const TextStyle(color: Colors.white)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Product Name: ${salesmen[index].productName ?? "N/A"}',
                        style: const TextStyle(color: Colors.white)),
                    Text('Amount: \$${salesmen[index].amount.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.white)),
                    Text('Mobile Number: ${salesmen[index].mobileNumber ?? "N/A"}',
                        style: const TextStyle(color: Colors.white)),
                    Text(
                        'Claim Status: ${salesmen[index].claimStatus == ClaimStatus.received ? "Received" : "Pending"}',
                        style: const TextStyle(color: Colors.white)),
                    if (salesmen[index].gstNumber != null)
                      Text('GST Number: ${salesmen[index].gstNumber}',
                          style: const TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: GradientFloatingActionButton(
        onPressed: () => _showAddClientDialog(context),
        icon: Icons.add,
        gradientColors: const [
          Color.fromARGB(255, 4, 116, 208), // Start color
          Color.fromARGB(255, 4, 147, 113), // End color
        ],
      ),
    );
  }

  void _showAddClientDialog(BuildContext context) {
    final nameController = TextEditingController();
    final amountController = TextEditingController();
    final gstNumberController = TextEditingController();
    final mobileNumberController = TextEditingController();
    final productNameController = TextEditingController();
    ClaimStatus claimStatus = ClaimStatus.pending; // Ensure default value is set

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Client'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Salesman Name'),
                  ),
                  TextField(
                    controller: amountController,
                    decoration: const InputDecoration(labelText: 'Amount'),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: mobileNumberController,
                    decoration: const InputDecoration(labelText: 'Mobile Number'),
                  ),
                  TextField(
                    controller: productNameController,
                    decoration: const InputDecoration(labelText: 'Product Name'),
                  ),
                  TextField(
                    controller: gstNumberController,
                    decoration: const InputDecoration(labelText: 'GST Number (Optional)'),
                  ),
                  Row(
                    children: [
                      const Text('Claim Status:'),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RadioListTile<ClaimStatus>(
                              title: const Text('Pending'),
                              value: ClaimStatus.pending,
                              groupValue: claimStatus,
                              onChanged: (ClaimStatus? value) {
                                if (value != null) {
                                  setState(() {
                                    claimStatus = value;
                                  });
                                }
                              },
                            ),
                            RadioListTile<ClaimStatus>(
                              title: const Text('Received'),
                              value: ClaimStatus.received,
                              groupValue: claimStatus,
                              onChanged: (ClaimStatus? value) {
                                if (value != null) {
                                  setState(() {
                                    claimStatus = value;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
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
                final mobileNumber =
                    mobileNumberController.text.isNotEmpty ? mobileNumberController.text : null;
                final productName =
                    productNameController.text.isNotEmpty ? productNameController.text : null;

                setState(() {
                  salesmen.add(Salesman(
                    name: name,
                    amount: amount,
                    claimStatus: claimStatus,
                    gstNumber: gstNumber,
                    mobileNumber: mobileNumber,
                    productName: productName,
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

class SalesmanPg extends StatelessWidget {
  const SalesmanPg({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Salesman"),
      ),
    );
  }
}
