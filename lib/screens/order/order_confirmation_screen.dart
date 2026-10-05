// ============================================================
// OrderConfirmationScreen – success animation + timeline.
// ============================================================
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/app_colors.dart';
import '../../core/app_formatters.dart';
import '../../core/app_theme.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/order_provider.dart';

class OrderConfirmationScreen extends StatefulWidget {
  final String orderId;
  const OrderConfirmationScreen({super.key, required this.orderId});

  @override
  State<OrderConfirmationScreen> createState() =>
      _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scaleAnim;
  late Animation<double> _checkAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    _scaleAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _ctrl,
          curve: const Interval(0.0, 0.6, curve: Curves.elasticOut)),
    );
    _checkAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _ctrl,
          curve: const Interval(0.5, 1.0, curve: Curves.easeIn)),
    );
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final orders = context.watch<OrderProvider>();
    final order = orders.orderById(widget.orderId);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Success circle
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
                child: AnimatedBuilder(
                  animation: _ctrl,
                  builder: (_, __) => ScaleTransition(
                    scale: _scaleAnim,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppColors.freshGreen,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.freshGreen.withOpacity(0.3),
                            blurRadius: 24,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                      child: FadeTransition(
                        opacity: _checkAnim,
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 64,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Text(
                l10n.orderConfirmed,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.orderPlacedSubtitle,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),

              // Order info card
              if (order != null) ...[
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius:
                          BorderRadius.circular(AppTheme.cardRadius),
                      boxShadow: [AppTheme.lightShadow],
                    ),
                    child: Column(
                      children: [
                        _InfoRow2(
                          label: l10n.orderId,
                          value: '#${order.id.substring(0, 8).toUpperCase()}',
                          isBold: true,
                        ),
                        const SizedBox(height: 12),
                        _InfoRow2(
                          label: l10n.estimatedDelivery,
                          value: AppFormatters.fullDate(order.slot.date),
                        ),
                        const SizedBox(height: 12),
                        _InfoRow2(
                          label: l10n.grandTotal,
                          value: AppFormatters.currency(order.bill.grandTotal),
                          isBold: true,
                          valueColor: AppColors.primary,
                        ),
                        const SizedBox(height: 12),
                        _InfoRow2(
                          label: 'Payment',
                          value: order.paymentMethod.toUpperCase(),
                        ),
                      ],
                    ),
                  ),
                ),

                // Timeline
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.orderTimeline,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 12),
                      _TimelineTile(
                        icon: Icons.check_circle,
                        title: 'Order Placed',
                        subtitle: AppFormatters.dateTime(order.placedAt),
                        color: AppColors.freshGreen,
                        isDone: true,
                      ),
                      _TimelineTile(
                        icon: Icons.kitchen,
                        title: 'Being Prepared',
                        subtitle: 'Your items are being picked & packed',
                        color: AppColors.primary,
                        isDone: false,
                      ),
                      _TimelineTile(
                        icon: Icons.local_shipping,
                        title: 'Out for Delivery',
                        subtitle: 'Your order will arrive soon',
                        color: AppColors.textHint,
                        isDone: false,
                      ),
                      _TimelineTile(
                        icon: Icons.home,
                        title: 'Delivered',
                        subtitle: AppFormatters.slotTime(order.slot.startHour),
                        color: AppColors.textHint,
                        isDone: false,
                        isLast: true,
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 32),

              // Actions
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    if (order != null)
                      OutlinedButton.icon(
                        onPressed: () =>
                            context.push('/receipt/${order.id}'),
                        icon: const Icon(Icons.receipt),
                        label: Text(l10n.viewReceipt),
                      ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => context.go('/home'),
                      child: Text(l10n.continueShopping),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow2 extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final Color? valueColor;

  const _InfoRow2(
      {required this.label,
      required this.value,
      this.isBold = false,
      this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        Text(
          value,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            fontSize: isBold ? 14 : 13,
            color: valueColor ?? AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _TimelineTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final bool isDone;
  final bool isLast;

  const _TimelineTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.isDone,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color.withOpacity(isDone ? 1.0 : 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isDone ? Colors.white : color,
                size: 18,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 36,
                color: AppColors.divider,
              ),
          ],
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isDone
                        ? AppColors.textPrimary
                        : AppColors.textHint,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                if (!isLast) const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
