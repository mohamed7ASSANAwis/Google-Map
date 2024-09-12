import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGooleMap extends StatefulWidget {
  const CustomGooleMap({super.key});

  @override
  State<CustomGooleMap> createState() => _CustomGooleMapState();
}

class _CustomGooleMapState extends State<CustomGooleMap> {
  //late CameraTargetBounds cameraTargetBounds;
  late CameraPosition initialCameraPosition;
  late GoogleMapController googleMapController;

  @override
  void initState() {
    initialCameraPosition = CameraPosition(
        zoom: 10, target: LatLng(29.373088961975537, 31.172350072218592));
    super.initState();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(

            // cameraTargetBounds:cameraTargetBounds,
            onMapCreated: (controller) => googleMapController = controller,
            initialCameraPosition: initialCameraPosition),
        Positioned(
            bottom: 16,
            right: 10,
            left: 10,
            child: ElevatedButton(
                onPressed: () {
                  googleMapController.animateCamera(CameraUpdate.newLatLng(
                      LatLng(27.177268416767657, 31.18652980376458)));
                },
                child: Text("change"))),
      ],
    );
  }
}
//eeeeeeeeee
//1-zoom
//zoom world view 0=>3
//zoom country  view 4=>6
//zoom city view 10=>12
//zoom street view 13=>17
//zoom builde view 18=>20
//2-TargetBounds
//  cameraTargetBounds=CameraTargetBounds(LatLngBounds(
//            southwest:LatLng(29.32994143275711, 31.193952961968296) ,northeast: LatLng(29.361670311105442, 31.217856832698235),
//          ));
