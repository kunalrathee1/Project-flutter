// ============================================================
// RepeatOrderScreen – Reorder previous items with availability,
// quantity adjustments, item selection, and adding to cart.
// ============================================================
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/app_colors.dart';
import '../../core/app_formatters.dart';
import '../../l10n/app_localizations.dart';
import '../../models/models.dart';
import '../../providers/cart_provider.dart';
import '../../providers/order_provider.dart';
import '../../providers/profile_provider.dart';

class RepeatOrderScreen extends StatefulWidget {
  final String orderId;
  const RepeatOrderScreen({super.key, required this.orderId});

  @override
  State<RepeatOrderScreen> createState() => _RepeatOrderScreenState();
}

class _RepeatOrderScreenState extends State<RepeatOrderScreen> {
  // Map of cartItem.id -> bool (selected)
  final Map<String, bool> _selected = {};
  // Map of cartItem.id -> double (quantity)
  final Map<String, double> _quantities = {};

  bool _initialized = false;

  void _initItems(Order order) {
    if (_initialized) return;
    for (final item in order.items) {
      _selected[item.id] = true;
      _quantities[item.id] = item.quantity;
    }
    _initialized = true;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final orderProvider = context.watch<OrderProvider>();
    final cartProvider = context.read<CartProvider>();
    final profileProvider = context.watch<ProfileProvider>();
    final order = orderProvider.orderById(widget.orderId);

    if (order == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.repeatOrder)),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: AppColors.error),
              const SizedBox(height: 16),
              const Text('Order not found'),
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

    _initItems(order);

    final jioPrime = profileProvider.jioPrime;

    // Calculate total price of selected items
    double selectedTotal = 0;
    int selectedCount = 0;
    for (final item in order.items) {
      if (_selected[item.id] == true) {
        final qty = _quantities[item.id] ?? item.quantity;
        final unitPrice = jioPrime
            ? item.variant.memberPricePerUnit
            : item.variant.pricePerUnit;
        selectedTotal += unitPrice * qty;
        selectedCount++;
      }
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          l10n.repeatOrder,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          // Order Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: AppColors.primary.withValues(alpha: 0.08),
            child: Row(
              children: [
                const Icon(Icons.replay, color: AppColors.primary, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reordering from ${order.id}',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        'Originally ordered on ${AppFormatters.fullDate(order.placedAt)}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Items list
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: order.items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = order.items[index];
                final isSelected = _selected[item.id] ?? true;
                final qty = _quantities[item.id] ?? item.quantity;
                final unitPrice = jioPrime
                    ? item.variant.memberPricePerUnit
                    : item.variant.pricePerUnit;
                final lineTotal = unitPrice * qty;

                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isSelected ? AppColors.primary.withValues(alpha: 0.5) : AppColors.divider,
                      width: isSelected ? 1.5 : 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Checkbox
                      Checkbox(
                        value: isSelected,
                        activeColor: AppColors.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        onChanged: (val) {
                          setState(() {
                            _selected[item.id] = val ?? false;
                          });
                        },
                      ),

                      // Thumbnail
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 52,
                          height: 52,
                          color: AppColors.background,
                          child: Image.network(
                            item.product.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.eco,
                              color: AppColors.freshGreen,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Item Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.product.nameEn,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${item.variant.label}${item.ripeness != null ? ' • ${item.ripeness!.name.toUpperCase()}' : ''}',
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  AppFormatters.currency(lineTotal),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 13,
                                    color: AppColors.primary,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.freshGreen.withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text(
                                    'In Stock',
                                    style: TextStyle(
                                      color: AppColors.freshGreen,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Quantity Stepper
                      if (isSelected)
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.divider),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () {
                                  final step = item.variant.isLoose ? 0.5 : 1.0;
                                  final min = item.variant.isLoose ? 0.5 : 1.0;
                                  if (qty - step >= min) {
                                    setState(() {
                                      _quantities[item.id] = qty - step;
                                    });
                                  }
                                },
                                borderRadius: BorderRadius.circular(6),
                                child: const Padding(
                                  padding: EdgeInsets.all(6),
                                  child: Icon(Icons.remove, size: 14),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                child: Text(
                                  item.variant.isLoose
                                      ? AppFormatters.weight(qty)
                                      : '${qty.toInt()}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  final step = item.variant.isLoose ? 0.5 : 1.0;
                                  setState(() {
                                    _quantities[item.id] = qty + step;
                                  });
                                },
                                borderRadius: BorderRadius.circular(6),
                                child: const Padding(
                                  padding: EdgeInsets.all(6),
                                  child: Icon(Icons.add, size: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Bottom Bar
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            decoration: BoxDecoration(
              color: AppColors.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$selectedCount items selected',
                      style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                    ),
                    Text(
                      AppFormatters.currency(selectedTotal),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: selectedCount == 0
                        ? null
                        : () {
                            for (final item in order.items) {
                              if (_selected[item.id] == true) {
                                final qty = _quantities[item.id] ?? item.quantity;
                                cartProvider.addItem(
                                  product: item.product,
                                  variant: item.variant,
                                  quantity: qty,
                                  ripeness: item.ripeness,
                                );
                              }
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('$selectedCount items added to cart!'),
                                backgroundColor: AppColors.freshGreen,
                                duration: const Duration(seconds: 2),
                              ),
                            );
                            context.go('/cart');
                          },
                    icon: const Icon(Icons.shopping_cart),
                    label: Text(l10n.addAllToCart),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
