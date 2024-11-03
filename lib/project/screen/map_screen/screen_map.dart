import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map/project/screen/widget/drawer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:uuid/uuid.dart';

import '../../../models/dicoration_model.dart';
import '../../../models/place.dart';
import '../../../models/search_model.dart';
import '../../../models/suge.dart';
import '../../helper/helper.dart';
import '../cubit/maps_cubit.dart';
import '../widget/dicoration.dart';
import '../widget/place_item.dart';

class ScreenMap extends StatefulWidget {
  const ScreenMap({super.key});

  @override
  State<ScreenMap> createState() => _ScreenMapState();
}

class _ScreenMapState extends State<ScreenMap> {
  static Position? position;
  Completer<GoogleMapController> _mapController = Completer();
  List<PlaceSuggestion> places = [];
  FloatingSearchBarController controller = FloatingSearchBarController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static final CameraPosition _myCurrentLocationCameraPosition = CameraPosition(
    bearing: 0.0,
    target: LatLng(position!.latitude, position!.longitude),
    tilt: 0.0,
    zoom: 17,
  );

  Set<Marker> merkers = Set();
  late PlaceSuggestion placeSuggestion;
  late PlaceModel selectedPlace;
  late Marker searchedPlaceMarker;
  late Marker currentPlaceMarker;
  late CameraPosition goToSearchedForPlace;


  // these variables for getDirections
  PlaceDirections? placeDirections;
  var progressIndicator = false;
  late List<LatLng> polylinePoints;
  var isSearchedPlaceMarkerClicked = false;
  var isTimeAndDistanceVisible = false;

  void buildCamerNewPositon() {
    goToSearchedForPlace = CameraPosition(
        zoom: 13,
        tilt: 0.0,
        bearing: 0.0,
        target: LatLng(
          selectedPlace.result.geometry.location.lat,
          selectedPlace.result.geometry.location.lng,
        ));
  }

  Future<void> getMyCurrentLocation() async {
    position = await LocationHelper.getCurrentLocation().whenComplete(() {
      setState(() {});
    });
  }

  Widget buildMap() {
    return GoogleMap(
      mapType: MapType.normal,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      markers: merkers,
      initialCameraPosition: _myCurrentLocationCameraPosition,
      onMapCreated: (GoogleMapController controller) {
        _mapController.complete(controller);
      },
      polylines: placeDirections != null
          ? {
        Polyline(
          polylineId: const PolylineId('my_polyline'),
          color: Colors.black,
          width: 2,
          points: polylinePoints,
        ),
      }
          : {},
    );
  }

  Future<void> _goToMyCurrentLocation() async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(_myCurrentLocationCameraPosition));
  }

  @override
  void initState() {
    getMyCurrentLocation();
    super.initState();
  }
  Widget buildDiretionsBloc() {
    return BlocListener<MapsCubit, MapsState>(
      listener: (context, state) {
        if (state is DirectionsLoaded) {
          placeDirections = (state).directions;

          getPolylinePoints();
        }
      },
      child: Container(),
    );
  }
  void getPolylinePoints() {
    polylinePoints = placeDirections!.polylinePoints
        .map((e) => LatLng(e.latitude, e.longitude))
        .toList();
  }
  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      progress: progressIndicator,
      key: formKey,
      controller: controller,
      elevation: 6,
      hintStyle: TextStyle(fontSize: 18),
      queryStyle: TextStyle(fontSize: 18),
      hint: 'Find a place..',
      border: BorderSide(style: BorderStyle.none),
      margins: EdgeInsets.fromLTRB(20, 70, 20, 0),
      padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
      height: 52,
      iconColor: Colors.blue,
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 600),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onFocusChanged: (_) {
        // hide distance and time row
        setState(() {
          isTimeAndDistanceVisible = false;
        });
      },
      //  progress: progressIndicator,
      onQueryChanged: (query) {
        getPlacesSuggestions(query);
      },

      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
              icon: Icon(Icons.place, color: Colors.black.withOpacity(0.6)),
              onPressed: () {}),
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              buildSuggestionsBloc(),

              ///لم list تيجي هنا بعمل lisnt انه لو دوست تيجي
              buildSelectedPlaceLocationBloc(),
              ///دي lesnt
              buildDiretionsBloc(),
            ],
          ),
        );
      },
    );
  }

  void getSelectedPlaceLocation() {
    final sessionToken = Uuid().v4();
    BlocProvider.of<MapsCubit>(context)
        .emitPlaceLocation(placeSuggestion.placeId, sessionToken);
  }

  void getPlacesSuggestions(String query) {
    final sessionToken = Uuid().v4();
    BlocProvider.of<MapsCubit>(context).emiteSuggestions(query, sessionToken);
  }

  Widget buildSelectedPlaceLocationBloc() {
    return BlocListener<MapsCubit, MapsState>(
      listener: (context, state) {
        if (state is PlaceLocationLoaded) {
          selectedPlace = (state).place;

          goToMySearchedForLocation();
          getDirections();
        }
      },
      child: Container(),
    );
  }
  void getDirections() {
    BlocProvider.of<MapsCubit>(context).emitDirections(
      LatLng(position!.latitude, position!.longitude),
      LatLng(selectedPlace.result.geometry.location.lat,
          selectedPlace.result.geometry.location.lng),
    );
  }
  // Future<void> goToMySearchedLocation() async {
  //   buildCamerNewPositon();
  //   final GoogleMapController controller = await _mapController.future;
  //   controller
  //       .animateCamera(CameraUpdate.newCameraPosition(goToSearchedForPlace));
  //   buildSearchMarker();
  // }
  Future<void> goToMySearchedForLocation() async {
    buildCamerNewPositon();
    final GoogleMapController controller = await _mapController.future;
    controller
        .animateCamera(CameraUpdate.newCameraPosition(goToSearchedForPlace));
    buildSearchedPlaceMarker();
  }
  void buildSearchedPlaceMarker() {
    searchedPlaceMarker = Marker(
      position: goToSearchedForPlace.target,
      markerId: MarkerId('1'),
      onTap: () {
        buildCurrentLocationMarker();
        // show time and distance
        setState(() {
          isSearchedPlaceMarkerClicked = true;
          isTimeAndDistanceVisible = true;
        });
      },
      infoWindow: InfoWindow(title: "${placeSuggestion.description}"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );

    addMarkerToMarkersAndUpdateUI(searchedPlaceMarker);
  }


  void buildCurrentLocationMarker() {
    currentPlaceMarker = Marker(
        markerId: MarkerId("3"),
        position: LatLng(position!.latitude, position!.longitude),
        onTap: () {

        },
        infoWindow: InfoWindow(
            title: "your current location"

        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)
    );
    addMarkerToMarkersAndUpdateUI(currentPlaceMarker);
  }
void addMarkerToMarkersAndUpdateUI(Marker marker){
    setState(() {
      merkers.add(marker);
    });
}
  Widget buildSuggestionsBloc() {
    return BlocBuilder<MapsCubit, MapsState>(
      builder: (context, state) {
        if (state is PlacesLoading) {
          places = (state).place;
          if (places.length != 0) {
            return buildPlacesList();
          } else {
            return Container();
          }
        } else {
          return Container();
        }
      },
    );
  }
  void removeAllMarkersAndUpdateUI() {
    setState(() {
      merkers.clear();
    });
  }
  Widget buildPlacesList() {
    return ListView.builder(
        itemBuilder: (ctx, index) {
          return InkWell(
            onTap: () async {
              placeSuggestion = places[index];
              controller.close();
              getSelectedPlaceLocation();
              polylinePoints.clear();
              removeAllMarkersAndUpdateUI();
            },
            child: PlaceItem(
              suggestion: places[index],
            ),
          );
        },
        itemCount: places.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      body: Stack(
        children: [
          position != null
              ? buildMap()
              : Center(child: CircularProgressIndicator()),
          buildFloatingSearchBar(),
          isSearchedPlaceMarkerClicked
              ? DistanceAndTime(
            isTimeAndDistanceVisible: isTimeAndDistanceVisible,
            placeDirections: placeDirections,
          )
              : Container(),
        ],
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 8, 30),
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: _goToMyCurrentLocation,
          child: Icon(Icons.place, color: Colors.white),
        ),
      ),
    );
  }
}
