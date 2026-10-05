// ============================================================
// PaymentScreen – UPI / Card / NetBanking / JioMoney / COD.
// Demo: any input places order; 2s processing animation.
// ============================================================
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/app_colors.dart';
import '../../core/app_formatters.dart';
import '../../core/app_theme.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/cart_provider.dart';
import '../../providers/order_provider.dart';
import '../../providers/profile_provider.dart';
import '../../providers/store_provider.dart';

enum PaymentMethod { upi, card, netBanking, jioMoney, cod }

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  PaymentMethod _method = PaymentMethod.upi;
  bool _processing = false;

  // UPI
  final _upiCtrl = TextEditingController();
  // Card
  final _cardNumCtrl = TextEditingController();
  final _expiryCtrl = TextEditingController();
  final _cvvCtrl = TextEditingController();
  final _cardHolderCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _upiCtrl.dispose();
    _cardNumCtrl.dispose();
    _expiryCtrl.dispose();
    _cvvCtrl.dispose();
    _cardHolderCtrl.dispose();
    super.dispose();
  }

  Future<void> _placeOrder() async {
    if (_method == PaymentMethod.card || _method == PaymentMethod.upi) {
      if (!(_formKey.currentState?.validate() ?? false)) return;
    }

    setState(() => _processing = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    final cart = context.read<CartProvider>();
    final orders = context.read<OrderProvider>();
    final store = context.read<StoreProvider>().selectedStore!;
    final profile = context.read<ProfileProvider>();

    final orderId = await orders.placeOrder(
      items: cart.items,
      deliveryAddress: profile.defaultAddress,
      slot: cart.selectedSlot!,
      bill: cart.bill,
      storeId: store.id,
      storeName: store.name,
      hasGstInvoice: _needGst,
      gstDetails: _needGst ? profile.gstDetails : null,
      paymentMethod: _method.name,
    );

    cart.clearCart();
    if (!mounted) return;
    setState(() => _processing = false);
    context.go('/order-confirmation', extra: orderId);
  }

  bool get _needGst => context.read<ProfileProvider>().gstDetails != null;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final bill = context.watch<CartProvider>().bill;

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(title: Text(l10n.payment)),
          body: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  l10n.selectPayment,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),

                // Payment method list
                ...PaymentMethod.values.map(
                  (m) => _PaymentTile(
                    method: m,
                    selected: _method == m,
                    onTap: () => setState(() => _method = m),
                    l10n: l10n,
                  ),
                ),
                const SizedBox(height: 16),

                // Input fields
                if (_method == PaymentMethod.upi) ...[
                  TextFormField(
                    controller: _upiCtrl,
                    decoration: InputDecoration(
                      labelText: l10n.upiId,
                      hintText: l10n.upiHint,
                      prefixIcon: const Icon(Icons.qr_code),
                    ),
                    validator: (v) =>
                        v == null || !v.contains('@') ? 'Enter valid UPI ID' : null,
                  ),
                ] else if (_method == PaymentMethod.card) ...[
                  TextFormField(
                    controller: _cardNumCtrl,
                    decoration: InputDecoration(
                      labelText: l10n.cardNumber,
                      prefixIcon: const Icon(Icons.credit_card),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(16),
                    ],
                    validator: (v) => v != null && v.length == 16
                        ? null
                        : 'Enter 16-digit card number',
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _expiryCtrl,
                          decoration: InputDecoration(
                              labelText: l10n.expiryDate,
                              hintText: 'MM/YY'),
                          keyboardType: TextInputType.datetime,
                          validator: (v) =>
                              v != null && RegExp(r'^\d{2}/\d{2}$').hasMatch(v)
                                  ? null
                                  : 'Invalid expiry',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          controller: _cvvCtrl,
                          decoration:
                              InputDecoration(labelText: l10n.cvv),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(4),
                          ],
                          obscureText: true,
                          validator: (v) =>
                              v != null && v.length >= 3 ? null : 'Invalid CVV',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _cardHolderCtrl,
                    decoration: InputDecoration(
                        labelText: l10n.cardholderName),
                    textCapitalization: TextCapitalization.words,
                    validator: (v) =>
                        v != null && v.trim().length > 2 ? null : 'Required',
                  ),
                ] else if (_method == PaymentMethod.cod) ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.offerOrange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.payments_outlined,
                            color: AppColors.offerOrange),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Pay with cash when your order arrives. '
                            'Please keep exact change ready.',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: _processing ? null : _placeOrder,
                child: Text(
                    l10n.payNow(AppFormatters.currency(bill.grandTotal))),
              ),
            ),
          ),
        ),

        // Processing overlay
        if (_processing)
          Container(
            color: Colors.black45,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(
                        color: AppColors.primary),
                    const SizedBox(height: 20),
                    Text(
                      l10n.processingPayment,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _PaymentTile extends StatelessWidget {
  final PaymentMethod method;
  final bool selected;
  final VoidCallback onTap;
  final AppLocalizations l10n;

  const _PaymentTile({
    required this.method,
    required this.selected,
    required this.onTap,
    required this.l10n,
  });

  IconData get _icon {
    switch (method) {
      case PaymentMethod.upi:
        return Icons.qr_code;
      case PaymentMethod.card:
        return Icons.credit_card;
      case PaymentMethod.netBanking:
        return Icons.account_balance;
      case PaymentMethod.jioMoney:
        return Icons.stars;
      case PaymentMethod.cod:
        return Icons.payments_outlined;
    }
  }

  String _label() {
    switch (method) {
      case PaymentMethod.upi:
        return l10n.upi;
      case PaymentMethod.card:
        return l10n.cards;
      case PaymentMethod.netBanking:
        return l10n.netBanking;
      case PaymentMethod.jioMoney:
        return l10n.jioMoney;
      case PaymentMethod.cod:
        return l10n.cod;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withOpacity(0.06)
              : AppColors.surface,
          borderRadius: BorderRadius.circular(AppTheme.cardRadius),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.divider,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              _icon,
              color: selected ? AppColors.primary : AppColors.textSecondary,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                _label(),
                style: TextStyle(
                  fontWeight:
                      selected ? FontWeight.w600 : FontWeight.w400,
                  color: selected ? AppColors.primary : AppColors.textPrimary,
                ),
              ),
            ),
            if (selected)
              const Icon(Icons.radio_button_checked,
                  color: AppColors.primary)
            else
              const Icon(Icons.radio_button_off,
                  color: AppColors.textHint),
          ],
        ),
      ),
    );
  }
}
