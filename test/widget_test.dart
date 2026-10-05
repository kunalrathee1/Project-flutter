// ============================================================
// Basic Widget Smoke Tests
// ============================================================
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reliance_smart_bazaar/core/app_colors.dart';
import 'package:reliance_smart_bazaar/core/app_formatters.dart';

void main() {
  testWidgets('Formatters smoke test', (WidgetTester tester) async {
    expect(AppFormatters.currency(150), contains('150'));
    expect(AppFormatters.weight(2.5), '2.5 kg');
    expect(AppFormatters.weight(2.0), '2 kg');
    expect(AppFormatters.slotTime(6), contains('6:00 AM'));
  });

  testWidgets('App colors and badge rendering test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text(
              'Reliance Smart Bazaar',
              style: TextStyle(color: AppColors.primary),
            ),
          ),
        ),
      ),
    );

    expect(find.text('Reliance Smart Bazaar'), findsOneWidget);
  });
}
