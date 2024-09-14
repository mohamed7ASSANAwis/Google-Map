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
  Set<Marker> marker = {};
  //Set<Circle> circle = {};

  @override
  void initState() {
    initialCameraPosition = CameraPosition(
        zoom: 6, target: LatLng(29.373088961975537, 31.172350072218592));
    initiMarker();
    // initCicle();
    super.initState();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(

        //circles: circle,
        markers: marker,
        // mapType: MapType.terrain,
        // cameraTargetBounds:cameraTargetBounds,
        zoomControlsEnabled: false,
        onMapCreated: (controller) {
          googleMapController = controller;
          intiMapStyle();
        },
        initialCameraPosition: initialCameraPosition);
  }

//onMapCreated مينفعش استدعي دي في inst علشان هضرب لازم في
  void intiMapStyle() async {
    var intiStyle = await DefaultAssetBundle.of(context)
        .loadString("assets/map_style/stander.json");
    googleMapController.setMapStyle(intiStyle);
  }

  void initiMarker() async {
    var BitIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), "assets/images/icon_location1.png");
    var myMarker = Marker(
        icon: BitIcon,
        markerId: MarkerId("1"),
        position: LatLng(29.349076099818955, 31.209870474283296));
    marker.add(myMarker);
    setState(() {});
  }
// void initCicle(){
//   Circle moCircle=
//   Circle(
//     fillColor: Colors.red.withOpacity(.5),
//     center: LatLng(29.321000571700907, 31.196205280858905),
//     radius: 10000,
//     circleId: CircleId('1'),
//   );
//   circle.add(moCircle);
// }
//   void initPolyLine() {
//     var polyline= Polyline(
//         visible: true,
//         endCap: Cap.roundCap,
//         startCap: Cap.roundCap,
//         width: 5,
//         geodesic: true,
//         zIndex: 5,
//         color: Colors.red,
//         polylineId: PolylineId("1"),
//
//         points: [
//           LatLng(30.00809441992408, 31.236445320751628),
//           LatLng(29.34530526191757, 31.19633184021425),
//           LatLng(29.31912731024233, 30.840243604224472),
//         ]
//     );
//     var polyline1= Polyline(
//         zIndex: 1,
//         polylineId: PolylineId("2"),
//
//         points: [
//           LatLng(29.97787260473582, 30.718191971012264),
//           LatLng(28.9930620676505, 31.58073567737086),
//
//         ]
//     );
//     polyLine.add(polyline);
//     polyLine.add(polyline1);
//   }
//
// // void initPolyGonse() {}
//و هنا نقدر تتحكم في حكم marker *******
//   void initiMarker()async {
//     var BitIcon=  BitmapDescriptor.fromBytes(await getImageFromRawData("assets/images/icon_location1.png", 100));
//     var myMarker =  Marker(
//         icon: BitIcon,
//         markerId: MarkerId("1"),
//         position: LatLng(29.349076099818955, 31.209870474283296));
//     marker.add(myMarker);
//     setState(() {
//
//     });
//   }
// Future<Uint8List>getImageFromRawData(String image,double widget)async{
//   var imageData=await rootBundle.load(image);
//   var imageCode=await ui.instantiateImageCodec(
//     imageData.buffer.asUint8List(),
//     targetWidth: widget.round(),
//
//   );
//   var imageFrame=await imageCode.getNextFrame();
//   var imageByteData=await imageFrame.image.toByteData(format: ui.ImageByteFormat.png);
//   return imageByteData!.buffer.asUint8List();
// }
//**********
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
//3.
//       Positioned(
//             bottom: 16,
//             right: 10,
//             left: 10,
//             child: ElevatedButton(
//                 onPressed: () {
//                   googleMapController.animateCamera(CameraUpdate.newLatLng(
//                       LatLng(27.177268416767657, 31.18652980376458)));
//                 },
//                 child: Text("change"))),