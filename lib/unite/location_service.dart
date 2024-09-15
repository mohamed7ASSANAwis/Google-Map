import 'package:location/location.dart';

class LocationService{
  Location location=Location();

  Future<bool> checkAndRequestLocationService()async {
    var isEnabled=await location.serviceEnabled();
    if(!isEnabled){
      isEnabled=  await location.requestService();
      if(!isEnabled){
      return false;
      }
    }
    return true;
}

  Future<bool> checkAndRequestLocationPermission()async {
    var permissionStatus = await location.hasPermission();
    if(permissionStatus ==  PermissionStatus.deniedForever){
      return false;
    }
    if(permissionStatus ==  PermissionStatus.denied){
      permissionStatus= await location.requestPermission();
      return permissionStatus ==PermissionStatus.granted;
    }

    return true;
  }
  void getRealTimeLocationData(void Function(LocationData)?onData){
    location.onLocationChanged.listen(onData);
  }
}