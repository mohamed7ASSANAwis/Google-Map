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
  late TextEditingController textEditingController;
  Set<Marker> markers = {};

  @override
  void initState() {
    textEditingController=TextEditingController();
    initialCameraPosition = CameraPosition(
        target: LatLng(29.321099961118627, 31.19660308460513), zoom: 10);
    initiMarker();
    locationService=LocationService();
textEditingController.addListener((){
  print(textEditingController);
});
    super.initState();
  }
@override
  void dispose() {
  textEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
            markers: markers,
            zoomControlsEnabled: false,
            initialCameraPosition: initialCameraPosition,
        onMapCreated: (controller){
          googleMapController = controller;
          updataCurrentLocation();
        },
        ),
        Positioned(
        top: 16,right: 0,left: 0,
        child: CustomTextFeild(textEditingController: textEditingController,)),
      ],
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
      LatLng currentPosition=LatLng(locationData.latitude!, locationData.longitude!);
    var myMarker=  Marker(markerId: MarkerId("1"),position:currentPosition );
      markers.add(myMarker);
      setState(() {

      });
    var cameraPosition=  CameraPosition(target:currentPosition ,zoom: 10);
  googleMapController .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    } on LocationServiceException catch (e) {
    } on LocationPermissionException catch (e) {
    } catch (e) {}
  }
}
class CustomTextFeild extends StatelessWidget {
  const CustomTextFeild({super.key, required this.textEditingController});
final TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    return      TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
          hintText: "Search",
          fillColor: Colors.white,
          filled: true,
          border:buildBorder(),
        enabledBorder: buildBorder(),
      ),
    );
  }
}
OutlineInputBorder buildBorder(){
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: BorderSide(
        color: Colors.transparent,
      )
  );
}