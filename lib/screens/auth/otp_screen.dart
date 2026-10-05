// ============================================================
// OtpScreen – 6 boxes, auto-focus, countdown, shake on wrong OTP.
// Demo OTP: 123456
// ============================================================
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/app_colors.dart';
import '../../core/app_constants.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/auth_provider.dart';
import '../../providers/store_provider.dart';
import '../../services/storage_service.dart';

class OtpScreen extends StatefulWidget {
  final String phone;
  const OtpScreen({super.key, required this.phone});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen>
    with SingleTickerProviderStateMixin {
  final _focusNodes = List.generate(6, (_) => FocusNode());
  final _controllers = List.generate(6, (_) => TextEditingController());
  late AnimationController _shakeCtrl;
  late Animation<double> _shakeAnim;
  Timer? _resendTimer;
  int _secondsLeft = AppConstants.otpResendSeconds;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _shakeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _shakeAnim = Tween<double>(begin: 0, end: 12).animate(
      CurvedAnimation(parent: _shakeCtrl, curve: Curves.elasticIn),
    );
    _startResendTimer();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _focusNodes[0].requestFocus(),
    );
  }

  void _startResendTimer() {
    _secondsLeft = AppConstants.otpResendSeconds;
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      setState(() {
        if (_secondsLeft > 0) {
          _secondsLeft--;
        } else {
          t.cancel();
        }
      });
    });
  }

  String get _enteredOtp =>
      _controllers.map((c) => c.text).join();

  Future<void> _verify() async {
    final otp = _enteredOtp;
    if (otp.length < 6) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });
    await Future.delayed(const Duration(milliseconds: 800));

    if (!mounted) return;

    if (otp == AppConstants.demoOtp) {
      // Success -> Proceed to detailed Profile & Delivery Address Setup
      final storage = context.read<StorageService>();
      final existingName = storage.userName;
      if (existingName != null &&
          existingName.isNotEmpty &&
          existingName != 'Customer' &&
          existingName != 'Guest') {
        final auth = context.read<AuthProvider>();
        await auth.loginWithPhone(
          phone: widget.phone,
          name: existingName,
        );
        if (!mounted) return;
        final store = context.read<StoreProvider>();
        if (store.selectedStore == null) {
          context.go('/store-locator');
        } else {
          context.go('/home');
        }
      } else {
        context.go('/profile-setup', extra: widget.phone);
      }
    } else {
      // Wrong OTP
      _shakeCtrl.forward(from: 0);
      setState(() {
        _error = 'Invalid OTP. Please try again.';
        _isLoading = false;
      });
      // Clear boxes
      for (final c in _controllers) c.clear();
      _focusNodes[0].requestFocus();
    }
  }

  void _onDigitChanged(int index, String val) {
    if (val.length > 1) {
      // Handle paste
      final digits = val.replaceAll(RegExp(r'\D'), '');
      for (int i = 0; i < 6 && i < digits.length; i++) {
        _controllers[i].text = digits[i];
      }
      _focusNodes[5].requestFocus();
      if (digits.length == 6) _verify();
      return;
    }
    if (val.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
    if (_enteredOtp.length == 6) _verify();
  }

  void _onKeyEvent(int index, KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _controllers[index].text.isEmpty &&
        index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  void dispose() {
    _shakeCtrl.dispose();
    _resendTimer?.cancel();
    for (final f in _focusNodes) f.dispose();
    for (final c in _controllers) c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.otpTitle),
        leading: BackButton(onPressed: () => context.pop()),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Text(
                l10n.otpSubtitle,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 4),
              Text(
                '+91 ${widget.phone}',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 32),

              // Demo hint banner
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.offerOrange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: AppColors.offerOrange.withOpacity(0.4)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline,
                        color: AppColors.offerOrange, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      l10n.demoOtpHint,
                      style: const TextStyle(
                        color: AppColors.offerOrange,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 6 OTP boxes
              AnimatedBuilder(
                animation: _shakeAnim,
                builder: (_, child) => Transform.translate(
                  offset: Offset(_shakeCtrl.isAnimating
                      ? _shakeAnim.value *
                          (_shakeCtrl.value < 0.5 ? 1 : -1)
                      : 0,
                      0),
                  child: child,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    6,
                    (i) => KeyboardListener(
                      focusNode: FocusNode(),
                      onKeyEvent: (e) => _onKeyEvent(i, e),
                      child: SizedBox(
                        width: 44,
                        height: 52,
                        child: TextFormField(
                          controller: _controllers[i],
                          focusNode: _focusNodes[i],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: i == 0 ? 6 : 1,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                          decoration: InputDecoration(
                            counterText: '',
                            contentPadding: EdgeInsets.zero,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: _error != null
                                    ? AppColors.error
                                    : AppColors.border,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: AppColors.primary, width: 2),
                            ),
                          ),
                          onChanged: (val) => _onDigitChanged(i, val),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              if (_error != null) ...[
                const SizedBox(height: 12),
                Text(
                  _error!,
                  style: const TextStyle(
                    color: AppColors.error,
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 32),

              ElevatedButton(
                onPressed: _isLoading || _enteredOtp.length < 6
                    ? null
                    : _verify,
                child: _isLoading
                    ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      )
                    : Text(l10n.verify),
              ),
              const SizedBox(height: 20),

              Center(
                child: _secondsLeft > 0
                    ? Text(
                        l10n.resendIn(_secondsLeft),
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    : TextButton(
                        onPressed: _startResendTimer,
                        child: Text(l10n.resendOtp),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
