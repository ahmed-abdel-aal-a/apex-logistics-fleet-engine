import '../entities/courier_telemetry.dart';

/// Abstract contract for courier dispatching and offline-first queue persistence.
abstract class IDispatchRepository {
  /// Streams live telemetry to the central operations gateway over WebSockets.
  Stream<GeolocationTelemetry> streamCourierTelemetry({
    required String courierId,
    required Duration samplingInterval,
  });

  /// Persists telemetry records locally during network disconnections.
  Future<void> enqueueOfflineTelemetry(GeolocationTelemetry telemetry);

  /// Synchronizes cached telemetry records when wide-area connectivity is restored.
  Future<int> drainOfflineTelemetryQueue();

  /// Acknowledges an incoming dispatched order.
  Future<bool> acknowledgeDispatchedOrder({
    required String orderId,
    required String courierId,
    required DateTime acknowledgmentTime,
  });
}
