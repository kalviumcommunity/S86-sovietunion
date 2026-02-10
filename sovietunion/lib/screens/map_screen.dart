import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng _defaultPosition = LatLng(28.6139, 77.2090); // New Delhi

  final Set<Marker> _markers = {};
  Position? _currentPosition;
  StreamSubscription<Position>? _positionStream;
  BitmapDescriptor? _customIcon;

  @override
  void initState() {
    super.initState();
    _loadCustomIcon();
    _initLocation();
  }

  Future<void> _loadCustomIcon() async {
    try {
      final icon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(48, 48)),
        'assets/images/location_pin.png',
      );
      setState(() {
        _customIcon = icon;
      });
    } catch (_) {
      // If asset is missing, continue with default marker
    }
  }

  Future<void> _initLocation() async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      final requested = await Geolocator.requestPermission();
      if (requested == LocationPermission.denied || requested == LocationPermission.deniedForever) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Location permission denied. Enable it from settings.'),
          ));
        }
        return;
      }
    }

    try {
      final pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      _updateUserLocation(pos, animate: true);

      _positionStream = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 5),
      ).listen((Position p) {
        _updateUserLocation(p);
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error fetching location: $e')));
      }
    }
  }

  Future<void> _updateUserLocation(Position pos, {bool animate = false}) async {
    _currentPosition = pos;
    final marker = Marker(
      markerId: const MarkerId('user_live'),
      position: LatLng(pos.latitude, pos.longitude),
      infoWindow: const InfoWindow(title: 'You are here'),
      icon: _customIcon ?? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    );

    setState(() {
      _markers
        ..removeWhere((m) => m.markerId == const MarkerId('user_live'))
        ..add(marker);
    });

    if (animate && _controller.isCompleted) {
      final controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(pos.latitude, pos.longitude), zoom: 15),
      ));
    }
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final initialTarget = _currentPosition != null
        ? LatLng(_currentPosition!.latitude, _currentPosition!.longitude)
        : _defaultPosition;

    return Scaffold(
      appBar: AppBar(title: const Text('Map Demo')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: initialTarget, zoom: 12),
        markers: _markers.isEmpty
            ? {
                Marker(
                  markerId: const MarkerId('default'),
                  position: _defaultPosition,
                  infoWindow: const InfoWindow(title: 'New Delhi'),
                )
              }
            : _markers,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: (GoogleMapController controller) async {
          if (!_controller.isCompleted) _controller.complete(controller);
          if (_currentPosition != null) {
            await controller.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude), zoom: 15),
            ));
          }
        },
      ),
    );
  }
}
