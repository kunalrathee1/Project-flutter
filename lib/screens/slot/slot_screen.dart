// ============================================================
// SlotScreen – 7-day strip + slot chips with availability.
// ============================================================
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/app_colors.dart';
import '../../core/app_formatters.dart';
import '../../l10n/app_localizations.dart';
import '../../models/models.dart';
import '../../providers/cart_provider.dart';
import '../../services/slot_service.dart';

class SlotScreen extends StatefulWidget {
  const SlotScreen({super.key});

  @override
  State<SlotScreen> createState() => _SlotScreenState();
}

class _SlotScreenState extends State<SlotScreen> {
  late List<DateTime> _dates;
  DateTime? _selectedDate;
  DeliverySlot? _selectedSlot;
  late SlotService _slotService;

  @override
  void initState() {
    super.initState();
    _slotService = context.read<SlotService>();
    _dates = _slotService.next7Days();
    _selectedDate = _dates.first;
  }

  List<DeliverySlot> get _slots =>
      _selectedDate != null ? _slotService.slotsForDate(_selectedDate!) : [];

  void _confirmSlot() {
    if (_selectedSlot == null) return;
    context.read<CartProvider>().setSlot(_selectedSlot!);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Delivery slot confirmed!')),
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final now = DateTime.now();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.deliverySlot)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 7-day date strip
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(l10n.selectDate,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.w600)),
          ),
          SizedBox(
            height: 76,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: _dates.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (ctx, i) {
                final date = _dates[i];
                final isSelected = _selectedDate?.day == date.day &&
                    _selectedDate?.month == date.month;
                final isToday = date.day == now.day &&
                    date.month == now.month;
                return GestureDetector(
                  onTap: () => setState(() {
                    _selectedDate = date;
                    _selectedSlot = null;
                  }),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 60,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.border,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppFormatters.dayName(date),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: isSelected
                                ? Colors.white70
                                : AppColors.textHint,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${date.day}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: isSelected
                                ? Colors.white
                                : AppColors.textPrimary,
                          ),
                        ),
                        if (isToday)
                          Text(
                            l10n.todayLabel,
                            style: TextStyle(
                              fontSize: 9,
                              color: isSelected
                                  ? Colors.white70
                                  : AppColors.primary,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Time slots
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(l10n.selectTime,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.w600)),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.6,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: _slots.length,
              itemBuilder: (ctx, i) {
                final slot = _slots[i];
                final disabled =
                    _slotService.isSlotDisabled(slot, now);
                final isSelected = _selectedSlot?.startHour ==
                        slot.startHour &&
                    _selectedSlot?.date.day == slot.date.day;

                Color bg;
                Color textCol;
                String? tag;

                if (disabled) {
                  bg = AppColors.surfaceVariant;
                  textCol = AppColors.textHint;
                  tag = slot.isFull ? l10n.slotFull : null;
                } else if (isSelected) {
                  bg = AppColors.primary;
                  textCol = Colors.white;
                } else if (slot.isFreeDelivery) {
                  bg = AppColors.earlyBirdSlot.withOpacity(0.1);
                  textCol = AppColors.earlyBirdSlot;
                } else if (slot.fewLeft) {
                  bg = AppColors.offerOrange.withOpacity(0.1);
                  textCol = AppColors.offerOrange;
                } else {
                  bg = AppColors.surface;
                  textCol = AppColors.textPrimary;
                }

                return GestureDetector(
                  onTap: disabled
                      ? null
                      : () => setState(() => _selectedSlot = slot),
                  child: Container(
                    decoration: BoxDecoration(
                      color: bg,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : disabled
                                ? AppColors.divider
                                : AppColors.border,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppFormatters.slotTime(slot.startHour)
                                    .split('–')
                                    .first
                                    .trim(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: textCol,
                                ),
                              ),
                              if (slot.fewLeft && !disabled)
                                Text(
                                  l10n.slotsLeft(slot.available),
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: textCol,
                                  ),
                                )
                              else if (tag != null)
                                Text(
                                  tag,
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: textCol,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        if (slot.isFreeDelivery && !disabled)
                          Positioned(
                            top: 4,
                            right: 4,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 1),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.white
                                    : AppColors.earlyBirdSlot,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'FREE',
                                style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w700,
                                  color: isSelected
                                      ? AppColors.earlyBirdSlot
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Selected slot summary + confirm
          if (_selectedSlot != null)
            Container(
              color: AppColors.surface,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.schedule,
                          size: 16, color: AppColors.primary),
                      const SizedBox(width: 8),
                      Text(
                        '${AppFormatters.fullDate(_selectedSlot!.date)} · '
                        '${AppFormatters.slotTime(_selectedSlot!.startHour)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  if (_selectedSlot!.isFreeDelivery) ...[
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.local_shipping,
                            size: 14, color: AppColors.freshGreen),
                        const SizedBox(width: 6),
                        Text(
                          '${l10n.earlyBird}: ${l10n.freeDelivery}',
                          style: const TextStyle(
                            color: AppColors.freshGreen,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: _selectedSlot != null ? _confirmSlot : null,
            child: Text(l10n.confirmSlot),
          ),
        ),
      ),
    );
  }
}
