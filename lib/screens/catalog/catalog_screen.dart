// ============================================================
// CatalogScreen – product list with filter chips + sort.
// ============================================================
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/app_colors.dart';
import '../../data/mock_products.dart';
import '../../l10n/app_localizations.dart';
import '../../models/models.dart';
import '../../providers/language_provider.dart';
import '../../providers/store_provider.dart';
import '../../widgets/widgets.dart';

enum SortOption { priceLowHigh, priceHighLow, freshness }

class CatalogScreen extends StatefulWidget {
  final String? initialCategory;
  const CatalogScreen({super.key, this.initialCategory});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  String _filterType = 'all'; // all, loose, packed, organic, under100
  SortOption _sort = SortOption.priceLowHigh;
  ProductCategory? _selectedCategory;

  static const _categoryFilters = [
    {'label': 'All', 'cat': null},
    {'label': '🍎 Fruits', 'cat': 'fruits'},
    {'label': '🥦 Vegetables', 'cat': 'vegetables'},
    {'label': '🥛 Dairy', 'cat': 'dairy'},
    {'label': '🌾 Staples', 'cat': 'staples'},
    {'label': '🍿 Snacks', 'cat': 'snacks'},
    {'label': '🥤 Beverages', 'cat': 'beverages'},
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialCategory != null) {
      _selectedCategory = ProductCategory.values.firstWhere(
        (c) => c.name == widget.initialCategory,
        orElse: () => ProductCategory.fruits,
      );
    }
  }

  List<Product> _getFilteredProducts(String storeId) {
    var products = _selectedCategory != null
        ? productsByCategory(_selectedCategory!)
        : mockProducts;

    // Type filter
    switch (_filterType) {
      case 'loose':
        products =
            products.where((p) => p.looseVariants.isNotEmpty).toList();
        break;
      case 'packed':
        products =
            products.where((p) => p.packedVariants.isNotEmpty).toList();
        break;
      case 'organic':
        products = products
            .where((p) => p.variants.any((v) => v.isOrganic))
            .toList();
        break;
      case 'under100':
        products = products
            .where((p) => p.defaultVariant.pricePerUnit < 100)
            .toList();
        break;
    }

    // Sort
    switch (_sort) {
      case SortOption.priceLowHigh:
        products.sort((a, b) => a.defaultVariant.pricePerUnit
            .compareTo(b.defaultVariant.pricePerUnit));
        break;
      case SortOption.priceHighLow:
        products.sort((a, b) => b.defaultVariant.pricePerUnit
            .compareTo(a.defaultVariant.pricePerUnit));
        break;
      case SortOption.freshness:
        products.sort(
            (a, b) => b.hasFreshnessGuarantee ? 1 : -1);
        break;
    }

    return products;
  }

  void _showSortSheet(BuildContext context, AppLocalizations l10n) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.sortBy,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 16),
            ...SortOption.values.map(
              (s) => RadioListTile<SortOption>(
                value: s,
                groupValue: _sort,
                title: Text(_sortLabel(s, l10n)),
                activeColor: AppColors.primary,
                onChanged: (v) {
                  setState(() => _sort = v!);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _sortLabel(SortOption s, AppLocalizations l10n) {
    switch (s) {
      case SortOption.priceLowHigh:
        return l10n.priceLowHigh;
      case SortOption.priceHighLow:
        return l10n.priceHighLow;
      case SortOption.freshness:
        return l10n.freshness;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = context.watch<LanguageProvider>().languageCode;
    final storeId =
        context.watch<StoreProvider>().selectedStore?.id ?? '';
    final products = _getFilteredProducts(storeId);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.categories),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () => _showSortSheet(context, l10n),
            tooltip: l10n.sortBy,
          ),
        ],
      ),
      body: Column(
        children: [
          // Category horizontal chips
          SizedBox(
            height: 48,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: _categoryFilters.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (ctx, i) {
                final item = _categoryFilters[i];
                final cat = item['cat'];
                ProductCategory? catEnum;
                if (cat != null) {
                  catEnum = ProductCategory.values.firstWhere(
                    (c) => c.name == cat,
                    orElse: () => ProductCategory.fruits,
                  );
                }
                final isSelected = _selectedCategory == catEnum;
                return FilterChip(
                  label: Text(item['label'] as String),
                  selected: isSelected,
                  onSelected: (_) =>
                      setState(() => _selectedCategory = catEnum),
                  selectedColor: AppColors.primary.withOpacity(0.15),
                  checkmarkColor: AppColors.primary,
                  labelStyle: TextStyle(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textPrimary,
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.w400,
                  ),
                );
              },
            ),
          ),

          // Type filter chips
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                _filterChip('all', l10n.filter.replaceAll('Filter', 'All')),
                _filterChip('loose', l10n.loose),
                _filterChip('packed', l10n.packed),
                _filterChip('organic', l10n.organic),
                _filterChip('under100', l10n.underRs100),
              ],
            ),
          ),

          // Product grid
          Expanded(
            child: products.isEmpty
                ? EmptyState(
                    icon: Icons.search_off,
                    title: l10n.noResults,
                    subtitle: 'Try different filters',
                    actionLabel: 'Clear Filters',
                    onAction: () => setState(() {
                      _filterType = 'all';
                      _selectedCategory = null;
                    }),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.68,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: products.length,
                    itemBuilder: (ctx, i) => ProductCard(
                      product: products[i],
                      locale: locale,
                      storeId: storeId,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _filterChip(String value, String label) {
    final isSelected = _filterType == value;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => setState(() => _filterType = value),
        selectedColor: AppColors.primary.withOpacity(0.15),
        checkmarkColor: AppColors.primary,
        labelStyle: TextStyle(
          color: isSelected ? AppColors.primary : AppColors.textPrimary,
          fontSize: 12,
        ),
      ),
    );
  }
}
