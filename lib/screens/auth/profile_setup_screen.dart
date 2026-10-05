// ============================================================
// ProfileSetupScreen – collects user name, email, delivery address
//                      and preferences after OTP verification.
// ============================================================
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/app_colors.dart';
import '../../models/models.dart';
import '../../providers/auth_provider.dart';
import '../../providers/profile_provider.dart';
import '../../providers/store_provider.dart';

class ProfileSetupScreen extends StatefulWidget {
  final String phone;
  const ProfileSetupScreen({super.key, required this.phone});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _flatCtrl = TextEditingController();
  final _streetCtrl = TextEditingController();
  final _landmarkCtrl = TextEditingController();
  final _areaCtrl = TextEditingController(text: 'Kharghar');
  final _cityCtrl = TextEditingController(text: 'Navi Mumbai');
  final _pincodeCtrl = TextEditingController(text: '410210');

  String _addressLabel = 'Home';
  bool _joinJioPrime = true;
  bool _isSaving = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _flatCtrl.dispose();
    _streetCtrl.dispose();
    _landmarkCtrl.dispose();
    _areaCtrl.dispose();
    _cityCtrl.dispose();
    _pincodeCtrl.dispose();
    super.dispose();
  }

  void _fillDefaultKharghar() {
    setState(() {
      _flatCtrl.text = 'Flat 402, Sai Heritage';
      _streetCtrl.text = 'Sector 35, Near Metro Station';
      _landmarkCtrl.text = 'Near Central Park';
      _areaCtrl.text = 'Kharghar';
      _cityCtrl.text = 'Navi Mumbai';
      _pincodeCtrl.text = '410210';
      if (_nameCtrl.text.isEmpty) {
        _nameCtrl.text = 'Kunal Sharma';
      }
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);
    await Future.delayed(const Duration(milliseconds: 600));

    if (!mounted) return;

    final name = _nameCtrl.text.trim();
    final auth = context.read<AuthProvider>();
    final profile = context.read<ProfileProvider>();
    final storeProvider = context.read<StoreProvider>();

    // 1. Update Auth user name & phone
    await auth.loginWithPhone(
      phone: widget.phone,
      name: name,
    );

    // 2. Create and save new delivery address
    final newAddress = Address(
      id: 'addr_${DateTime.now().millisecondsSinceEpoch}',
      label: _addressLabel,
      name: name,
      phone: widget.phone,
      flat: _flatCtrl.text.trim(),
      street: _streetCtrl.text.trim(),
      area: _areaCtrl.text.trim(),
      city: _cityCtrl.text.trim(),
      state: 'Maharashtra',
      pincode: _pincodeCtrl.text.trim(),
      isDefault: true,
    );

    await profile.addAddress(newAddress);
    await profile.setDefaultAddress(newAddress.id);

    // 3. Set JioPrime preference
    if (_joinJioPrime) {
      await profile.setJioPrime(true);
    }

    if (!mounted) return;

    setState(() => _isSaving = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Welcome, $name! Your address has been set up.'),
        backgroundColor: AppColors.freshGreen,
        behavior: SnackBarBehavior.floating,
      ),
    );

    // If store not selected, go to store locator; else home
    if (storeProvider.selectedStore == null) {
      context.go('/store-locator');
    } else {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Complete Your Profile'),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top Welcome Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.primary, AppColors.primaryDark],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.25),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.person_pin, color: Colors.white, size: 28),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Almost there!',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 3),
                            const Text(
                              'Please provide your name and delivery address to start ordering groceries.',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: AppColors.freshGreen,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.check_circle, color: Colors.white, size: 12),
                                      const SizedBox(width: 4),
                                      Text(
                                        '+91 ${widget.phone} Verified',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Card 1: Personal Details
                _SectionCard(
                  title: 'Personal Details',
                  icon: Icons.person_outline,
                  children: [
                    TextFormField(
                      controller: _nameCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Full Name *',
                        hintText: 'e.g. Kunal Sharma',
                        prefixIcon: Icon(Icons.person, size: 20),
                      ),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _emailCtrl,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email Address (Optional)',
                        hintText: 'For invoices and order updates',
                        prefixIcon: Icon(Icons.email_outlined, size: 20),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                // Card 2: Delivery Address
                _SectionCard(
                  title: 'Delivery Address',
                  icon: Icons.location_on_outlined,
                  action: TextButton.icon(
                    onPressed: _fillDefaultKharghar,
                    icon: const Icon(Icons.auto_fix_high, size: 14),
                    label: const Text('Auto-fill Demo', style: TextStyle(fontSize: 11)),
                    style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
                  ),
                  children: [
                    // Address Tag selection (Home, Work, Other)
                    Row(
                      children: [
                        const Text(
                          'Save As: ',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        ...['Home', 'Work', 'Other'].map((tag) {
                          final isSelected = _addressLabel == tag;
                          return Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: ChoiceChip(
                              label: Text(tag),
                              selected: isSelected,
                              onSelected: (_) => setState(() => _addressLabel = tag),
                              selectedColor: AppColors.primary,
                              labelStyle: TextStyle(
                                color: isSelected ? Colors.white : AppColors.textPrimary,
                                fontSize: 11,
                                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                              ),
                              visualDensity: VisualDensity.compact,
                            ),
                          );
                        }),
                      ],
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _flatCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Flat / House / Floor / Society *',
                        hintText: 'e.g. Flat 402, Sai Heritage Building A',
                        prefixIcon: Icon(Icons.home_outlined, size: 20),
                      ),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return 'Please enter house/flat details';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _streetCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Street / Locality / Sector *',
                        hintText: 'e.g. Sector 35, Near Metro Station',
                        prefixIcon: Icon(Icons.signpost_outlined, size: 20),
                      ),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return 'Please enter street / sector details';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _landmarkCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Landmark (Optional)',
                        hintText: 'e.g. Near Central Park',
                        prefixIcon: Icon(Icons.flag_outlined, size: 20),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _areaCtrl,
                            decoration: const InputDecoration(
                              labelText: 'Area / Node *',
                              prefixIcon: Icon(Icons.map_outlined, size: 20),
                            ),
                            validator: (v) => v!.isEmpty ? 'Required' : null,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: _cityCtrl,
                            decoration: const InputDecoration(
                              labelText: 'City *',
                              prefixIcon: Icon(Icons.location_city, size: 20),
                            ),
                            validator: (v) => v!.isEmpty ? 'Required' : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _pincodeCtrl,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6),
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Pincode *',
                        hintText: '6-digit pincode',
                        prefixIcon: Icon(Icons.pin_drop_outlined, size: 20),
                      ),
                      validator: (v) =>
                          v == null || v.length < 6 ? 'Enter 6-digit pincode' : null,
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                // Card 3: JioPrime Membership Welcome Promo
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF8E1),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFC9A227).withValues(alpha: 0.4)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFC9A227).withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.star, color: Color(0xFF8D6E18), size: 20),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Join JioPrime (Free Demo Trial)',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                                color: Color(0xFF5D4037),
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Get 5% EXTRA discount on all items and priority delivery slot access.',
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFF795548),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: _joinJioPrime,
                        activeColor: const Color(0xFF8D6E18),
                        onChanged: (val) => setState(() => _joinJioPrime = val),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // Submit Button
                ElevatedButton.icon(
                  onPressed: _isSaving ? null : _submit,
                  icon: _isSaving
                      ? const SizedBox.shrink()
                      : const Icon(Icons.arrow_forward, size: 18),
                  label: _isSaving
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                      : const Text(
                          'Save & Start Shopping',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? action;
  final List<Widget> children;

  const _SectionCard({
    required this.title,
    required this.icon,
    this.action,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: AppColors.primary, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              if (action != null) action!,
            ],
          ),
          const SizedBox(height: 14),
          ...children,
        ],
      ),
    );
  }
}
