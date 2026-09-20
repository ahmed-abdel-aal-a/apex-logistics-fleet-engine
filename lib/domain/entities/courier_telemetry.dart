import 'dart:math';

/// Represents a geographic coordinate with velocity and heading telemetry.
class GeolocationTelemetry {
  final double latitude;
  final double longitude;
  final double speedKmh;
  final double headingDegrees;
  final double accuracyMeters;
  final DateTime timestamp;

  const GeolocationTelemetry({
    required this.latitude,
    required this.longitude,
    required this.speedKmh,
    required this.headingDegrees,
    required this.accuracyMeters,
    required this.timestamp,
  });

  /// Computes the Great-Circle distance to a target destination in meters.
  double distanceTo(double targetLat, double targetLng) {
    const earthRadiusMeters = 6371000.0;
    final dLat = _degToRad(targetLat - latitude);
    final dLng = _degToRad(targetLng - longitude);

    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degToRad(latitude)) *
            cos(_degToRad(targetLat)) *
            sin(dLng / 2) *
            sin(dLng / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadiusMeters * c;
  }

  static double _degToRad(double deg) => deg * (pi / 180.0);

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'speed_kmh': speedKmh,
        'heading': headingDegrees,
        'accuracy': accuracyMeters,
        'recorded_at': timestamp.toIso8601String(),
      };
}

/// Abstract Courier entity model for real-time fleet synchronization.
class CourierTelemetryEntity {
  final String courierId;
  final String activeShiftId;
  final bool isOnline;
  final bool isBatterySavingEnabled;
  final GeolocationTelemetry? lastPosition;
  final List<String> assignedOrderIds;

  const CourierTelemetryEntity({
    required this.courierId,
    required this.activeShiftId,
    required this.isOnline,
    required this.isBatterySavingEnabled,
    this.lastPosition,
    this.assignedOrderIds = const [],
  });
}
