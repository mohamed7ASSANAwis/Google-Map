part of 'maps_cubit.dart';

@immutable
sealed class MapsState {}

final class MapsInitial extends MapsState {}
final class PlacesLoading extends MapsState {
  final List<PlaceSuggestion> place;

  PlacesLoading(this.place);
}
final class PlaceLocationLoaded extends MapsState {
  final PlaceModel place;

  PlaceLocationLoaded(this.place);
}
final class DirectionsLoaded extends MapsState {
  final PlaceDirections directions;

  DirectionsLoaded(this.directions);
}
