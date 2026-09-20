<?php

namespace App\Contracts;

/**
 * Interface FleetDispatchInterface
 * 
 * Defines the core contract for event-driven fleet dispatching,
 * route allocation, and real-time courier telemetry ingestion.
 */
interface FleetDispatchInterface
{
    /**
     * Dispatches an order to the optimal nearby active courier based on geodistance and capacity.
     *
     * @param string $orderId
     * @param array{lat: float, lng: float} $pickupCoordinates
     * @param array{lat: float, lng: float} $dropoffCoordinates
     * @return string|null The allocated courier ID or null if queued.
     */
    public function allocateOptimalCourier(
        string $orderId,
        array $pickupCoordinates,
        array $dropoffCoordinates
    ): ?string;

    /**
     * Broadcasts courier position to the Laravel Reverb WebSocket channel.
     *
     * @param string $courierId
     * @param float $latitude
     * @param float $longitude
     * @param float $speedKmh
     * @param float $heading
     * @return bool
     */
    public function broadcastCourierTelemetry(
        string $courierId,
        float $latitude,
        float $longitude,
        float $speedKmh,
        float $heading
    ): bool;

    /**
     * Validates whether delivery completion occurs within the verified destination polygon.
     *
     * @param string $orderId
     * @param float $courierLat
     * @param float $courierLng
     * @param float $radiusToleranceMeters
     * @return bool
     */
    public function verifyGeofencedDelivery(
        string $orderId,
        float $courierLat,
        float $courierLng,
        float $radiusToleranceMeters = 50.0
    ): bool;
}
