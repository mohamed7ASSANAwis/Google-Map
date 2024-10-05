import 'package:flutter/material.dart';
import 'package:google_map/unite/location_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMapVeiw extends StatefulWidget {
  const CustomGoogleMapVeiw({super.key});

  @override
  State<CustomGoogleMapVeiw> createState() => _CustomGoogleMapVeiwState();
}

class _CustomGoogleMapVeiwState extends State<CustomGoogleMapVeiw> {
  late CameraPosition initialCameraPosition;
  late LocationService locationService;
  late   GoogleMapController googleMapController;
  Set<Marker> markers = {};

  @override
  void initState() {
    initialCameraPosition = CameraPosition(
        target: LatLng(29.321099961118627, 31.19660308460513), zoom: 10);
    initiMarker();
    locationService=LocationService();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        markers: markers,
        zoomControlsEnabled: false,
        initialCameraPosition: initialCameraPosition,
    onMapCreated: (controller){
      googleMapController = controller;
      updataCurrentLocation();
    },
    );
  }

  void initiMarker() {
    var myMarker = Marker(
        markerId: MarkerId("1"),
        position: LatLng(29.349076099818955, 31.209870474283296));
    markers.add(myMarker);
  }

  void updataCurrentLocation() async {
    try {
      var  locationData=await locationService.getLocation();
    var cameraPosition=  CameraPosition(target: LatLng(locationData.latitude!, locationData.longitude!),zoom: 10);
  googleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    } on LocationServiceException catch (e) {
    } on LocationPermissionException catch (e) {
    } catch (e) {}
  }
}
