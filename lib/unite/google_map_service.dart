import 'package:dio/dio.dart';
import 'package:google_map/models/search_map_model.dart';

class GoogleMapService {
  final String baseUrlGoogleMap =
      "https://maps.googleapis.com/maps/api/place/autocomplete/json";

  Future<List<SearchMapModel>> getPredictions({required String input}) async {
    var dio = Dio();
    var response = await dio.get(
      baseUrlGoogleMap.toString(),
      queryParameters: {
        'input': input,
        'key': 'AIzaSyC4gTSwhUFShnUEBpmB3UPDuPJEB8N0ru4'
      },
    );
    if (response.statusCode == 200) {
      List<SearchMapModel> predictions = [];
      var data = response.data['predictions'];
      for (var item in data) {
        predictions.add(SearchMapModel.fromJson(item));
      }
      return predictions;
    } else {
      throw Exception();
    }
  }
}
