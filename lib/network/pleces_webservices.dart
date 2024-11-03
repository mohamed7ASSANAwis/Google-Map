import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlacesWebservices {
  late Dio dio;

  PlacesWebservices() {
    BaseOptions options = BaseOptions(
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
    dio.interceptors.add(InterceptorsWrapper(
      onResponse: (response, handler) {
        print("Response status code: ${response.statusCode}");
        return handler.next(response); // Continue with the response
      },
      onError: (DioError error, handler) {

        if (error.response != null) {
          print("Error status code: ${error.response?.statusCode}");
        }
        return handler.next(error);
      },
    ));
  }
  Future<List<dynamic>> fetchSuggestions(String place, String sessionToken) async {
    const String apiKey = "key";  // Store API key securely
    try {
      Response response = await dio.get(
        "https://maps.googleapis.com/maps/api/place/autocomplete/json",
        queryParameters: {
          "input": place,
          "type": "address",  // Example of a valid type, you can change as per need
          "components": "country:eg",
          "key": apiKey,
          "sessiontoken": sessionToken,
        },
      );
      //print("Status code: ${response.statusCode}");
      print("dddddddddddddddddddddddddd");
      print("dddddddddddddddddddddddddd");
      print(response.data["predictions"]);
      return response.data["predictions"];
    } catch (error) {
      print("Error fetching suggestions: ${error.toString()}");
      return [];
    }
  }
  // Future<List<dynamic>> fetchPlace(String place, String sessionToken) async {
  //   const String apiKey = "AIzaSyC4gTSwhUFShnUEBpmB3UPDuPJEB8N0ru4";  // Store API key securely
  //   try {
  //     Response response = await dio.get(
  //       "https://maps.googleapis.com/maps/api/place/details/json",
  //       queryParameters: {
  //         "place_id": place,
  //         "fields": "geometry",
  //         "key": apiKey,
  //         "sessiontoken": sessionToken,
  //       },
  //     );
  //     //print("Status code: ${response.statusCode}");
  //     print("dddddddddddddddddddddddddd");
  //     print(response.data["predictions"]);
  //     return response.data;
  //   } catch (error) {
  //     print("Error fetching suggestions: ${error.toString()}");
  //     return [];
  //   }
  // }

  Future<dynamic> getPlaceLocation(String placeId, String sessionToken) async {
    const String apiKey = "key";  // Sto
    try {
      Response response = await dio.get(
        "https://maps.googleapis.com/maps/api/place/details/json",
        queryParameters: {
          'place_id': placeId,
          'fields': 'geometry',
          'key': apiKey,
          'sessiontoken': sessionToken
        },
      );
      print("yyyyyyyyyyyyyyyyyyyyyyy");
      print( response.data);
      return response.data;
    } catch (error) {
      return Future.error("Place location error : ",
          StackTrace.fromString(('this is its trace')));
    }
  }
  // origin equals current location
  // destination equals searched for location
  Future<dynamic> getDirections(LatLng origin, LatLng destination) async {
    const String apiKey = "key";  // Store API key securely
    try {
      Response response = await dio.get(
        "https://maps.googleapis.com/maps/api/directions/json",
        queryParameters: {
          'origin': '${origin.latitude},${origin.longitude}',
          'destination': '${destination.latitude},${destination.longitude}',
          'key': apiKey,
        },
      );
      print("Omar I'm testing directions");
      print(response.data);
      return response.data;
    } catch (error) {
      return Future.error("Place location error : ",
          StackTrace.fromString(('this is its trace')));
    }
  }
}
