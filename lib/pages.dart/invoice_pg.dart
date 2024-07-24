import 'package:flutter/material.dart';

class InvoicePg extends StatelessWidget {
  static const Map<String, dynamic> invoiceData = {
    "invoice_number": "INV-12345",
    "invoice_date": "2024-07-25",
    "due_date": "2024-08-25",
    "seller": {
      "company_name": "ABC Corporation",
      "address": "123 Business St, Suite 100, Business City, BC 12345",
      "contact": {"email": "info@abccorp.com", "phone": "+1234567890"},
      "logo": "url_to_logo"
    },
    "buyer": {
      "customer_name": "John Doe",
      "address": "456 Customer Ave, Apt 789, Customer City, CC 67890",
      "contact": {"email": "john.doe@example.com", "phone": "+0987654321"}
    },
    "items": [
      {"description": "Product 1", "quantity": 2, "unit_price": 50.00, "total_price": 100.00},
      {"description": "Service A", "quantity": 5, "unit_price": 30.00, "total_price": 150.00}
    ],
    "subtotal": 250.00,
    "tax": 20.00,
    "discount": 10.00,
    "total": 260.00,
    "payment_information": {
      "terms": "Net 30",
      "accepted_methods": ["Credit Card", "Bank Transfer"],
      "bank_details": {"account_number": "123456789", "sort_code": "00-00-00"},
      "instructions": "Please make the payment within 30 days."
    },
    "additional_information": {
      "notes": "Thank you for your business!",
      "terms_and_conditions": "All sales are final."
    }
  };

  const InvoicePg({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice ${invoiceData['invoice_number']}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Invoice Date: ${invoiceData['invoice_date']}'),
              Text('Due Date: ${invoiceData['due_date']}'),
              const SizedBox(height: 20),
              _buildSellerInfo(),
              const SizedBox(height: 20),
              _buildBuyerInfo(),
              const SizedBox(height: 20),
              _buildItems(),
              const SizedBox(height: 20),
              _buildFinancialSummary(),
              const SizedBox(height: 20),
              _buildPaymentInfo(),
              const SizedBox(height: 20),
              _buildAdditionalInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSellerInfo() {
    final seller = invoiceData['seller'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(seller['company_name'], style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(seller['address']),
        Text('Email: ${seller['contact']['email']}'),
        Text('Phone: ${seller['contact']['phone']}'),
      ],
    );
  }

  Widget _buildBuyerInfo() {
    final buyer = invoiceData['buyer'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(buyer['customer_name'], style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(buyer['address']),
        Text('Email: ${buyer['contact']['email']}'),
        Text('Phone: ${buyer['contact']['phone']}'),
      ],
    );
  }

  Widget _buildItems() {
    final items = invoiceData['items'] as List<dynamic>;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Items:', style: TextStyle(fontWeight: FontWeight.bold)),
        ...items.map((item) => ListTile(
              title: Text(item['description']),
              subtitle: Text('Quantity: ${item['quantity']}'),
              trailing: Text('Price: ₹${item['total_price']}'),
            )),
      ],
    );
  }

  Widget _buildFinancialSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Subtotal: ₹${invoiceData['subtotal']}'),
        Text('Tax: ₹${invoiceData['tax']}'),
        Text('Discount: -₹${invoiceData['discount']}'),
        Text('Total: ₹${invoiceData['total']}',
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildPaymentInfo() {
    final paymentInfo = invoiceData['payment_information'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Payment Terms: ${paymentInfo['terms']}'),
        Text('Accepted Payment Methods: ${paymentInfo['accepted_methods'].join(', ')}'),
        const Text('Bank Details:'),
        Text('  Account Number: ${paymentInfo['bank_details']['account_number']}'),
        Text('  Sort Code: ${paymentInfo['bank_details']['sort_code']}'),
        Text('Payment Instructions: ${paymentInfo['instructions']}'),
      ],
    );
  }

  Widget _buildAdditionalInfo() {
    final additionalInfo = invoiceData['additional_information'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Notes: ${additionalInfo['notes']}'),
        Text('Terms and Conditions: ${additionalInfo['terms_and_conditions']}'),
      ],
    );
  }
}
