// ============================================================
// StoreDetailScreen – store info, inventory bars, directions.
// ============================================================
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/app_colors.dart';
import '../../core/app_formatters.dart';
import '../../data/mock_stores.dart';
import '../../l10n/app_localizations.dart';
import '../../models/models.dart';
import '../../providers/store_provider.dart';

class StoreDetailScreen extends StatelessWidget {
  final String storeId;
  const StoreDetailScreen({super.key, required this.storeId});

  StoreInfo? _findStore() {
    try {
      return mockStores.firstWhere((s) => s.id == storeId);
    } catch (_) {
      return null;
    }
  }

  Future<void> _openDirections(StoreInfo store) async {
    final url = Uri.parse(
        'https://maps.google.com/?q=${store.lat},${store.lng}');
    if (await canLaunchUrl(url)) await launchUrl(url);
  }

  Future<void> _callStore(StoreInfo store) async {
    final url = Uri.parse('tel:${store.phone}');
    if (await canLaunchUrl(url)) await launchUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    final store = _findStore();
    final l10n = AppLocalizations.of(context);
    final now = DateTime.now();

    if (store == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Store')),
        body: const Center(child: Text('Store not found')),
      );
    }

    final isOpen = store.isOpen(now);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 160,
            pinned: true,
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                store.name,
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.primary, AppColors.primaryDark],
                  ),
                ),
                child: const Center(
                  child: Icon(Icons.store, size: 60, color: Colors.white30),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Open/closed + code
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: (isOpen
                                  ? AppColors.freshGreen
                                  : AppColors.error)
                              .withOpacity(0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          isOpen ? l10n.openNow : l10n.closedNow,
                          style: TextStyle(
                            color: isOpen
                                ? AppColors.freshGreen
                                : AppColors.error,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '${l10n.storeCode}: ${store.code}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Address
                  _InfoRow(
                    icon: Icons.location_on_outlined,
                    text:
                        '${store.address}, ${store.city} – ${store.pincode}',
                  ),
                  const SizedBox(height: 10),
                  _InfoRow(
                    icon: Icons.access_time,
                    text:
                        '${l10n.storeTimings}: ${store.openHour}:00 AM – ${store.closeHour - 12}:00 PM',
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => _callStore(store),
                    child: _InfoRow(
                      icon: Icons.phone_outlined,
                      text: store.phone,
                      textColor: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _openDirections(store),
                          icon: const Icon(Icons.directions),
                          label: Text(l10n.getDirections),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _callStore(store),
                          icon: const Icon(Icons.call),
                          label: Text(l10n.callStore),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Inventory
                  Text(
                    l10n.inventoryLevels,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 12),
                  ...store.inventoryLevels.entries.map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _InventoryBar(
                        category: e.key,
                        level: e.value,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () async {
              await context.read<StoreProvider>().selectStore(store);
              if (!context.mounted) return;
              context.go('/home');
            },
            child: Text(l10n.shopFromStore),
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? textColor;

  const _InfoRow({required this.icon, required this.text, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: AppColors.textSecondary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: textColor ?? AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}

class _InventoryBar extends StatelessWidget {
  final ProductCategory category;
  final double level;

  const _InventoryBar({required this.category, required this.level});

  @override
  Widget build(BuildContext context) {
    final color = level >= 0.85
        ? AppColors.freshGreen
        : level >= 0.5
            ? AppColors.offerOrange
            : AppColors.error;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${category.icon} ${category.displayName}',
              style: const TextStyle(fontSize: 13),
            ),
            Text(
              AppFormatters.percent(level),
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: level,
            backgroundColor: AppColors.surfaceVariant,
            color: color,
            minHeight: 6,
          ),
        ),
      ],
    );
  }
}
