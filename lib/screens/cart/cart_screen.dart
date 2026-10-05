// ============================================================
// CartScreen – swipe-to-delete, live bill, slot button.
// ============================================================
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/app_colors.dart';
import '../../core/app_formatters.dart';
import '../../core/app_theme.dart';
import '../../l10n/app_localizations.dart';
import '../../models/models.dart';
import '../../providers/cart_provider.dart';
import '../../providers/language_provider.dart';
import '../../widgets/widgets.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cart = context.watch<CartProvider>();
    final locale = context.watch<LanguageProvider>().languageCode;
    final bill = cart.bill;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.myCart),
        actions: [
          if (cart.items.isNotEmpty)
            TextButton(
              onPressed: () => _confirmClearCart(context, l10n),
              child: const Text('Clear', style: TextStyle(color: Colors.white)),
            ),
        ],
      ),
      body: cart.isEmpty
          ? EmptyState(
              icon: Icons.shopping_cart_outlined,
              title: l10n.cartEmpty,
              subtitle: l10n.cartEmptySubtitle,
              actionLabel: l10n.shopNow,
              onAction: () => context.go('/home'),
            )
          : Column(
              children: [
                // Items list
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(12),
                    itemCount: cart.items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (ctx, i) {
                      final item = cart.items[i];
                      return _CartItemTile(
                        item: item,
                        locale: locale,
                        onRemove: () {
                          cart.removeItem(item.id);
                          ScaffoldMessenger.of(ctx).showSnackBar(
                            SnackBar(
                              content: Text(l10n.itemRemoved),
                              action: SnackBarAction(
                                label: l10n.undo,
                                onPressed: () => cart.addItem(
                                  product: item.product,
                                  variant: item.variant,
                                  quantity: item.quantity,
                                  ripeness: item.ripeness,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),

                // Bill details
                Container(
                  color: AppColors.surface,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.billDetails,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 8),
                      PriceBreakdownRow(
                        label: l10n.subtotal,
                        value: AppFormatters.currency(bill.subtotal),
                      ),
                      if (bill.bulkDiscount > 0)
                        PriceBreakdownRow(
                          label: l10n.bulkDiscount,
                          value:
                              '–${AppFormatters.currency(bill.bulkDiscount)}',
                          isGreen: true,
                        ),
                      if (bill.memberDiscount > 0)
                        PriceBreakdownRow(
                          label: l10n.memberDiscount,
                          value:
                              '–${AppFormatters.currency(bill.memberDiscount)}',
                          isGreen: true,
                        ),
                      PriceBreakdownRow(
                        label: l10n.deliveryFee,
                        value: bill.deliveryFee == 0
                            ? l10n.free
                            : AppFormatters.currency(bill.deliveryFee),
                        isGreen: bill.deliveryFee == 0,
                      ),
                      if (bill.totalGst > 0)
                        PriceBreakdownRow(
                          label:
                              '${l10n.cgst} + ${l10n.sgst}',
                          value: AppFormatters.currency(bill.totalGst),
                        ),
                      const Divider(height: 16),
                      PriceBreakdownRow(
                        label: l10n.grandTotal,
                        value: AppFormatters.currency(bill.grandTotal),
                        isBold: true,
                        isLarge: true,
                      ),
                      if (bill.totalSavings > 0) ...[
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.freshGreen.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.savings,
                                  color: AppColors.freshGreen, size: 16),
                              const SizedBox(width: 8),
                              Text(
                                l10n.youSave(
                                    AppFormatters.currency(bill.totalSavings)),
                                style: const TextStyle(
                                  color: AppColors.freshGreen,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
      bottomNavigationBar: cart.isEmpty
          ? null
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (cart.selectedSlot != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _SlotSummaryChip(slot: cart.selectedSlot!),
                      ),
                    OutlinedButton.icon(
                      onPressed: () => context.push('/slot'),
                      icon: const Icon(Icons.schedule),
                      label: Text(cart.selectedSlot == null
                          ? l10n.chooseDeliverySlot
                          : 'Change Slot'),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: cart.selectedSlot == null
                          ? null
                          : () => context.push('/checkout'),
                      child: Text(
                          '${l10n.proceedToCheckout} – ${AppFormatters.currency(bill.grandTotal)}'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  void _confirmClearCart(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Clear Cart?'),
        content: const Text('Remove all items from your cart?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              context.read<CartProvider>().clearCart();
              Navigator.pop(context);
            },
            child: Text(l10n.yes,
                style: const TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }
}

class _CartItemTile extends StatelessWidget {
  final CartItem item;
  final String locale;
  final VoidCallback onRemove;

  const _CartItemTile({
    required this.item,
    required this.locale,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartProvider>();

    return Dismissible(
      key: Key(item.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onRemove(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: AppColors.error,
          borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppTheme.cardRadius),
          boxShadow: [AppTheme.lightShadow],
        ),
        child: Row(
          children: [
            // Product image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 64,
                height: 64,
                child: item.product.imageUrl.isNotEmpty
                    ? Image.network(
                        item.product.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: AppColors.surfaceVariant,
                          child: Center(
                            child: Text(item.product.category.icon,
                                style:
                                    const TextStyle(fontSize: 24)),
                          ),
                        ),
                      )
                    : Container(
                        color: AppColors.surfaceVariant,
                        child: Center(
                          child: Text(item.product.category.icon,
                              style: const TextStyle(fontSize: 24)),
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.nameFor(locale),
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.variant.label,
                    style: const TextStyle(
                        fontSize: 11, color: AppColors.textHint),
                  ),
                  if (item.ripeness != null)
                    Text(
                      '${item.ripeness!.emoji} ${item.ripeness!.label}',
                      style: const TextStyle(
                          fontSize: 11, color: AppColors.textSecondary),
                    ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppFormatters.currency(
                            item.variant.pricePerUnit * item.quantity),
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                          fontSize: 14,
                        ),
                      ),
                      QtyStepper(
                        value: item.quantity,
                        step: item.variant.isLoose ? 0.5 : 1.0,
                        min: 0,
                        max: 10,
                        isLoose: item.variant.isLoose,
                        onChanged: (v) =>
                            cart.updateQuantity(item.id, v),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SlotSummaryChip extends StatelessWidget {
  final DeliverySlot slot;
  const _SlotSummaryChip({required this.slot});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.freshGreen.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: AppColors.freshGreen.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.schedule,
              size: 14, color: AppColors.freshGreen),
          const SizedBox(width: 6),
          Text(
            '${AppFormatters.shortDate(slot.date)} · ${AppFormatters.slotTime(slot.startHour)}',
            style: const TextStyle(
              color: AppColors.freshGreen,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
          if (slot.isFreeDelivery) ...[
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.freshGreen,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'FREE',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
