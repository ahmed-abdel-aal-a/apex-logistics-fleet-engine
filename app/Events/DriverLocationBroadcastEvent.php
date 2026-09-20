<?php

namespace App\Events;

/**
 * Event DriverLocationBroadcastEvent
 * 
 * Event-driven WebSocket payload broadcasted to private courier and order channels.
 */
class DriverLocationBroadcastEvent
{
    public function __construct(
        public readonly string $courierId,
        public readonly string $orderId,
        public readonly float $latitude,
        public readonly float $longitude,
        public readonly float $speedKmh,
        public readonly float $heading,
        public readonly int $timestampEpoch
    ) {}

    /**
     * Get the channels the event should broadcast on.
     *
     * @return array<string>
     */
    public function broadcastOn(): array
    {
        return [
            "orders.{$this->orderId}.telemetry",
            "fleet.couriers.{$this->courierId}"
        ];
    }

    /**
     * Broadcast with custom telemetry payload.
     *
     * @return array<string, mixed>
     */
    public function broadcastWith(): array
    {
        return [
            'courier_id' => $this->courierId,
            'lat' => $this->latitude,
            'lng' => $this->longitude,
            'speed' => $this->speedKmh,
            'heading' => $this->heading,
            'epoch' => $this->timestampEpoch,
        ];
    }
}
