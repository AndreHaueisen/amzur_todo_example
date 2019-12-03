import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:math' as math;

import 'package:amzur_todo_example/main.dart';
import 'package:amzur_todo_example/models/charge_point.dart';
import 'package:amzur_todo_example/widgets/bottom_charger_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  GoogleMapController _mapController;

  GlobalKey<BottomChargerOverlayState> _overlayKey = GlobalKey();

  CameraPosition _lastCameraPosition;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        chargePointsStore.stopListeningToPositionChanges();
        return true;
      },
      child: Stack(
        children: [
          Observer(
            builder: (context) {
              return FutureBuilder<Set<Marker>>(
                future: _buildMarkers(90, 90),
                builder: (_, snapshot) {
                  final bool hasMarkers = snapshot.connectionState == ConnectionState.done && snapshot.data != null;
                  final LatLng initialPosition =
                      LatLng(chargePointsStore.currentPosition.latitude, chargePointsStore.currentPosition.longitude);

                  return GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(target: initialPosition, zoom: 12),
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    rotateGesturesEnabled: false,
                    tiltGesturesEnabled: false,
                    indoorViewEnabled: false,
                    onCameraMove: (CameraPosition cameraPosition) {
                      _lastCameraPosition = cameraPosition;
                    },
                    onCameraIdle: () {
                      // You can eliminate the 'if' condition if you only have one API endpoint
                      if (_lastCameraPosition.zoom <= 7) {
                        _mapController?.getVisibleRegion()?.then((LatLngBounds bounds) {
                          // TODO make api call
                          // Here you have the camera bounds, the user's position and zoom level
                          // Make the api call to fetch the chargePoints.
                        });
                      } else {
                        _mapController?.getVisibleRegion()?.then((LatLngBounds bounds) {
                          // TODO make api call
                          // Here you have the camera bounds, the user's position and zoom level
                          // Make the api call to fetch the chargePoints
                        });
                      }
                    },
                    markers: hasMarkers ? snapshot.data : {},
                    onTap: (_) {
                      _overlayKey.currentState.onHubChance(null);
                    },
                    onMapCreated: (GoogleMapController controller) {
                      _mapController = controller;
                      chargePointsStore.listenToPositionChanges(_mapController);
                    },
                  );
                },
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomChargerOverlay(key: _overlayKey),
          )
        ],
      ),
    );
  }

  Future<Set<Marker>> _buildMarkers(int width, int height) async {
    Future<Uint8List> getBytesFromCanvas(ChargePoint chargePoint) async {
      final double radius = width / 2;
      final double strokeWidth = 14;
      final double startAngle = -math.pi * 2 / 4;
      final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
      final Canvas canvas = Canvas(pictureRecorder);
      final Paint backgroundPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;
      final Paint occupancyPaint = Paint()
        ..color = Colors.blue
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth;
      final Paint vacancyPaint = Paint()
        ..color = Colors.green
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth;

      final double vacancySweepAngle = chargePoint.vacancyRate * 2 * math.pi; // calculate
      final double occupancySweepAngle = (100 - chargePoint.vacancyRate) * 2 * math.pi;

      canvas.drawCircle(Offset(radius, radius), radius, backgroundPaint); // draws the white circle

      canvas.drawArc(
        Rect.fromCircle(center: Offset(radius, radius), radius: radius - strokeWidth + 4),
        startAngle,
        occupancySweepAngle,
        false,
        occupancyPaint,
      ); // draws the blue arc representing occupancy
      canvas.drawArc(
        Rect.fromCircle(center: Offset(radius, radius), radius: radius - strokeWidth + 4),
        occupancySweepAngle + startAngle,
        vacancySweepAngle,
        false,
        vacancyPaint,
      ); // draws the green arc representing vacancy

      TextPainter vacancyTextPainter = TextPainter(textDirection: TextDirection.ltr);
      vacancyTextPainter.text = TextSpan(
        text: chargePoint.capacity.toString(),
        style: TextStyle(
          fontSize: 30.0,
          color: textColorPrimaryDark,
        ),
      );
      vacancyTextPainter.layout();
      vacancyTextPainter.paint(
        canvas,
        Offset((width * 0.5) - vacancyTextPainter.width * 0.5,
            (height * 0.5) - vacancyTextPainter.height * 0.5), // this offset center the text in the middle of the circle
      );

      final img = await pictureRecorder.endRecording().toImage(width, height);
      final data = await img.toByteData(format: ui.ImageByteFormat.png);
      return data.buffer.asUint8List();
    }

    Set<Marker> markers = {};

    for (ChargePoint chargePointLocation in chargePointsStore.chargePoints) {
      final LatLng hubLocation = LatLng(chargePointLocation.latitude, chargePointLocation.longitude);

      markers.add(
        Marker(
          icon: BitmapDescriptor.fromBytes(await getBytesFromCanvas(chargePointLocation)),
          markerId: MarkerId(chargePointLocation.id),
          position: hubLocation,
          onTap: () {
            _overlayKey.currentState.onHubChance(chargePointLocation);
            _mapController.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: hubLocation,
                  zoom: 12,
                ),
              ),
            );
          },
        ),
      );
    }

    return markers;
  }
}
