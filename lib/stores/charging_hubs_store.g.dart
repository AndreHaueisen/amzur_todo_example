// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'charging_hubs_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChargingHubsStore on _ChargingHubsStore, Store {
  final _$chargingHubsAtom = Atom(name: '_ChargingHubsStore.chargingHubs');

  @override
  Set<ChargingHub> get chargingHubs {
    _$chargingHubsAtom.context.enforceReadPolicy(_$chargingHubsAtom);
    _$chargingHubsAtom.reportObserved();
    return super.chargingHubs;
  }

  @override
  set chargingHubs(Set<ChargingHub> value) {
    _$chargingHubsAtom.context.conditionallyRunInAction(() {
      super.chargingHubs = value;
      _$chargingHubsAtom.reportChanged();
    }, _$chargingHubsAtom, name: '${_$chargingHubsAtom.name}_set');
  }

  final _$getChargingHubsAsyncAction = AsyncAction('getChargingHubs');

  @override
  Future<void> getChargingHubs() {
    return _$getChargingHubsAsyncAction.run(() => super.getChargingHubs());
  }
}
