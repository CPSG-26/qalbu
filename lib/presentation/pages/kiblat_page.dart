import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qalbu/presentation/widgets/kiblat_location_error_widget.dart';
import 'package:qalbu/presentation/widgets/kiblat_widget.dart';

class KiblatPage extends StatefulWidget {
  static const routeName = '/kiblat-page';

  const KiblatPage({Key? key}) : super(key: key);

  @override
  State<KiblatPage> createState() => _KiblatPageState();
}

class _KiblatPageState extends State<KiblatPage> {
  final _locationStreamController = StreamController<LocationStatus>.broadcast();

  get stream => _locationStreamController.stream;

  @override
  void initState() {
    _checkLocationStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Arah Kiblat"),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        child: StreamBuilder(
          stream: stream,
          builder: (context, AsyncSnapshot<LocationStatus> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data!.enabled == true) {
              switch (snapshot.data!.status) {
                case LocationPermission.always:
                case LocationPermission.whileInUse:
                  return const KiblatWidget();
                case LocationPermission.denied:
                  return KiblatLocationErrorWidget(
                    error: "Location service permission denied!\nPlease allow your app location permission and try again.",
                    callback: _checkLocationStatus,
                  );
                case LocationPermission.deniedForever:
                  return KiblatLocationErrorWidget(
                    error: "Location service denied forever!\nPlease allow your app location permission and try again.",
                    callback: _checkLocationStatus,
                  );
                default:
                  return Container();
              }
            } else {
              return KiblatLocationErrorWidget(
                error: "Please enable location service and try again.",
                callback: _checkLocationStatus,
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> _checkLocationStatus() async {
    final locationStatus = await FlutterQiblah.checkLocationStatus();
    if (locationStatus.enabled && locationStatus.status == LocationPermission.denied) {
      await FlutterQiblah.requestPermissions();
      final status = await FlutterQiblah.checkLocationStatus();
      _locationStreamController.sink.add(status);
    } else {
      _locationStreamController.sink.add(locationStatus);
    }
  }
  @override
  void dispose() {
    super.dispose();
    _locationStreamController.close();
    FlutterQiblah().dispose();
  }
}
