import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapa_app/models/DrivingResponse.dart';

class TraficService {
  
  TraficService._privateConstructor();
  static final TraficService _instance = TraficService._privateConstructor();
  factory TraficService()=> _instance;

  final _dio = new Dio();
  final _baseUrl = 'https://api.mapbox.com/directions/v5';
  final _apiKey = 'pk.eyJ1IjoicGFjb2Rlcmdvc2giLCJhIjoiY2t1NG1lemRjNHNkbDJ4cG1mem5obDZ4MyJ9.2r0aWVJE9-KU7mdKqX4Vhg';


  Future<DrivingResponse> getCoordsInicioFin( LatLng inicio, LatLng fin ) async {

    final coordString = 
      '${inicio.longitude},${inicio.latitude};${fin.longitude},${fin.latitude}';
    final url = '$_baseUrl/mapbox/driving/$coordString';

    final resp = await _dio.get( url, queryParameters: {
      'alternatives' : 'false',
      'geometries' : 'polyline6',
      'steps' : 'false',
      'access_token' : this._apiKey,
      'language' : 'es',
    });

    final data = DrivingResponse.fromMap(resp.data);

    return data;
  }

}