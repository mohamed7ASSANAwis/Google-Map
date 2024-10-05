import 'package:location/location.dart';

class LocationService{
  Location location=Location();

  Future<void> checkAndRequestLocationService()async {
    var isEnabled=await location.serviceEnabled();
    if(!isEnabled){
      isEnabled=  await location.requestService();
      if(!isEnabled){
throw LocationServiceException();
      }
    }

}

  Future<void> checkAndRequestLocationPermission()async {
    var permissionStatus = await location.hasPermission();
    if(permissionStatus ==  PermissionStatus.deniedForever){
      throw LocationPermissionException();
    }
    if(permissionStatus ==  PermissionStatus.denied){
      permissionStatus= await location.requestPermission();
      if(permissionStatus !=PermissionStatus.granted){
        throw LocationPermissionException();
      }
    }


  }
  void getRealTimeLocationData(void Function(LocationData)?onData)async{
    await checkAndRequestLocationService();
    await checkAndRequestLocationPermission();
    location.onLocationChanged.listen(onData);
  }
  Future<LocationData> getLocation()async{
    await checkAndRequestLocationService();
    await checkAndRequestLocationPermission();
    return await location.getLocation();
  }
}

class LocationServiceException implements Exception{}
class LocationPermissionException implements Exception{}
// Future<bool> checkAndRequestLocationService()async {
//   var isEnabled=await location.serviceEnabled();
//   if(!isEnabled){
//     isEnabled=  await location.requestService();
//     if(!isEnabled){
//       return false;
//     }
//   }
//   return true;
// }
// Future<void> checkAndRequestLocationPermission()async {
//   var permissionStatus = await location.hasPermission();
//   if(permissionStatus ==  PermissionStatus.deniedForever){
//     return false;
//   }
//   if(permissionStatus ==  PermissionStatus.denied){
//     permissionStatus= await location.requestPermission();
//     return permissionStatus ==PermissionStatus.granted;
//   }
//
//   return true;
// }