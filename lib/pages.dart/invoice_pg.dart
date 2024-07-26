import 'package:flutter/material.dart';
import 'package:inventory_management_app/component/pdf_view.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

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

  Future<String> generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Invoice ${invoiceData['invoice_number']}',
                style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            pw.Text('Invoice Date: ${invoiceData['invoice_date']}'),
            pw.Text('Due Date: ${invoiceData['due_date']}'),
            pw.SizedBox(height: 20),
            _buildPdfSellerInfo(),
            pw.SizedBox(height: 20),
            _buildPdfBuyerInfo(),
            pw.SizedBox(height: 20),
            _buildPdfItems(),
            pw.SizedBox(height: 20),
            _buildPdfFinancialSummary(),
            pw.SizedBox(height: 20),
            _buildPdfPaymentInfo(),
            pw.SizedBox(height: 20),
            _buildPdfAdditionalInfo(),
          ],
        ),
      ),
    );

    // Save PDF to user's Desktop
    final directory = Directory(p.join(Platform.environment['USERPROFILE']!, 'Desktop'));
    final file = File(p.join(directory.path, 'invoice.pdf'));
    await file.writeAsBytes(await pdf.save());
    return file.path; // Return the file path
//this is for macos
    Future<Directory> getDesktopDirectory() async {
      final homeDir =
          Directory.current.path; // Get current directory (should be user's home directory)
      return Directory(p.join(homeDir, 'Desktop')); // Join with 'Desktop'
    }
    //      tTHIS IS FOR MOBILE APP
    // final output = await getTemporaryDirectory();
    // final file = File("${output.path}/invoice.pdf");
    // await file.writeAsBytes(await pdf.save());
    // return file.path; // Return the file path
  }

  pw.Widget _buildPdfSellerInfo() {
    final seller = invoiceData['seller'];
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(seller['company_name'], style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Text(seller['address']),
        pw.Text('Email: ${seller['contact']['email']}'),
        pw.Text('Phone: ${seller['contact']['phone']}'),
      ],
    );
  }

  pw.Widget _buildPdfBuyerInfo() {
    final buyer = invoiceData['buyer'];
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(buyer['customer_name'], style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Text(buyer['address']),
        pw.Text('Email: ${buyer['contact']['email']}'),
        pw.Text('Phone: ${buyer['contact']['phone']}'),
      ],
    );
  }

  pw.Widget _buildPdfItems() {
    final items = invoiceData['items'] as List<dynamic>;
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Items:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        ...items.map((item) {
          return pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Expanded(
                child: pw.Text(item['description']),
              ),
              pw.Text('Quantity: ${item['quantity']}'),
              pw.Text('Price: ₹${item['total_price']}'),
            ],
          );
        }),
      ],
    );
  }

  pw.Widget _buildPdfFinancialSummary() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Subtotal: ₹${invoiceData['subtotal']}'),
        pw.Text('Tax: ₹${invoiceData['tax']}'),
        pw.Text('Discount: -₹${invoiceData['discount']}'),
        pw.Text('Total: ₹${invoiceData['total']}',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ],
    );
  }

  pw.Widget _buildPdfPaymentInfo() {
    final paymentInfo = invoiceData['payment_information'];
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Payment Terms: ${paymentInfo['terms']}'),
        pw.Text('Accepted Payment Methods: ${paymentInfo['accepted_methods'].join(', ')}'),
        pw.Text('Bank Details:'),
        pw.Text('  Account Number: ${paymentInfo['bank_details']['account_number']}'),
        pw.Text('  Sort Code: ${paymentInfo['bank_details']['sort_code']}'),
        pw.Text('Payment Instructions: ${paymentInfo['instructions']}'),
      ],
    );
  }

  pw.Widget _buildPdfAdditionalInfo() {
    final additionalInfo = invoiceData['additional_information'];
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Notes: ${additionalInfo['notes']}'),
        pw.Text('Terms and Conditions: ${additionalInfo['terms_and_conditions']}'),
      ],
    );
  }

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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final pdfPath = await generatePdf();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PDFScreen(path: pdfPath),
            ),
          );
        },
        child: const Icon(Icons.picture_as_pdf),
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
