import 'package:amzur_todo_example/models/charging_hub.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

part 'charging_hubs_store.g.dart';

class ChargingHubsStore = _ChargingHubsStore with _$ChargingHubsStore;

//flutter packages pub run build_runner clean
//flutter packages pub run build_runner build

abstract class _ChargingHubsStore with Store {

  final LatLng _initialLocation = LatLng(37.43296265331129, -122.08832357078792);
  LatLng get initialLocation => _initialLocation;

  @observable
  Set<ChargingHub> chargingHubs = {};

  // Simulates an API call to collect hubs info
  @action
  Future<void> getChargingHubs() async {
    await Future.delayed(const Duration(seconds: 2));
    Set<ChargingHub> hubs = {};
    for(int i = 1; i <= 10; i++){
      hubs.add(ChargingHub.placeholder(i, _initialLocation));
    }

    chargingHubs = hubs;
  }

}