import 'dart:async';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

import 'package:mapa_app/helpers/debouncer.dart';
import 'package:mapa_app/models/driving_response.dart';
import 'package:mapa_app/models/search_response.dart';

class TraficService {
  
  TraficService._privateConstructor();
  static final TraficService _instance = TraficService._privateConstructor();
  factory TraficService()=> _instance;

  final _dio = new Dio();
  final debouncer = Debouncer<String>(duration: Duration(milliseconds: 500 ));
   
  final _baseDir = 'https://api.mapbox.com/directions/v5';
  final _baseGeo = 'https://api.mapbox.com/geocoding/v5/mapbox.places';
  final _apiKey = 
  'pk.eyJ1IjoicGFjb2Rlcmdvc2giLCJhIjoiY2t1NG1lemRjNHNkbDJ4cG1mem5obDZ4MyJ9.2r0aWVJE9-KU7mdKqX4Vhg';

  final _sugerenciaStreamCtrl = StreamController<SearchResponse>.broadcast();
  Stream<SearchResponse> get sugerenciasStream => _sugerenciaStreamCtrl.stream;


  Future<DrivingResponse> getCoordsInicioFin( LatLng inicio, LatLng fin )async{

    final coordString = 
      '${inicio.longitude},${inicio.latitude};${fin.longitude},${fin.latitude}';

    final resp = await _dio.get( '$_baseDir/mapbox/driving/$coordString', 
      queryParameters: {
        'alternatives' : 'false',
        'geometries' : 'polyline6',
        'steps' : 'false',
        'access_token' : this._apiKey,
        'language' : 'es',
      }
    );

    final data = DrivingResponse.fromMap(resp.data);

    return data;
  }

  Future<SearchResponse> getSearchResult(String search, LatLng? location)async{

    try {  
      final resp = await _dio.get( '$_baseGeo/$search.json',
        queryParameters: {
          'access_token' : _apiKey,
          'autocomplete' : 'true',
          'proximity'    : '${location?.longitude},${location?.latitude}',
          'language'     : 'es'
        }
      );
      
      return SearchResponse.fromJson(resp.data);

    } catch (_) {
      return SearchResponse( features: [] );
    }

  }

  void getSugerenciasPorQuery( String busqueda, LatLng proximidad ) {

    debouncer.value = '';
    debouncer.onValue = ( value ) async {
      final resultados = await getSearchResult(value, proximidad);
      this._sugerenciaStreamCtrl.add(resultados);
    };

    final timer = Timer.periodic(Duration(milliseconds: 200), (_) {
      debouncer.value = busqueda;
    });

    Future.delayed(Duration(milliseconds: 201)).then((_) => timer.cancel()); 
  }

}