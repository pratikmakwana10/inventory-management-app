import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class InvoicePg extends StatefulWidget {
  static const Map<String, dynamic> invoiceData = {
    'invoice_number': '12345',
    'invoice_date': '27-07-2024',
    'due_date': '01-08-2024',
    'seller': {
      'company_name': 'Shell Organization',
      'address': '123 Seller St',
      'contact': {'email': 'seller@example.com', 'phone': '123-456-7890'},
    },
    'buyer': {
      'customer_name': 'Ratan Tata',
      'address': '456 Buyer Ave',
      'contact': {'email': 'buyer@example.com', 'phone': '098-765-4321'},
    },
    'items': [
      {'description': 'Item 1', 'quantity': 1, 'total_price': 100.00},
      {'description': 'Item 2', 'quantity': 2, 'total_price': 200.00},
    ],
    'subtotal': 300.00,
    'tax': 30.00,
    'discount': 10.00,
    'total': 320.00,
    'payment_information': {
      'terms': 'Net 30',
      'accepted_methods': ['Credit Card', 'Bank Transfer'],
      'bank_details': {'account_number': '12345678', 'sort_code': '12-34-56'},
      'instructions': 'Please make the payment within 30 days.',
    },
    'additional_information': {
      'notes': 'Thank you for your business!',
      'terms_and_conditions': 'All sales are final.',
    },
  };

  const InvoicePg({super.key});

  @override
  _InvoicePgState createState() => _InvoicePgState();
}

class _InvoicePgState extends State<InvoicePg> {
  final Map<String, dynamic> _invoiceData = InvoicePg.invoiceData;
  pw.Document _pdf = pw.Document();

  @override
  void initState() {
    super.initState();
  }

  void _generatePdf() {
    _pdf = pw.Document();

    _pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Container(
              decoration: const pw.BoxDecoration(
                color: PdfColors.blue, // Blue background color
              ),
              width: double.infinity,
              margin: const pw.EdgeInsets.symmetric(
                  vertical: 10, horizontal: 00), // Margin of 10 units on all sides
              child: pw.Padding(
                padding: const pw.EdgeInsets.symmetric(
                    vertical: 10, horizontal: 10), // Optional padding inside the container
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Invoice ${_invoiceData['invoice_number'] ?? ''}',
                      style: pw.TextStyle(
                        fontSize: 24,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.white, // White text color
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
            pw.Spacer(),
            _buildPdfAdditionalInfo(),
          ],
        ),
      ),
    );
  }

  pw.Widget _buildPdfSellerInfo() {
    final seller = _invoiceData['seller'] ?? {};
    final contact = seller['contact'] ?? {};
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(seller['company_name'] ?? '', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Text(seller['address'] ?? ''),
        pw.Text('Email: ${contact['email'] ?? ''}'),
        pw.Text('Phone: ${contact['phone'] ?? ''}'),
      ],
    );
  }

  pw.Widget _buildPdfBuyerInfo() {
    final buyer = _invoiceData['buyer'] ?? {};
    final contact = buyer['contact'] ?? {};
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(buyer['customer_name'] ?? '', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Text(buyer['address'] ?? ''),
        pw.Text('Email: ${contact['email'] ?? ''}'),
        pw.Text('Phone: ${contact['phone'] ?? ''}'),
      ],
    );
  }

  pw.Widget _buildPdfItems() {
    final items = _invoiceData['items'] as List<dynamic>? ?? [];

    return pw.Table(
      border: pw.TableBorder.all(width: 1, color: PdfColors.black),
      children: [
        // Header Row
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.green),
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.all(8),
              child: pw.Text(
                'Item Name',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white),
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(8),
              child: pw.Text(
                'Item Price',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white),
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(8),
              child: pw.Text(
                'Qtty',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white),
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(8),
              child: pw.Text(
                'GST (Tax)',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white),
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(8),
              child: pw.Text(
                'Item Total',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white),
              ),
            ),
          ],
        ),
        // Data Rows
        for (var item in items)
          pw.TableRow(
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.all(8),
                child: pw.Text(item['description'] ?? ''),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(8),
                child: pw.Text('${item['total_price']?.toStringAsFixed(2) ?? '0.00'}'),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(8),
                child: pw.Text('${item['quantity'] ?? 0}'),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(8),
                child: pw.Text(
                    '${item['gst']?.toStringAsFixed(2) ?? '0.00'}'), // Assuming gst key exists in item
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(8),
                child: pw.Text(
                  (item['quantity'] != null && item['total_price'] != null)
                      ? '${(item['quantity'] * item['total_price']).toStringAsFixed(2)}/-'
                      : '0.00',
                ),
              ),
            ],
          ),
      ],
    );
  }

  pw.Widget _buildPdfFinancialSummary() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Subtotal: ${_invoiceData['subtotal']?.toStringAsFixed(2) ?? '0.00'}/-'),
        pw.Text('Tax: ${_invoiceData['tax']?.toStringAsFixed(2) ?? '0.00'}/-'),
        pw.Text('Discount: -${_invoiceData['discount']?.toStringAsFixed(2) ?? '0.00'}/-'),
        pw.Text('Total: ${_invoiceData['total']?.toStringAsFixed(2) ?? '0.00'}/-',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ],
    );
  }

  pw.Widget _buildPdfPaymentInfo() {
    final paymentInfo = _invoiceData['payment_information'] ?? {};
    final bankDetails = paymentInfo['bank_details'] ?? {};
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Payment Terms: ${paymentInfo['terms'] ?? ''}'),
        pw.Text('Accepted Payment Methods: ${paymentInfo['accepted_methods']?.join(', ') ?? ''}'),
        pw.Text('Bank Details:'),
        pw.Text('  Account Number: ${bankDetails['account_number'] ?? ''}'),
        pw.Text('  Sort Code: ${bankDetails['sort_code'] ?? ''}'),
        pw.Text('Payment Instructions: ${paymentInfo['instructions'] ?? ''}'),
      ],
    );
  }

  pw.Widget _buildPdfAdditionalInfo() {
    final additionalInfo = _invoiceData['additional_information'] ?? {};
    return pw.Container(
        alignment: pw.Alignment.bottomCenter,
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            pw.Text('Notes: ${additionalInfo['notes'] ?? ''}',
                style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey)),
            pw.Text('Terms and Conditions: ${additionalInfo['terms_and_conditions'] ?? ''}',
                style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey)),
          ],
        ));
  }

  void _editInvoice() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Invoice'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: _invoiceData['seller']?['company_name'] ?? '',
                decoration: const InputDecoration(labelText: 'Seller Company Name'),
                onChanged: (value) {
                  setState(() {
                    _invoiceData['seller']?['company_name'] = value;
                  });
                },
              ),
              TextFormField(
                initialValue: _invoiceData['buyer']?['customer_name'] ?? '',
                decoration: const InputDecoration(labelText: 'Buyer Customer Name'),
                onChanged: (value) {
                  setState(() {
                    _invoiceData['buyer']?['customer_name'] = value;
                  });
                },
              ),
              // Add more fields as needed
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _generatePdf();
                });
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _viewPdf() {
    _generatePdf(); // Generate PDF first
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'PDF Preview',
            style: TextStyle(color: Colors.white),
          ),
          content: SizedBox(
            height: 600,
            width: 400,
            child: PdfPreview(
              build: (format) => _pdf.save(),
              canChangePageFormat: false,
              canChangeOrientation: false,
              canDebug: false,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice ${_invoiceData['invoice_number'] ?? ''}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Invoice Date: ${_invoiceData['invoice_date'] ?? ''}'),
              Text('Due Date: ${_invoiceData['due_date'] ?? ''}'),
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
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _editInvoice,
        child: const Icon(Icons.edit),
      ),
      bottomNavigationBar: BottomAppBar(
        child: TextButton(
          onPressed: _viewPdf,
          child: const Text('View PDF'),
        ),
      ),
    );
  }

  Widget _buildSellerInfo() {
    final seller = _invoiceData['seller'] ?? {};
    final contact = seller['contact'] ?? {};
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(seller['company_name'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(seller['address'] ?? ''),
        Text('Email: ${contact['email'] ?? ''}'),
        Text('Phone: ${contact['phone'] ?? ''}'),
      ],
    );
  }

  Widget _buildBuyerInfo() {
    final buyer = _invoiceData['buyer'] ?? {};
    final contact = buyer['contact'] ?? {};
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(buyer['customer_name'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(buyer['address'] ?? ''),
        Text('Email: ${contact['email'] ?? ''}'),
        Text('Phone: ${contact['phone'] ?? ''}'),
      ],
    );
  }

  Widget _buildItems() {
    final items = _invoiceData['items'] as List<dynamic>? ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Items:', style: TextStyle(fontWeight: FontWeight.bold)),
        ...items.map((item) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(item['description'] ?? ''),
              ),
              Text('Quantity: ${item['quantity'] ?? 0}'),
              Text('Price: ${item['total_price']?.toStringAsFixed(2) ?? '0.00'}'),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildFinancialSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Subtotal: ${_invoiceData['subtotal']?.toStringAsFixed(2) ?? '0.00'}'),
        Text('Tax: ${_invoiceData['tax']?.toStringAsFixed(2) ?? '0.00'}'),
        Text('Discount: -${_invoiceData['discount']?.toStringAsFixed(2) ?? '0.00'}'),
        Text('Total: ${_invoiceData['total']?.toStringAsFixed(2) ?? '0.00'}',
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildPaymentInfo() {
    final paymentInfo = _invoiceData['payment_information'] ?? {};
    final bankDetails = paymentInfo['bank_details'] ?? {};
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Payment Terms: ${paymentInfo['terms'] ?? ''}'),
        Text('Accepted Payment Methods: ${paymentInfo['accepted_methods']?.join(', ') ?? ''}'),
        const Text('Bank Details:'),
        Text('  Account Number: ${bankDetails['account_number'] ?? ''}'),
        Text('  Sort Code: ${bankDetails['sort_code'] ?? ''}'),
        Text('Payment Instructions: ${paymentInfo['instructions'] ?? ''}'),
      ],
    );
  }

  Widget _buildAdditionalInfo() {
    final additionalInfo = _invoiceData['additional_information'] ?? {};
    return Container(
      alignment: Alignment.bottomCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Notes: ${additionalInfo['notes'] ?? ''}',
            style: const TextStyle(fontSize: 8, color: Colors.grey),
          ),
          Text(
            'Terms and Conditions: ${additionalInfo['terms_and_conditions'] ?? ''}',
            style: const TextStyle(fontSize: 8, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
