import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:math' as math;

import 'package:amzur_todo_example/main.dart';
import 'package:amzur_todo_example/models/charging_hub.dart';
import 'package:amzur_todo_example/widgets/bottom_charger_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  ChargingHub _selectedHub;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: chargingHubsStore.initialLocation,
    zoom: 12,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Observer(
          builder: (context) {
            // Why do we need a future builder here?
            return FutureBuilder<Set<Marker>>(
              future: _buildMarkers(90, 90), // There is a performance problem with this line. Any idea what it is?
              builder: (_, snapshot) {
                final bool hasMarkers =
                    snapshot.connectionState == ConnectionState.done &&
                        snapshot.data != null;

                return GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  markers: hasMarkers ? snapshot.data : {},
                  onTap: (_) {
                    setState(() {
                      _selectedHub = null;
                    });
                  },
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                );
              },
            );
          },
        ),
        _selectedHub != null
            ? Align(
                alignment: Alignment.bottomCenter,
                child: BottomChargerOverlay(_selectedHub),
              )
            : Container(),
      ],
    );
  }

  Future<Set<Marker>> _buildMarkers(int width, int height) async {
    Future<Uint8List> getBytesFromCanvas(ChargingHub hub) async {
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

      final double vacancySweepAngle = hub.vacancyRate * 2 * math.pi;
      final double occupancySweepAngle = (100 - hub.vacancyRate) * 2 * math.pi;

      canvas.drawCircle(Offset(radius, radius), radius,
          backgroundPaint); // draws the white circle
      canvas.drawArc(
        Rect.fromCircle(
            center: Offset(radius, radius), radius: radius - strokeWidth + 4),
        startAngle,
        occupancySweepAngle,
        false,
        occupancyPaint,
      ); // draws the blue arc representing occupancy
      canvas.drawArc(
        Rect.fromCircle(
            center: Offset(radius, radius), radius: radius - strokeWidth + 4),
        occupancySweepAngle + startAngle,
        vacancySweepAngle,
        false,
        vacancyPaint,
      ); // draws the green arc representing vacancy

      TextPainter vacancyTextPainter =
          TextPainter(textDirection: TextDirection.ltr);
      vacancyTextPainter.text = TextSpan(
        text: hub.capacity.toString(),
        style: TextStyle(
          fontSize: 30.0,
          color: textColorPrimaryDark,
        ),
      );
      vacancyTextPainter.layout();
      vacancyTextPainter.paint(
        canvas,
        Offset(
            (width * 0.5) - vacancyTextPainter.width * 0.5,
            (height * 0.5) -
                vacancyTextPainter.height *
                    0.5), // this offset center the text in the middle of the circle
      );

      final img = await pictureRecorder.endRecording().toImage(width, height);
      final data = await img.toByteData(format: ui.ImageByteFormat.png);
      return data.buffer.asUint8List();
    }

    Set<Marker> markers = {};

    for (ChargingHub hub in chargingHubsStore.chargingHubs) {
      markers.add(Marker(
        icon: BitmapDescriptor.fromBytes(await getBytesFromCanvas(hub)),
        markerId: MarkerId(hub.name),
        position: hub.location,
        onTap: () {
          setState(() {
            _selectedHub = hub;
          });
        },
      ));
    }

    return markers;
  }
}
