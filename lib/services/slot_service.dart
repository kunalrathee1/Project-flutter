// ============================================================
// SlotService – deterministic mock slot availability.
// Capacity is seeded by (date day-of-year + hour) so it's
// reproducible but varies across slots.
// ============================================================
import '../models/models.dart';

class SlotService {
  static const int _maxCapacity = 15;

  /// Generate all slots for a given date.
  List<DeliverySlot> slotsForDate(DateTime date) {
    final slots = <DeliverySlot>[];
    for (int hour = 6; hour < 22; hour++) {
      final seed = date.day * 31 + date.month * 7 + hour * 3;
      final booked = seed % (_maxCapacity + 1); // 0-15
      slots.add(DeliverySlot(
        startHour: hour,
        date: date,
        capacity: _maxCapacity,
        booked: booked,
      ));
    }
    return slots;
  }

  /// Generate 7-day window starting today.
  List<DateTime> next7Days() {
    final today = DateTime.now();
    return List.generate(
      7,
      (i) => DateTime(today.year, today.month, today.day + i),
    );
  }

  /// Check if a slot is pastable (disabled).
  bool isSlotDisabled(DeliverySlot slot, DateTime now) {
    return slot.isFull || slot.isPast(now);
  }
}
