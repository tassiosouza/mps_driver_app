import 'dart:async';
import 'dart:math';
import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mps_driver_app/models/Client.dart';

class SecondRoute extends StatefulWidget {
  final List<Client> clients;
  const SecondRoute({Key? key, required this.clients}) : super(key: key);

  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<SecondRoute> {
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  int _markerIdCounter = 1;
  MarkerId? selectedMarker;
  LatLng? markerPosition;
  static const LatLng center = LatLng(-33.86711, 151.1947171);

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.1522247, -117.2310085),
    zoom: 11.4746,
  );

  Future<void> _add(LatLng latlng, int index) async {
    final int markerCount = markers.length;

    final String markerIdVal = 'marker_id_$index';
    _markerIdCounter++;
    final MarkerId markerId = MarkerId(markerIdVal);

    final Uint8List customMarker = await getBytesFromAsset(
        path: 'assets/images/marker' + index.toString() + '.png',
        width: 30 // size of custom image as marker
        );

    final Marker marker = Marker(
      icon: BitmapDescriptor.fromBytes(customMarker),
      markerId: markerId,
      position: latlng,
      infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
      onTap: () => _onMarkerTapped(markerId),
    );

    setState(() {
      markers[markerId] = marker;
    });
  }

  Future<Uint8List> getBytesFromAsset(
      {required String path, required int width}) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void _onMarkerTapped(MarkerId markerId) {
    final Marker? tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      setState(() {
        final MarkerId? previousMarkerId = selectedMarker;
        if (previousMarkerId != null && markers.containsKey(previousMarkerId)) {
          final Marker resetOld = markers[previousMarkerId]!
              .copyWith(iconParam: BitmapDescriptor.defaultMarker);
          markers[previousMarkerId] = resetOld;
        }
        selectedMarker = markerId;
        final Marker newMarker = tappedMarker.copyWith(
          iconParam: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
        );
        markers[markerId] = newMarker;

        markerPosition = null;
      });
    }
  }

  @override
  void initState() {
    _getThingsOnStartup().then((value) {
      print('Async done');
    });
    Client client = new Client();
    client.name = 'Meal Prep Sunday';
    client.coordinates.latitude = 33.1522247;
    client.coordinates.longitude = -117.2310085;
    widget.clients.insert(0, client);
    var index = 1;
    widget.clients.forEach((client) => {
          _add(
              LatLng(client.coordinates.latitude, client.coordinates.longitude),
              index),
          index += 1,
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.clients[0].name);
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set<Marker>.of(markers.values),
      ),
    );
  }

  Future _getThingsOnStartup() async {
    await Future.delayed(Duration(seconds: 2));
  }
}