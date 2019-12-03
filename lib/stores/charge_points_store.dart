import 'dart:async';

import 'package:amzur_todo_example/models/charge_point.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

part 'charge_points_store.g.dart';

class ChargePointsStore = _ChargePointsStore with _$ChargePointsStore;

//flutter packages pub run build_runner clean
//flutter packages pub run build_runner build

abstract class _ChargePointsStore with Store {

  @observable
  Position currentPosition;

  StreamSubscription<Position> _positionSubscription;

  @observable
  Set<ChargePoint> chargePoints = {};

  Future<void> initialize() async{
    currentPosition = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  void listenToPositionChanges(GoogleMapController _mapController){
    _positionSubscription = Geolocator().getPositionStream(LocationOptions(distanceFilter: 100)).listen((newPosition){
      print("New position detected: ${newPosition.latitude}, ${newPosition.longitude}");
      _mapController.moveCamera(CameraUpdate.newLatLng(LatLng(newPosition.latitude, newPosition.longitude)));
    });
  }

  void stopListeningToPositionChanges(){
    _positionSubscription?.cancel();
  }

  // Simulates an API call to collect hubs info
  @action
  Future<void> getChargingHubs() async {
    await Future.delayed(const Duration(seconds: 2));
    Set<ChargePoint> hubs = {};
    for(int i = 1; i <= 10; i++){
      hubs.add(ChargePoint.placeholder(i, currentPosition.latitude, currentPosition.longitude));
    }

    chargePoints = hubs;
  }

}