// ============================================================
// Validators – form field validators.
// ============================================================

abstract class Validators {
  // +91 phone: 10 digits starting 6-9
  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) return 'Phone number is required';
    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length != 10) return 'Enter a 10-digit mobile number';
    if (!RegExp(r'^[6-9]').hasMatch(digits)) {
      return 'Number must start with 6, 7, 8 or 9';
    }
    return null;
  }

  // Name
  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) return 'Name is required';
    if (value.trim().length < 2) return 'Name must be at least 2 characters';
    return null;
  }

  // Email
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    if (!RegExp(r'^[\w.+-]+@[\w-]+\.[a-zA-Z]{2,}$').hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  }

  // GSTIN: 15-char format
  static String? gstin(String? value) {
    if (value == null || value.trim().isEmpty) return 'GSTIN is required';
    const pattern =
        r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$';
    if (!RegExp(pattern).hasMatch(value.trim().toUpperCase())) {
      return 'Invalid GSTIN format (e.g. 27AAPFU0939F1ZV)';
    }
    return null;
  }

  // Business name
  static String? businessName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Business name is required';
    return null;
  }

  // Address
  static String? address(String? value) {
    if (value == null || value.trim().isEmpty) return 'Address is required';
    if (value.trim().length < 10) return 'Enter a complete address';
    return null;
  }

  // Pincode
  static String? pincode(String? value) {
    if (value == null || value.trim().isEmpty) return 'Pincode is required';
    if (!RegExp(r'^\d{6}$').hasMatch(value.trim())) return 'Enter a valid 6-digit pincode';
    return null;
  }

  // Credit card number (basic Luhn)
  static String? cardNumber(String? value) {
    if (value == null || value.trim().isEmpty) return 'Card number is required';
    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 13 || digits.length > 19) return 'Invalid card number';
    if (!_luhn(digits)) return 'Invalid card number';
    return null;
  }

  static bool _luhn(String number) {
    int sum = 0;
    bool alt = false;
    for (int i = number.length - 1; i >= 0; i--) {
      int n = int.parse(number[i]);
      if (alt) {
        n *= 2;
        if (n > 9) n -= 9;
      }
      sum += n;
      alt = !alt;
    }
    return sum % 10 == 0;
  }

  // Card expiry MM/YY
  static String? cardExpiry(String? value) {
    if (value == null || value.trim().isEmpty) return 'Expiry date is required';
    final parts = value.split('/');
    if (parts.length != 2) return 'Format: MM/YY';
    final month = int.tryParse(parts[0]);
    final year = int.tryParse(parts[1]);
    if (month == null || month < 1 || month > 12) return 'Invalid month';
    if (year == null) return 'Invalid year';
    final now = DateTime.now();
    final expiry = DateTime(2000 + year, month + 1);
    if (expiry.isBefore(now)) return 'Card has expired';
    return null;
  }

  // CVV
  static String? cvv(String? value) {
    if (value == null || value.trim().isEmpty) return 'CVV is required';
    if (!RegExp(r'^\d{3,4}$').hasMatch(value.trim())) return 'Invalid CVV';
    return null;
  }

  // UPI ID: xxx@xxx
  static String? upiId(String? value) {
    if (value == null || value.trim().isEmpty) return 'UPI ID is required';
    if (!RegExp(r'^[\w.\-]{2,}@[a-zA-Z]{2,}$').hasMatch(value.trim())) {
      return 'Invalid UPI ID (e.g. name@upi)';
    }
    return null;
  }
}
