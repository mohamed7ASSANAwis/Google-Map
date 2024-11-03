import 'package:google_map/models/place.dart';
import 'package:google_map/models/search_model.dart';
import 'package:google_map/network/pleces_webservices.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/dicoration_model.dart';
import '../models/suge.dart';

class MapsRepository {
  final PlacesWebservices placesWebService;

  MapsRepository(this.placesWebService);

  Future<List<PlaceSuggestion>?> fetchSuggestions(
      String place, String sessionToken) async {
    final suggestions =
        await placesWebService.fetchSuggestions(place, sessionToken);
    return suggestions
        .map((suggestions) => PlaceSuggestion.fromJson(suggestions))
        .toList();
  }

  Future<PlaceModel> getPlaceLocation(String placeId, String sessionToken) async {
    final place =
    await placesWebService.getPlaceLocation(placeId, sessionToken);
    // var readyPlace = Place.fromJson(place);
    return PlaceModel.fromJson(place);
  }
  Future<PlaceDirections> getDirections(
      LatLng origin, LatLng destination) async {
    final directions =
    await placesWebService.getDirections(origin, destination);

    return PlaceDirections.fromJson(directions);
  }
}
