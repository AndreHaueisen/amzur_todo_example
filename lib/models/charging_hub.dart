import 'dart:math';
import 'package:quiver/core.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ChargingHub {
  final LatLng location;
  final String name;
  final int capacity;
  final int occupancy;
  final int vacancy;
  final double vacancyRate;

  ChargingHub(this.location, this.name, this.capacity, this.occupancy)
      : vacancy = capacity - occupancy,
        vacancyRate = ((capacity - occupancy) / 100);

  // simulates chargers data coming from the API
  factory ChargingHub.placeholder(int index, LatLng initialLocation) {
    final List<double> fakeOccupancyMultiplier = [
      0.0,
      0.1,
      0.2,
      0.3,
      0.4,
      0.5,
      0.6,
      0.7,
      0.8,
      0.9,
      1.0,
    ];

    final Random random = Random(index);
    int randomName = random.nextInt(1000000);
    int randomCapacity = random.nextInt(100);
    int occupancy = (randomCapacity * fakeOccupancyMultiplier[index]).round();
    LatLng hubLocation = LatLng(
      initialLocation.latitude + sin(index * pi / 5.0) / 20.0,
      initialLocation.longitude + cos(index * pi / 5.0) / 20.0,
    );

    return ChargingHub(
        hubLocation, "Charging hub $randomName", randomCapacity, occupancy);
  }

  @override
  bool operator ==(other) {
    return this.location == other.location;
  }

  @override
  int get hashCode => hash2(this.location.latitude, this.location.longitude);
}
