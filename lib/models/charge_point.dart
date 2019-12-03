import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ChargePoint {
  final String id;
  final double latitude;
  final double longitude;
  final List<Connector> connectors;

  int get capacity {
    int cap = 0;
    connectors.forEach((connector) {
      cap += connector.available + connector.offline + connector.occupied;
    });

    return cap;
  }

  double get vacancyRate {
    int availableCount = 0;
    connectors.forEach((connector) {
      availableCount += connector.available;
    });

    return availableCount / capacity;
  }

  ChargePoint({@required this.id, @required this.latitude, @required this.longitude, @required this.connectors});

  factory ChargePoint.fromJson(Map<String, dynamic> data) {
    List<Connector> connectors = [];

    // this loop may contain errors. Test with real api call
    for (Map<String, dynamic> connectorData in data["connectors"]) {
      connectors.add(Connector.fromJson(connectorData));
    }

    return ChargePoint(
      id: data["chargePointID"],
      latitude: data["lat"],
      longitude: data["lon"],
      connectors: connectors,
    );
  }

  // simulates chargers data coming from the API
  factory ChargePoint.placeholder(int index, double latitude, double longitude) {
    LatLng hubLocation = LatLng(
      latitude + sin(index * pi / 5.0) / 20.0,
      longitude + cos(index * pi / 5.0) / 20.0,
    );

    return ChargePoint(id: index.toString(), latitude: hubLocation.latitude, longitude: hubLocation.longitude, connectors: _generateConnectorsPlaceholders(),);
  }

  static List<Connector> _generateConnectorsPlaceholders(){
    return [
      Connector.placeholder(),
      Connector.placeholder(),
      Connector.placeholder(),
      Connector.placeholder(),
      Connector.placeholder(),
    ];
  }

  @override
  bool operator ==(other) {
    if (other.runtimeType != this.runtimeType) return false;

    return (this.id == other.id) && (this.latitude == other.latitude) && (this.longitude == other.longitude);
  }

  @override
  int get hashCode => hash3(this.id, this.latitude, this.longitude);
}

class Connector {
  final String connectorType;
  final int available;
  final int occupied;
  final int offline;
  final double price;

  Connector({
    @required this.connectorType,
    @required this.available,
    @required this.occupied,
    @required this.offline,
    @required this.price,
  });

  factory Connector.fromJson(Map<String, dynamic> data) {
    return Connector(
      connectorType: data['connector_type'],
      available: data['available'],
      occupied: data['occupied'],
      offline: data['offline'],
      price: data['price']?.toDouble(),
    );
  }

  factory Connector.placeholder() {
    return Connector(
      connectorType: 'CCS',
      available: 3,
      occupied: 1,
      offline: 0,
      price: 10.0,
    );
  }
}
