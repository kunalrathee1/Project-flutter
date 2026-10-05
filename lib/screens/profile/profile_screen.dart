// ============================================================
// ProfileScreen – User profile, JioPrime membership banner,
// address manager, GST details, notification prefs, FAQs & logout.
// ============================================================
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/app_colors.dart';
import '../../core/app_formatters.dart';
import '../../l10n/app_localizations.dart';
import '../../models/models.dart';
import '../../providers/auth_provider.dart';
import '../../providers/language_provider.dart';
import '../../providers/profile_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final auth = context.watch<AuthProvider>();
    final profile = context.watch<ProfileProvider>();
    final lang = context.watch<LanguageProvider>();
    final user = auth.user;

    final displayName = user != null && user.name.isNotEmpty
        ? user.name
        : (user?.isGuest == true ? 'Guest User' : 'Valued Customer');
    final displayPhone = user != null && user.phone.isNotEmpty
        ? AppFormatters.phone(user.phone)
        : 'Not linked';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          l10n.myProfile,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // User Card
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: AppColors.primary,
                    child: Text(
                      displayName.isNotEmpty ? displayName[0].toUpperCase() : 'U',
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          displayName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.phone, size: 14, color: AppColors.textSecondary),
                            const SizedBox(width: 4),
                            Text(
                              displayPhone,
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, color: AppColors.primary),
                    tooltip: l10n.editProfile,
                    onPressed: () => _showEditProfileDialog(context, auth, displayName),
                  ),
                ],
              ),
            ),

            // JioPrime Membership Banner
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2A2D34), Color(0xFF1E1F24)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFD700).withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.workspace_premium, color: Color(0xFFFFD700), size: 28),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'JioPrime',
                              style: TextStyle(
                                color: Color(0xFFFFD700),
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: profile.jioPrime ? AppColors.freshGreen : Colors.grey[700],
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                profile.jioPrime ? 'ACTIVE' : 'INACTIVE',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        const Text(
                          'Get 5% extra discount on every grocery order!',
                          style: TextStyle(color: Colors.white70, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: profile.jioPrime,
                    activeColor: const Color(0xFFFFD700),
                    onChanged: (val) {
                      profile.setJioPrime(val);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            val
                                ? 'JioPrime Activated! 5% discount applied.'
                                : 'JioPrime Deactivated.',
                          ),
                          duration: const Duration(seconds: 2),
                          backgroundColor: val ? AppColors.freshGreen : AppColors.textSecondary,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Settings Section
            _SettingsGroup(
              title: 'Account Settings',
              children: [
                _SettingsTile(
                  icon: Icons.location_on_outlined,
                  title: l10n.savedAddresses,
                  subtitle: profile.defaultAddress.streetLocality.isNotEmpty
                      ? '${profile.defaultAddress.flatDoor}, ${profile.defaultAddress.streetLocality}'
                      : 'Kharghar, Navi Mumbai - 410210',
                  onTap: () => _showAddressesSheet(context, profile),
                ),
                _SettingsTile(
                  icon: Icons.business_outlined,
                  title: l10n.businessGstDetails,
                  subtitle: profile.gstDetails != null
                      ? '${profile.gstDetails!.businessName} (${profile.gstDetails!.gstin})'
                      : 'Add GSTIN for tax invoices',
                  onTap: () => _showGstDetailsSheet(context, profile),
                ),
                _SettingsTile(
                  icon: Icons.translate,
                  title: l10n.language,
                  subtitle: _languageName(lang.locale.languageCode),
                  onTap: () => context.push('/language'),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Notifications Group
            _SettingsGroup(
              title: l10n.notifications,
              children: [
                _SwitchTile(
                  icon: Icons.local_offer_outlined,
                  title: l10n.offers,
                  subtitle: 'Daily deals, festive discounts & cashback',
                  value: profile.notifOffers,
                  onChanged: (v) => profile.setNotifOffers(v),
                ),
                _SwitchTile(
                  icon: Icons.shopping_bag_outlined,
                  title: l10n.orderUpdates,
                  subtitle: 'Real-time packing and dispatch alerts',
                  value: profile.notifOrders,
                  onChanged: (v) => profile.setNotifOrders(v),
                ),
                _SwitchTile(
                  icon: Icons.delivery_dining_outlined,
                  title: l10n.deliveryAlerts,
                  subtitle: 'Rider arrival & delivery confirmation',
                  value: profile.notifDelivery,
                  onChanged: (v) => profile.setNotifDelivery(v),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Support & FAQs
            _SettingsGroup(
              title: l10n.helpSupport,
              children: [
                _SettingsTile(
                  icon: Icons.help_outline,
                  title: l10n.faq,
                  subtitle: 'Slots, refund policy, JioPrime details',
                  onTap: () => _showFaqSheet(context),
                ),
                _SettingsTile(
                  icon: Icons.headset_mic_outlined,
                  title: 'Contact Customer Support',
                  subtitle: 'Toll-free 1800-891-0001 • 7 AM to 10 PM',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Calling customer care: 1800-891-0001'),
                        backgroundColor: AppColors.primary,
                      ),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Logout Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: OutlinedButton.icon(
                onPressed: () => _showLogoutDialog(context, auth),
                icon: const Icon(Icons.logout, color: AppColors.error),
                label: Text(
                  l10n.logout,
                  style: const TextStyle(
                    color: AppColors.error,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.error),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ),

            const SizedBox(height: 20),
            Text(
              l10n.version('1.0.0 (Build 20260930)'),
              style: const TextStyle(fontSize: 12, color: AppColors.textHint),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  String _languageName(String code) {
    switch (code) {
      case 'hi':
        return 'हिन्दी (Hindi)';
      case 'mr':
        return 'मराठी (Marathi)';
      case 'gu':
        return 'ગુજરાતી (Gujarati)';
      default:
        return 'English';
    }
  }

  void _showEditProfileDialog(
      BuildContext context, AuthProvider auth, String currentName) {
    final controller = TextEditingController(text: currentName);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit Profile'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Full Name',
            hintText: 'Enter your name',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final newName = controller.text.trim();
              if (newName.isNotEmpty) {
                auth.updateProfile(name: newName);
              }
              Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showAddressesSheet(BuildContext context, ProfileProvider profile) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 16, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Saved Addresses',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: profile.addresses.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.location_off_outlined,
                              size: 40, color: AppColors.textHint),
                          const SizedBox(height: 12),
                          const Text('No saved addresses yet'),
                          const SizedBox(height: 12),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(ctx);
                              _showAddAddressDialog(context, profile);
                            },
                            icon: const Icon(Icons.add),
                            label: const Text('Add Address'),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: profile.addresses.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final addr = profile.addresses[index];
                        final isDefault = addr.isDefault;

                        return Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isDefault ? AppColors.primary : AppColors.divider,
                              width: isDefault ? 1.5 : 1,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                addr.label.toLowerCase() == 'work'
                                    ? Icons.business
                                    : Icons.home_outlined,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          addr.label.toUpperCase(),
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        if (isDefault) ...[
                                          const SizedBox(width: 8),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 6, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: AppColors.primary.withValues(alpha: 0.1),
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: const Text(
                                              'DEFAULT',
                                              style: TextStyle(
                                                fontSize: 9,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primary,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      addr.fullName,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      '${addr.flatDoor}, ${addr.streetLocality}, ${addr.city} - ${addr.pincode}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuButton<String>(
                                onSelected: (action) {
                                  if (action == 'default') {
                                    profile.setDefaultAddress(addr.id);
                                  } else if (action == 'delete') {
                                    profile.deleteAddress(addr.id);
                                  }
                                },
                                itemBuilder: (_) => [
                                  if (!isDefault)
                                    const PopupMenuItem(
                                      value: 'default',
                                      child: Text('Set as Default'),
                                    ),
                                  const PopupMenuItem(
                                    value: 'delete',
                                    child: Text('Delete', style: TextStyle(color: AppColors.error)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(ctx);
                  _showAddAddressDialog(context, profile);
                },
                icon: const Icon(Icons.add),
                label: const Text('Add New Address'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddAddressDialog(BuildContext context, ProfileProvider profile) {
    final nameCtrl = TextEditingController(text: 'Sahil Pandey');
    final flatCtrl = TextEditingController();
    final streetCtrl = TextEditingController();
    final localityCtrl = TextEditingController(text: 'Sector 19');
    final cityCtrl = TextEditingController(text: 'Navi Mumbai');
    final pinCtrl = TextEditingController(text: '410210');
    String selectedLabel = 'Home';

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Address'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'Full Name'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: flatCtrl,
                decoration: const InputDecoration(labelText: 'Flat / Door No.'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: streetCtrl,
                decoration: const InputDecoration(labelText: 'Street / Building'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: localityCtrl,
                decoration: const InputDecoration(labelText: 'Locality / Area'),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: cityCtrl,
                      decoration: const InputDecoration(labelText: 'City'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: pinCtrl,
                      decoration: const InputDecoration(labelText: 'Pincode'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (flatCtrl.text.isNotEmpty && streetCtrl.text.isNotEmpty) {
                profile.addAddress(
                  Address(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    label: selectedLabel,
                    name: nameCtrl.text.trim(),
                    phone: '9876543210',
                    flat: flatCtrl.text.trim(),
                    street: streetCtrl.text.trim(),
                    area: localityCtrl.text.trim(),
                    city: cityCtrl.text.trim(),
                    state: 'Maharashtra',
                    pincode: pinCtrl.text.trim(),
                    isDefault: profile.addresses.isEmpty,
                  ),
                );
              }
              Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showGstDetailsSheet(BuildContext context, ProfileProvider profile) {
    final currentGst = profile.gstDetails;
    final nameCtrl = TextEditingController(text: currentGst?.businessName ?? '');
    final gstinCtrl = TextEditingController(text: currentGst?.gstin ?? '');
    final addrCtrl = TextEditingController(text: currentGst?.businessAddress ?? '');
    final emailCtrl = TextEditingController(text: currentGst?.email ?? '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Business & GST Details',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const Divider(height: 16),
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'Business Name'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: gstinCtrl,
                decoration: const InputDecoration(
                  labelText: 'GSTIN (15 characters)',
                  hintText: '27AAAAA0000A1Z5',
                ),
                textCapitalization: TextCapitalization.characters,
                maxLength: 15,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: addrCtrl,
                decoration: const InputDecoration(labelText: 'Business Address'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: emailCtrl,
                decoration: const InputDecoration(labelText: 'Billing Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (nameCtrl.text.isNotEmpty && gstinCtrl.text.isNotEmpty) {
                    profile.setGstDetails(
                      GstDetails(
                        businessName: nameCtrl.text.trim(),
                        gstin: gstinCtrl.text.trim().toUpperCase(),
                        businessAddress: addrCtrl.text.trim(),
                        email: emailCtrl.text.trim(),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('GST details saved successfully!'),
                        backgroundColor: AppColors.freshGreen,
                      ),
                    );
                  }
                  Navigator.pop(ctx);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text('Save Details'),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  void _showFaqSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Frequently Asked Questions',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: const [
                  _FaqItem(
                    q: 'How does fresh produce ordering work?',
                    a: 'You can choose between Loose (sold per kg) and Packed options. For fruits like Alphonso Mangoes, you can also select your preferred ripeness level: Raw, Medium, or Ripe.',
                  ),
                  _FaqItem(
                    q: 'What is the JioPrime membership benefit?',
                    a: 'JioPrime members receive an extra 5% discount on all items in the cart, in addition to regular supermarket deals and bulk discounts.',
                  ),
                  _FaqItem(
                    q: 'What is the Freshness Guarantee policy?',
                    a: '100% fresh or full refund within 24 hours of delivery. No questions asked return at delivery partner doorstep.',
                  ),
                  _FaqItem(
                    q: 'Can I get a GST tax invoice for my business?',
                    a: 'Yes! Toggle "I need a GST Invoice" at checkout or save your GSTIN under Profile. You can download and print a compliant Tax Invoice PDF directly from the app.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, AuthProvider auth) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.logout),
        content: Text(l10n.logoutConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () async {
              Navigator.pop(ctx);
              await auth.logout();
              if (context.mounted) {
                context.go('/login');
              }
            },
            child: Text(l10n.logout),
          ),
        ],
      ),
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsGroup({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: AppColors.textSecondary,
                letterSpacing: 0.3,
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary, size: 22),
      title: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
      ),
      trailing: const Icon(Icons.chevron_right, size: 20, color: AppColors.textHint),
      onTap: onTap,
    );
  }
}

class _SwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      secondary: Icon(icon, color: AppColors.primary, size: 22),
      title: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
      ),
      value: value,
      activeColor: AppColors.primary,
      onChanged: onChanged,
    );
  }
}

class _FaqItem extends StatelessWidget {
  final String q;
  final String a;

  const _FaqItem({required this.q, required this.a});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            q,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            a,
            style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.3),
          ),
          const Divider(height: 20),
        ],
      ),
    );
  }
}
