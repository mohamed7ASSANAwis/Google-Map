import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_map/models/place.dart';
import 'package:google_map/models/search_model.dart';
import 'package:google_map/network/repo.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

import '../../../models/dicoration_model.dart';
import '../../../models/suge.dart';

part 'maps_state.dart';

class MapsCubit extends Cubit<MapsState> {
  final MapsRepository repo;
  MapsCubit(this.repo) : super(MapsInitial());

  static MapsCubit get(context) => BlocProvider.of(context);

  void emiteSuggestions(String place, String sessionToken){
    repo.fetchSuggestions(place, sessionToken).then((suggestions){
      emit(PlacesLoading(suggestions!));
    });
  }
  void emitPlaceLocation(String placeId, String sessionToken) {
    repo.getPlaceLocation(placeId, sessionToken).then((place) {
      emit(PlaceLocationLoaded(place));
    });
  }
  void emitDirections(LatLng origin, LatLng destination) {
    repo.getDirections(origin, destination).then((direction) {
      emit(DirectionsLoaded(direction));
    });
  }
}
