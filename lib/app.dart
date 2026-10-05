// ============================================================
// app.dart – root widget wiring providers + theme + l10n.
// ============================================================
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/app_theme.dart';
import 'l10n/app_localizations.dart';
import 'providers/language_provider.dart';
import 'router.dart';

class RelianceSmartApp extends StatefulWidget {
  const RelianceSmartApp({super.key});

  @override
  State<RelianceSmartApp> createState() => _RelianceSmartAppState();
}

class _RelianceSmartAppState extends State<RelianceSmartApp> {
  late final _router = buildRouter(context);

  @override
  Widget build(BuildContext context) {
    // Watch LanguageProvider to rebuild when locale changes.
    final languageProvider = context.watch<LanguageProvider>();

    return MaterialApp.router(
      title: 'Reliance Smart Bazaar',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: _router,
      locale: languageProvider.locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
    );
  }
}
