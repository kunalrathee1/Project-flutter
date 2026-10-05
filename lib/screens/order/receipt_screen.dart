// ============================================================
// ReceiptScreen – Digital Receipt & Tax Invoice with itemized
// GST breakdown, printable/downloadable PDF via printing package.
// ============================================================
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';

import '../../core/app_colors.dart';
import '../../core/app_formatters.dart';
import '../../l10n/app_localizations.dart';
import '../../models/models.dart';
import '../../providers/order_provider.dart';

class ReceiptScreen extends StatefulWidget {
  final String orderId;
  const ReceiptScreen({super.key, required this.orderId});

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  bool _isGeneratingPdf = false;

  Future<pw.Document> _buildPdfDoc(Order order) async {
    final doc = pw.Document();

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              pw.Center(
                child: pw.Column(
                  children: [
                    pw.Text(
                      'RELIANCE SMART BAZAAR',
                      style: pw.TextStyle(
                        fontSize: 20,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.red900,
                      ),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text('Reliance Retail Limited • Store: ${order.storeName}',
                        style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700)),
                    pw.Text('GSTIN: 27AAACR7191N1ZG | FSSAI Lic No: 11518018000456',
                        style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey600)),
                    pw.SizedBox(height: 8),
                    pw.Container(
                      padding: const pw.EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: pw.BoxDecoration(
                        color: PdfColors.grey200,
                        borderRadius: pw.BorderRadius.circular(4),
                      ),
                      child: pw.Text(
                        order.hasGstInvoice ? 'TAX INVOICE' : 'RETAIL INVOICE / CASH RECEIPT',
                        style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 16),
              pw.Divider(thickness: 1, color: PdfColors.grey400),
              pw.SizedBox(height: 8),

              // Order & Customer Details
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Invoice No: ${order.id}',
                          style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
                      pw.Text('Date & Time: ${AppFormatters.dateTime(order.placedAt)}',
                          style: const pw.TextStyle(fontSize: 9)),
                      pw.Text('Payment Mode: ${order.paymentMethod.toUpperCase()} (PAID)',
                          style: const pw.TextStyle(fontSize: 9)),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text('Customer: ${order.deliveryAddress.fullName}',
                          style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
                      pw.Text('${order.deliveryAddress.flatDoor}, ${order.deliveryAddress.streetLocality}',
                          style: const pw.TextStyle(fontSize: 9)),
                      pw.Text('${order.deliveryAddress.city} - ${order.deliveryAddress.pincode}',
                          style: const pw.TextStyle(fontSize: 9)),
                      if (order.hasGstInvoice && order.gstDetails != null) ...[
                        pw.Text('GSTIN: ${order.gstDetails!.gstin}',
                            style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold)),
                      ],
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 16),

              // Items Table
              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
                columnWidths: {
                  0: const pw.FlexColumnWidth(3),
                  1: const pw.FlexColumnWidth(1),
                  2: const pw.FlexColumnWidth(1.2),
                  3: const pw.FlexColumnWidth(1.2),
                },
                children: [
                  // Table Header
                  pw.TableRow(
                    decoration: const pw.BoxDecoration(color: PdfColors.grey100),
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text('Item Description',
                            style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text('Qty',
                            style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                            textAlign: pw.TextAlign.center),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text('Rate',
                            style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                            textAlign: pw.TextAlign.right),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text('Amount',
                            style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                            textAlign: pw.TextAlign.right),
                      ),
                    ],
                  ),
                  // Table Rows
                  ...order.items.map((item) {
                    final unitPrice = item.variant.pricePerUnit;
                    final total = unitPrice * item.quantity;
                    final qtyStr = item.variant.isLoose
                        ? AppFormatters.weight(item.quantity)
                        : '${item.quantity.toInt()} pk';
                    return pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(6),
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(item.product.nameEn,
                                  style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold)),
                              pw.Text(
                                '${item.variant.label}${item.ripeness != null ? ' (${item.ripeness!.name})' : ''}',
                                style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey700),
                              ),
                            ],
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(6),
                          child: pw.Text(qtyStr,
                              style: const pw.TextStyle(fontSize: 9),
                              textAlign: pw.TextAlign.center),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(6),
                          child: pw.Text('Rs ${unitPrice.toStringAsFixed(2)}',
                              style: const pw.TextStyle(fontSize: 9),
                              textAlign: pw.TextAlign.right),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(6),
                          child: pw.Text('Rs ${total.toStringAsFixed(2)}',
                              style: const pw.TextStyle(fontSize: 9),
                              textAlign: pw.TextAlign.right),
                        ),
                      ],
                    );
                  }),
                ],
              ),
              pw.SizedBox(height: 16),

              // Summary
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Container(
                    width: 200,
                    child: pw.Column(
                      children: [
                        _pdfRow('Subtotal:', 'Rs ${order.bill.subtotal.toStringAsFixed(2)}'),
                        if (order.bill.bulkDiscount > 0)
                          _pdfRow('Bulk Discount (5%):',
                              '- Rs ${order.bill.bulkDiscount.toStringAsFixed(2)}',
                              color: PdfColors.green800),
                        if (order.bill.memberDiscount > 0)
                          _pdfRow('JioPrime Discount (5%):',
                              '- Rs ${order.bill.memberDiscount.toStringAsFixed(2)}',
                              color: PdfColors.green800),
                        _pdfRow('Delivery Fee:',
                            order.bill.deliveryFee == 0 ? 'FREE' : 'Rs ${order.bill.deliveryFee.toStringAsFixed(2)}'),
                        _pdfRow('CGST (2.5%):', 'Rs ${order.bill.cgst.toStringAsFixed(2)}'),
                        _pdfRow('SGST (2.5%):', 'Rs ${order.bill.sgst.toStringAsFixed(2)}'),
                        pw.Divider(color: PdfColors.grey400),
                        _pdfRow('Grand Total:',
                            'Rs ${order.bill.grandTotal.toStringAsFixed(2)}',
                            isBold: true, fontSize: 12),
                        pw.SizedBox(height: 4),
                        pw.Text(
                          'Total Savings: Rs ${order.bill.totalSavings.toStringAsFixed(2)}',
                          style: pw.TextStyle(
                            fontSize: 10,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.green800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              pw.Spacer(),

              // Footer
              pw.Center(
                child: pw.Column(
                  children: [
                    pw.Text('Thank you for shopping at Reliance Smart Bazaar!',
                        style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
                    pw.Text('For customer support, visit reliancesmartbazaar.com or call 1800-891-0001',
                        style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey600)),
                    pw.SizedBox(height: 4),
                    pw.Text('This is a computer generated invoice and does not require physical signature.',
                        style: const pw.TextStyle(fontSize: 7, color: PdfColors.grey500)),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    return doc;
  }

  pw.Widget _pdfRow(String label, String value,
      {bool isBold = false, double fontSize = 9, PdfColor? color}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label,
              style: pw.TextStyle(
                  fontSize: fontSize,
                  fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal)),
          pw.Text(value,
              style: pw.TextStyle(
                  fontSize: fontSize,
                  fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
                  color: color ?? PdfColors.black)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final orderProvider = context.watch<OrderProvider>();
    final order = orderProvider.orderById(widget.orderId);

    if (order == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.digitalReceipt)),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: AppColors.error),
              const SizedBox(height: 16),
              const Text('Receipt not found'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.go('/orders'),
                child: Text(l10n.back),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          order.hasGstInvoice ? l10n.taxInvoice : l10n.digitalReceipt,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            tooltip: l10n.shareReceipt,
            onPressed: () async {
              setState(() => _isGeneratingPdf = true);
              try {
                final pdf = await _buildPdfDoc(order);
                final bytes = await pdf.save();
                await Printing.sharePdf(
                  bytes: bytes,
                  filename: 'Receipt_${order.id}.pdf',
                );
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to share PDF: $e')),
                  );
                }
              } finally {
                if (mounted) setState(() => _isGeneratingPdf = false);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.print_outlined),
            tooltip: l10n.downloadPdf,
            onPressed: () async {
              setState(() => _isGeneratingPdf = true);
              try {
                final pdf = await _buildPdfDoc(order);
                await Printing.layoutPdf(
                  onLayout: (format) async => pdf.save(),
                  name: 'Receipt_${order.id}.pdf',
                );
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to print: $e')),
                  );
                }
              } finally {
                if (mounted) setState(() => _isGeneratingPdf = false);
              }
            },
          ),
        ],
      ),
      body: _isGeneratingPdf
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Receipt Paper Card
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Reliance Header
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'RELIANCE SMART BAZAAR',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                order.storeName,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  order.hasGstInvoice ? 'TAX INVOICE' : 'DIGITAL RECEIPT',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Store & Invoice Info
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _ReceiptRow(label: 'Order ID', value: order.id, isBold: true),
                              const SizedBox(height: 6),
                              _ReceiptRow(
                                  label: 'Date & Time',
                                  value: AppFormatters.dateTime(order.placedAt)),
                              const SizedBox(height: 6),
                              _ReceiptRow(
                                  label: 'Delivery Slot',
                                  value:
                                      '${AppFormatters.shortDate(order.slot.date)} • ${AppFormatters.slotTime(order.slot.startHour)}'),
                              const SizedBox(height: 6),
                              _ReceiptRow(
                                  label: 'Delivered To',
                                  value:
                                      '${order.deliveryAddress.fullName}, ${order.deliveryAddress.city}'),
                              if (order.hasGstInvoice && order.gstDetails != null) ...[
                                const SizedBox(height: 6),
                                _ReceiptRow(
                                    label: 'Business Name',
                                    value: order.gstDetails!.businessName),
                                const SizedBox(height: 6),
                                _ReceiptRow(
                                    label: 'GSTIN', value: order.gstDetails!.gstin),
                              ],
                              const Divider(height: 24),

                              // Items Table Header
                              const Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      'Item',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Qty',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Rate',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Amount',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              const Divider(height: 1),
                              const SizedBox(height: 8),

                              // Item Rows
                              ...order.items.map((item) {
                                final unitPrice = item.variant.pricePerUnit;
                                final lineTotal = unitPrice * item.quantity;
                                final qtyStr = item.variant.isLoose
                                    ? AppFormatters.weight(item.quantity)
                                    : '${item.quantity.toInt()} pk';

                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 6),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.product.nameEn,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              '${item.variant.label}${item.ripeness != null ? ' • ${item.ripeness!.name}' : ''}',
                                              style: const TextStyle(
                                                fontSize: 10,
                                                color: AppColors.textHint,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          qtyStr,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          AppFormatters.currency(unitPrice),
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          AppFormatters.currency(lineTotal),
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),

                              const Divider(height: 24),

                              // Bill Breakdown
                              _ReceiptRow(
                                  label: 'Subtotal',
                                  value: AppFormatters.currency(order.bill.subtotal)),
                              if (order.bill.bulkDiscount > 0) ...[
                                const SizedBox(height: 6),
                                _ReceiptRow(
                                  label: 'Bulk Discount (5%)',
                                  value: '- ${AppFormatters.currency(order.bill.bulkDiscount)}',
                                  valueColor: AppColors.freshGreen,
                                ),
                              ],
                              if (order.bill.memberDiscount > 0) ...[
                                const SizedBox(height: 6),
                                _ReceiptRow(
                                  label: 'JioPrime Discount (5%)',
                                  value: '- ${AppFormatters.currency(order.bill.memberDiscount)}',
                                  valueColor: AppColors.freshGreen,
                                ),
                              ],
                              const SizedBox(height: 6),
                              _ReceiptRow(
                                label: 'Delivery Fee',
                                value: order.bill.deliveryFee == 0
                                    ? 'FREE'
                                    : AppFormatters.currency(order.bill.deliveryFee),
                                valueColor: order.bill.deliveryFee == 0 ? AppColors.freshGreen : null,
                              ),
                              const SizedBox(height: 6),
                              _ReceiptRow(
                                  label: 'CGST (2.5%)',
                                  value: AppFormatters.currency(order.bill.cgst)),
                              const SizedBox(height: 6),
                              _ReceiptRow(
                                  label: 'SGST (2.5%)',
                                  value: AppFormatters.currency(order.bill.sgst)),
                              const Divider(height: 20),
                              _ReceiptRow(
                                label: 'Grand Total',
                                value: AppFormatters.currency(order.bill.grandTotal),
                                isBold: true,
                                fontSize: 16,
                                valueColor: AppColors.primary,
                              ),
                              const SizedBox(height: 6),
                              _ReceiptRow(
                                label: 'Payment Mode',
                                value: '${order.paymentMethod.toUpperCase()} (PAID)',
                                valueColor: AppColors.freshGreen,
                                isBold: true,
                              ),
                              const SizedBox(height: 16),

                              // Savings Callout
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColors.freshGreen.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: AppColors.freshGreen.withValues(alpha: 0.3),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.savings, color: AppColors.freshGreen, size: 20),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        'You saved ${AppFormatters.currency(order.bill.totalSavings)} on this order!',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: AppColors.freshGreen,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Barcode placeholder simulation
                              Center(
                                child: Column(
                                  children: [
                                    Container(
                                      width: 220,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: AppColors.background,
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(color: AppColors.divider),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: List.generate(
                                          28,
                                          (i) => Container(
                                            width: (i % 3 == 0) ? 3 : ((i % 2 == 0) ? 1.5 : 2),
                                            height: 36,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      order.id,
                                      style: const TextStyle(
                                        fontSize: 10,
                                        letterSpacing: 2,
                                        color: AppColors.textHint,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Bottom Action Buttons
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () async {
                            final pdf = await _buildPdfDoc(order);
                            final bytes = await pdf.save();
                            await Printing.sharePdf(
                              bytes: bytes,
                              filename: 'Receipt_${order.id}.pdf',
                            );
                          },
                          icon: const Icon(Icons.share_outlined),
                          label: Text(l10n.shareReceipt),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            final pdf = await _buildPdfDoc(order);
                            await Printing.layoutPdf(
                              onLayout: (format) async => pdf.save(),
                              name: 'Receipt_${order.id}.pdf',
                            );
                          },
                          icon: const Icon(Icons.download_outlined),
                          label: Text(l10n.downloadPdf),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
    );
  }
}

class _ReceiptRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final double fontSize;
  final Color? valueColor;

  const _ReceiptRow({
    required this.label,
    required this.value,
    this.isBold = false,
    this.fontSize = 13,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w500,
            color: valueColor ?? AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
