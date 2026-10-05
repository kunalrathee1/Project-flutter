// ============================================================
// ProductDetailScreen – meticulous product detail with:
// loose/packed toggle, ripeness selector, weight stepper,
// farmer map, member price, freshness guarantee, sticky bar.
// ============================================================
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../../core/app_colors.dart';
import '../../core/app_constants.dart';
import '../../core/app_formatters.dart';
import '../../core/app_theme.dart';
import '../../data/mock_products.dart';
import '../../l10n/app_localizations.dart';
import '../../models/models.dart';
import '../../providers/cart_provider.dart';
import '../../providers/language_provider.dart';
import '../../providers/profile_provider.dart';
import '../../widgets/widgets.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;
  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  Product? _product;
  late ProductVariant _selectedVariant;
  double _quantity = 1.0;
  Ripeness _ripeness = Ripeness.medium;
  bool _showLoose = true;

  @override
  void initState() {
    super.initState();
    try {
      _product = mockProducts.firstWhere((p) => p.id == widget.productId);
      _selectedVariant = _product!.defaultVariant;
      _showLoose = _selectedVariant.isLoose;
      _quantity = _selectedVariant.isLoose ? 0.5 : 1.0;
    } catch (_) {}
  }

  void _switchVariantType(bool loose) {
    final product = _product!;
    final variants =
        loose ? product.looseVariants : product.packedVariants;
    if (variants.isEmpty) return;
    setState(() {
      _showLoose = loose;
      _selectedVariant = variants.first;
      _quantity = loose ? 0.5 : 1.0;
    });
  }

  void _addToCart() {
    if (_product == null) return;
    final cart = context.read<CartProvider>();
    cart.addItem(
      product: _product!,
      variant: _selectedVariant,
      quantity: _quantity,
      ripeness: _product!.ripeness ? _ripeness : null,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            '${_product!.nameFor(context.read<LanguageProvider>().languageCode)} added to cart'),
        action: SnackBarAction(
          label: 'View Cart',
          onPressed: () => context.go('/cart'),
        ),
      ),
    );
  }

  void _showFreshnessPolicy() {
    final l10n = AppLocalizations.of(context);
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.verified,
                    color: AppColors.freshGreen, size: 24),
                const SizedBox(width: 8),
                Text(
                  l10n.freshnessGuarantee,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(l10n.freshnessPolicy),
            const SizedBox(height: 8),
            const Text(
              '• Products inspected at farm level\n'
              '• Temperature-controlled transport\n'
              '• Quality checked before dispatch\n'
              '• Easy return – just call/chat within 24h',
              style: TextStyle(fontSize: 13, height: 1.8),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Got it'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_product == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Product not found')),
      );
    }
    final product = _product!;
    final l10n = AppLocalizations.of(context);
    final locale = context.watch<LanguageProvider>().languageCode;
    final profile = context.watch<ProfileProvider>();
    final jioPrime = profile.jioPrime;
    final price = jioPrime
        ? _selectedVariant.memberPricePerUnit
        : _selectedVariant.pricePerUnit;
    final lineTotal = price * _quantity;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Product image app bar
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: AppColors.surface,
            iconTheme: const IconThemeData(color: AppColors.textPrimary),
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: product.imageUrl,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) => Container(
                  color: AppColors.surfaceVariant,
                  child: Center(
                    child: Text(
                      product.category.icon,
                      style: const TextStyle(fontSize: 80),
                    ),
                  ),
                ),
              ),
            ),
            title: Text(
              product.nameFor(locale),
              style: const TextStyle(color: AppColors.textPrimary),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name + badges
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.nameFor(locale),
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                      if (product.hasFreshnessGuarantee)
                        GestureDetector(
                          onTap: _showFreshnessPolicy,
                          child: const FreshnessBadge(),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  if (product.description != null)
                    Text(
                      product.description!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  const SizedBox(height: 16),

                  // Loose / Packed toggle
                  if (product.looseVariants.isNotEmpty &&
                      product.packedVariants.isNotEmpty)
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          _ToggleBtn(
                            label: l10n.loose,
                            active: _showLoose,
                            onTap: () => _switchVariantType(true),
                          ),
                          _ToggleBtn(
                            label: l10n.packed,
                            active: !_showLoose,
                            onTap: () => _switchVariantType(false),
                          ),
                        ],
                      ),
                    ),

                  // Variant selector (packed packs)
                  if (!_showLoose && product.packedVariants.length > 1) ...[
                    const SizedBox(height: 12),
                    Text(l10n.selectVariant,
                        style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: product.packedVariants.map((v) {
                        final selected = v.id == _selectedVariant.id;
                        return GestureDetector(
                          onTap: () =>
                              setState(() => _selectedVariant = v),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: selected
                                  ? AppColors.primary
                                  : AppColors.surface,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: selected
                                    ? AppColors.primary
                                    : AppColors.border,
                              ),
                            ),
                            child: Text(
                              v.label,
                              style: TextStyle(
                                color: selected
                                    ? Colors.white
                                    : AppColors.textPrimary,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],

                  // Weight / Qty stepper
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _showLoose ? l10n.selectWeight : l10n.qty,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      QtyStepper(
                        value: _quantity,
                        step: _selectedVariant.isLoose ? 0.5 : 1.0,
                        min: _selectedVariant.isLoose ? 0.5 : 1.0,
                        max: 10,
                        isLoose: _selectedVariant.isLoose,
                        onChanged: (v) => setState(() => _quantity = v),
                      ),
                    ],
                  ),

                  // Ripeness selector (fruits only)
                  if (product.ripeness) ...[
                    const SizedBox(height: 16),
                    Text(l10n.ripeness,
                        style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 8),
                    Row(
                      children: Ripeness.values.map((r) {
                        final selected = _ripeness == r;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _ripeness = r),
                            child: Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10),
                              decoration: BoxDecoration(
                                color: selected
                                    ? AppColors.primary.withOpacity(0.1)
                                    : AppColors.surface,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: selected
                                      ? AppColors.primary
                                      : AppColors.border,
                                  width: selected ? 2 : 1,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Text(r.emoji,
                                      style:
                                          const TextStyle(fontSize: 20)),
                                  const SizedBox(height: 4),
                                  Text(
                                    r.label,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: selected
                                          ? AppColors.primary
                                          : AppColors.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _ripeness.helperText,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],

                  // Price block
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Price',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  AppFormatters.currency(price),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                                if (jioPrime)
                                  Text(
                                    AppFormatters.currency(
                                        _selectedVariant.pricePerUnit),
                                    style: const TextStyle(
                                      color: AppColors.textHint,
                                      fontSize: 12,
                                      decoration:
                                          TextDecoration.lineThrough,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              l10n.totalPrice(''),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium,
                            ),
                            Text(
                              AppFormatters.currency(lineTotal),
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                        if (jioPrime) ...[
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const MemberBadge(),
                              const SizedBox(width: 8),
                              Text(
                                l10n.youSave(AppFormatters.currency(
                                    (_selectedVariant.pricePerUnit -
                                            _selectedVariant
                                                .memberPricePerUnit) *
                                        _quantity)),
                                style: const TextStyle(
                                  color: AppColors.freshGreen,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Farmer Source
                  if (product.farmer != null) ...[
                    const SizedBox(height: 20),
                    Text(l10n.farmerSource,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 12),
                    _FarmerCard(farmer: product.farmer!),
                  ],

                  const SizedBox(height: 100), // sticky bar space
                ],
              ),
            ),
          ),
        ],
      ),

      // Sticky add to cart bar
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppFormatters.currency(lineTotal),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      '${_selectedVariant.isLoose ? AppFormatters.weight(_quantity) : '${_quantity.toInt()} × ${_selectedVariant.label}'}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 180,
                child: ElevatedButton.icon(
                  onPressed: _addToCart,
                  icon: const Icon(Icons.add_shopping_cart, size: 18),
                  label: Text(l10n.addToCart),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ToggleBtn extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _ToggleBtn(
      {required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: active ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color:
                  active ? Colors.white : AppColors.textSecondary,
              fontWeight:
                  active ? FontWeight.w600 : FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

class _FarmerCard extends StatelessWidget {
  final FarmerInfo farmer;
  const _FarmerCard({required this.farmer});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        boxShadow: [AppTheme.lightShadow],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage: farmer.photoUrl != null
                      ? NetworkImage(farmer.photoUrl!)
                      : null,
                  backgroundColor: AppColors.freshGreen.withOpacity(0.2),
                  child: farmer.photoUrl == null
                      ? const Icon(Icons.person,
                          color: AppColors.freshGreen)
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        farmer.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        '${farmer.village}, ${farmer.state}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.freshGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    '🌱 Direct Farmer',
                    style: TextStyle(
                      color: AppColors.freshGreen,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Mini map
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(AppTheme.cardRadius)),
            child: SizedBox(
              height: 140,
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(farmer.lat, farmer.lng),
                  initialZoom: 10,
                  interactionOptions: const InteractionOptions(
                    flags: InteractiveFlag.none,
                  ),
                ),
                children: [
                  TileLayer(
                    urlTemplate: AppConstants.osmTileUrl,
                    userAgentPackageName:
                        'com.reliancesmart.reliance_smart_bazaar',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: LatLng(farmer.lat, farmer.lng),
                        child: const Icon(
                          Icons.agriculture,
                          color: AppColors.freshGreen,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
