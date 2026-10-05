// ============================================================
// CheckoutScreen – address, slot summary, GST toggle, order summary.
// ============================================================
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/app_colors.dart';
import '../../core/app_formatters.dart';
import '../../core/app_theme.dart';
import '../../core/validators.dart';
import '../../l10n/app_localizations.dart';
import '../../models/models.dart';
import '../../providers/auth_provider.dart';
import '../../providers/cart_provider.dart';
import '../../providers/profile_provider.dart';
import '../../widgets/widgets.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool _needGst = false;
  bool _summaryExpanded = false;
  Address? _selectedAddress;

  // GST form
  final _gstFormKey = GlobalKey<FormState>();
  final _bizNameCtrl = TextEditingController();
  final _gstinCtrl = TextEditingController();
  final _bizAddrCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    final profile = context.read<ProfileProvider>();
    _selectedAddress = profile.defaultAddress;
    // Pre-fill GST
    final gst = profile.gstDetails;
    if (gst != null) {
      _bizNameCtrl.text = gst.businessName;
      _gstinCtrl.text = gst.gstin;
      _bizAddrCtrl.text = gst.businessAddress;
      _emailCtrl.text = gst.email;
    }
  }

  @override
  void dispose() {
    _bizNameCtrl.dispose();
    _gstinCtrl.dispose();
    _bizAddrCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  Future<void> _proceed() async {
    final auth = context.read<AuthProvider>();
    if (auth.isGuest) {
      _showGuestDialog();
      return;
    }
    if (_needGst && !(_gstFormKey.currentState?.validate() ?? false)) {
      return;
    }
    if (_needGst) {
      final gst = GstDetails(
        businessName: _bizNameCtrl.text.trim(),
        gstin: _gstinCtrl.text.trim().toUpperCase(),
        businessAddress: _bizAddrCtrl.text.trim(),
        email: _emailCtrl.text.trim(),
      );
      await context.read<ProfileProvider>().setGstDetails(gst);
    }
    if (!mounted) return;
    context.push('/payment');
  }

  void _showGuestDialog() {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(l10n.guestCheckoutPrompt),
        content: const Text('Create an account to place your order.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.cancel)),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.push('/login');
            },
            child: Text(l10n.loginToPlaceOrder),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cart = context.watch<CartProvider>();
    final bill = cart.bill;
    final slot = cart.selectedSlot;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.checkout)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Delivery Address
          _SectionCard(
            title: l10n.deliveryAddress,
            trailing: TextButton(
              onPressed: _changeAddress,
              child: Text(l10n.changeAddress),
            ),
            child: _selectedAddress != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              _selectedAddress!.label,
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _selectedAddress!.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _selectedAddress!.fullAddress,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  )
                : TextButton(
                    onPressed: _changeAddress,
                    child: Text(l10n.addNewAddress),
                  ),
          ),

          const SizedBox(height: 12),

          // Slot summary
          if (slot != null)
            _SectionCard(
              title: l10n.slotSummary,
              child: Row(
                children: [
                  const Icon(Icons.schedule,
                      size: 18, color: AppColors.primary),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppFormatters.fullDate(slot.date),
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                        Text(
                          AppFormatters.slotTime(slot.startHour),
                          style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  if (slot.isFreeDelivery)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.freshGreen,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'Free Delivery',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                ],
              ),
            ),

          const SizedBox(height: 12),

          // GST Invoice toggle
          _SectionCard(
            title: '',
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.needGstInvoice,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    Switch(
                      value: _needGst,
                      onChanged: (v) => setState(() => _needGst = v),
                      activeColor: AppColors.primary,
                    ),
                  ],
                ),
                if (_needGst) ...[
                  const Divider(),
                  Form(
                    key: _gstFormKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _bizNameCtrl,
                          decoration: InputDecoration(
                              labelText: l10n.businessName),
                          validator: Validators.businessName,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _gstinCtrl,
                          decoration:
                              InputDecoration(labelText: l10n.gstin),
                          validator: Validators.gstin,
                          textCapitalization: TextCapitalization.characters,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _bizAddrCtrl,
                          decoration: InputDecoration(
                              labelText: l10n.businessAddress),
                          validator: Validators.address,
                          maxLines: 2,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _emailCtrl,
                          decoration:
                              InputDecoration(labelText: l10n.email),
                          validator: Validators.email,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Order summary (collapsible)
          _SectionCard(
            title: l10n.orderSummary,
            trailing: TextButton(
              onPressed: () =>
                  setState(() => _summaryExpanded = !_summaryExpanded),
              child: Text(_summaryExpanded ? 'Hide' : 'Show'),
            ),
            child: _summaryExpanded
                ? Column(
                    children: [
                      ...cart.items.map(
                        (i) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '${i.product.nameFor('en')} × ${i.quantity}',
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ),
                              Text(
                                AppFormatters.currency(
                                    i.variant.pricePerUnit * i.quantity),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(),
                      PriceBreakdownRow(
                        label: l10n.grandTotal,
                        value: AppFormatters.currency(bill.grandTotal),
                        isBold: true,
                        isLarge: true,
                      ),
                    ],
                  )
                : PriceBreakdownRow(
                    label: '${cart.itemCount} items',
                    value: AppFormatters.currency(bill.grandTotal),
                    isBold: true,
                  ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: slot == null ? null : _proceed,
            child:
                Text('${l10n.placeOrder} – ${AppFormatters.currency(bill.grandTotal)}'),
          ),
        ),
      ),
    );
  }

  void _changeAddress() {
    final profile = context.read<ProfileProvider>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        expand: false,
        builder: (_, ctrl) => ListView(
          controller: ctrl,
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Select Address',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            ...profile.addresses.map(
              (addr) => ListTile(
                leading: Icon(
                  addr.label == 'Home'
                      ? Icons.home
                      : addr.label == 'Office'
                          ? Icons.business
                          : Icons.location_on,
                  color: AppColors.primary,
                ),
                title: Text(addr.name),
                subtitle: Text(addr.fullAddress,
                    maxLines: 2, overflow: TextOverflow.ellipsis),
                trailing: _selectedAddress?.id == addr.id
                    ? const Icon(Icons.check_circle,
                        color: AppColors.primary)
                    : null,
                onTap: () {
                  setState(() => _selectedAddress = addr);
                  Navigator.pop(ctx);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final Widget child;

  const _SectionCard(
      {required this.title, this.trailing, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        boxShadow: [AppTheme.lightShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty) ...[
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
            const SizedBox(height: 10),
          ],
          child,
        ],
      ),
    );
  }
}
