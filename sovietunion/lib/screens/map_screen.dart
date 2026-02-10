import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng _initialPosition = LatLng(28.6139, 77.2090); // New Delhi

  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId('delhi'),
      position: _initialPosition,
      infoWindow: InfoWindow(title: 'New Delhi'),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map Demo')),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: _initialPosition,
          zoom: 12,
        ),
        markers: _markers,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          if (!_controller.isCompleted) _controller.complete(controller);
        },
      ),
    );
  }
}
