// ============================================================
// LocationService – wraps geolocator, falls back to Kharghar.
// ============================================================
import 'package:geolocator/geolocator.dart';
import '../core/app_constants.dart';

class LocationResult {
  final double lat;
  final double lng;
  final bool isDefault; // true = fallback used
  final String? errorMessage;

  const LocationResult({
    required this.lat,
    required this.lng,
    this.isDefault = false,
    this.errorMessage,
  });
}

class LocationService {
  static const _defaultLat = AppConstants.defaultLat;
  static const _defaultLng = AppConstants.defaultLng;

  Future<LocationResult> getCurrentLocation() async {
    try {
      // Check if location services are enabled
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return const LocationResult(
          lat: _defaultLat,
          lng: _defaultLng,
          isDefault: true,
          errorMessage: 'Location services are disabled.',
        );
      }

      // Check / request permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return const LocationResult(
            lat: _defaultLat,
            lng: _defaultLng,
            isDefault: true,
            errorMessage: 'Location permission denied.',
          );
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return const LocationResult(
          lat: _defaultLat,
          lng: _defaultLng,
          isDefault: true,
          errorMessage: 'Location permission permanently denied.',
        );
      }

      final pos = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
          timeLimit: Duration(seconds: 10),
        ),
      );

      return LocationResult(lat: pos.latitude, lng: pos.longitude);
    } catch (e) {
      return LocationResult(
        lat: _defaultLat,
        lng: _defaultLng,
        isDefault: true,
        errorMessage: e.toString(),
      );
    }
  }

  /// Distance in meters between two coordinates.
  double distanceBetween(
    double lat1,
    double lng1,
    double lat2,
    double lng2,
  ) {
    return Geolocator.distanceBetween(lat1, lng1, lat2, lng2);
  }
}
