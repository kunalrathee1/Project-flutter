// ============================================================
// StoreLocatorScreen – location, search, map + list.
// ============================================================
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../../core/app_colors.dart';
import '../../core/app_constants.dart';
import '../../core/app_formatters.dart';
import '../../core/app_theme.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/store_provider.dart';
import '../../widgets/widgets.dart';

class StoreLocatorScreen extends StatefulWidget {
  const StoreLocatorScreen({super.key});

  @override
  State<StoreLocatorScreen> createState() => _StoreLocatorScreenState();
}

class _StoreLocatorScreenState extends State<StoreLocatorScreen> {
  final _searchCtrl = TextEditingController();
  String _query = '';
  String? _highlightedStoreId;
  final MapController _mapCtrl = MapController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StoreProvider>().loadLocation();
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final storeProvider = context.watch<StoreProvider>();
    final filteredStores = storeProvider.searchStores(_query);
    final now = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.storeLocator),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // Location denied banner
          if (storeProvider.usingDefaultLocation &&
              storeProvider.loadState == StoreLoadState.done)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: AppColors.offerOrange.withOpacity(0.12),
              child: Row(
                children: [
                  const Icon(Icons.location_off,
                      size: 16, color: AppColors.offerOrange),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      l10n.usingDefaultLocation,
                      style: const TextStyle(
                        color: AppColors.offerOrange,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Search bar
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchCtrl,
              decoration: InputDecoration(
                hintText: l10n.searchStores,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchCtrl.clear();
                          setState(() => _query = '');
                        },
                      )
                    : null,
              ),
              onChanged: (v) => setState(() => _query = v),
            ),
          ),

          // Map
          SizedBox(
            height: 200,
            child: FlutterMap(
              mapController: _mapCtrl,
              options: MapOptions(
                initialCenter: LatLng(
                  storeProvider.userLat,
                  storeProvider.userLng,
                ),
                initialZoom: 12.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: AppConstants.osmTileUrl,
                  userAgentPackageName:
                      'com.reliancesmart.reliance_smart_bazaar',
                ),
                MarkerLayer(
                  markers: [
                    // User location
                    Marker(
                      point: LatLng(
                        storeProvider.userLat,
                        storeProvider.userLng,
                      ),
                      child: const Icon(
                        Icons.my_location,
                        color: Colors.blue,
                        size: 24,
                      ),
                    ),
                    // Store pins
                    ...filteredStores.map(
                      (s) => Marker(
                        point: LatLng(s.lat, s.lng),
                        child: GestureDetector(
                          onTap: () {
                            setState(
                                () => _highlightedStoreId = s.id);
                            _mapCtrl.move(
                                LatLng(s.lat, s.lng), 14);
                          },
                          child: Icon(
                            Icons.store,
                            color: _highlightedStoreId == s.id
                                ? AppColors.primary
                                : Colors.red,
                            size: _highlightedStoreId == s.id
                                ? 36
                                : 28,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Store list
          Expanded(
            child: storeProvider.loadState == StoreLoadState.loading
                ? const Center(child: CircularProgressIndicator())
                : filteredStores.isEmpty
                    ? EmptyState(
                        icon: Icons.store_mall_directory_outlined,
                        title: l10n.noStoresFound,
                        subtitle: 'Try a different search term',
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        itemCount: filteredStores.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: 8),
                        itemBuilder: (ctx, i) {
                          final store = filteredStores[i];
                          final distance =
                              storeProvider.distanceToStore(store);
                          final isHighlighted =
                              _highlightedStoreId == store.id;
                          final isOpen = store.isOpen(now);

                          return GestureDetector(
                            onTap: () => context.push(
                              '/store-detail',
                              extra: store.id,
                            ),
                            child: AnimatedContainer(
                              duration:
                                  const Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                borderRadius: BorderRadius.circular(
                                    AppTheme.cardRadius),
                                border: Border.all(
                                  color: isHighlighted
                                      ? AppColors.primary
                                      : AppColors.divider,
                                  width: isHighlighted ? 2 : 1,
                                ),
                                boxShadow: [AppTheme.lightShadow],
                              ),
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  // Store icon
                                  Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary
                                          .withOpacity(0.1),
                                      borderRadius:
                                          BorderRadius.circular(12),
                                    ),
                                    child: const Icon(
                                      Icons.store,
                                      color: AppColors.primary,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          store.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          store.address,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                          maxLines: 1,
                                          overflow:
                                              TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 6),
                                        Row(
                                          children: [
                                            StoreOpenBadge(
                                                isOpen: isOpen),
                                            const SizedBox(width: 8),
                                            // Inventory chip
                                            _InventoryChip(
                                                level: store
                                                    .overallInventory),
                                            const SizedBox(width: 8),
                                            Text(
                                              AppFormatters.distance(
                                                  distance),
                                              style: const TextStyle(
                                                fontSize: 11,
                                                color:
                                                    AppColors.textHint,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Select button
                                  TextButton(
                                    onPressed: () async {
                                      await context
                                          .read<StoreProvider>()
                                          .selectStore(store);
                                      if (!ctx.mounted) return;
                                      context.go('/home');
                                    },
                                    child: const Text('Select'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

class _InventoryChip extends StatelessWidget {
  final double level;
  const _InventoryChip({required this.level});

  @override
  Widget build(BuildContext context) {
    final color = level >= 0.85
        ? AppColors.freshGreen
        : level >= 0.5
            ? AppColors.offerOrange
            : AppColors.error;
    final label =
        level >= 0.85 ? 'High Stock' : level >= 0.5 ? 'Medium' : 'Low';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
