// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'charge_points_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChargePointsStore on _ChargePointsStore, Store {
  final _$currentPositionAtom =
      Atom(name: '_ChargePointsStore.currentPosition');

  @override
  Position get currentPosition {
    _$currentPositionAtom.context.enforceReadPolicy(_$currentPositionAtom);
    _$currentPositionAtom.reportObserved();
    return super.currentPosition;
  }

  @override
  set currentPosition(Position value) {
    _$currentPositionAtom.context.conditionallyRunInAction(() {
      super.currentPosition = value;
      _$currentPositionAtom.reportChanged();
    }, _$currentPositionAtom, name: '${_$currentPositionAtom.name}_set');
  }

  final _$chargePointsAtom = Atom(name: '_ChargePointsStore.chargePoints');

  @override
  Set<ChargePoint> get chargePoints {
    _$chargePointsAtom.context.enforceReadPolicy(_$chargePointsAtom);
    _$chargePointsAtom.reportObserved();
    return super.chargePoints;
  }

  @override
  set chargePoints(Set<ChargePoint> value) {
    _$chargePointsAtom.context.conditionallyRunInAction(() {
      super.chargePoints = value;
      _$chargePointsAtom.reportChanged();
    }, _$chargePointsAtom, name: '${_$chargePointsAtom.name}_set');
  }

  final _$getChargingHubsAsyncAction = AsyncAction('getChargingHubs');

  @override
  Future<void> getChargingHubs() {
    return _$getChargingHubsAsyncAction.run(() => super.getChargingHubs());
  }
}
