
import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class SearchResult {

  final bool cancelo;
  final bool? manual;
  final LatLng? destino;
  final String? nombreDestino;
  final String? descripcion;
  final bool agregarBusqueda;

  SearchResult({
    required this.cancelo,
    this.manual, 
    this.destino, 
    this.nombreDestino, 
    this.descripcion,
    this.agregarBusqueda = true
  });


  SearchResult copyWith({
    bool? cancelo,
    bool? manual,
    LatLng? destino,
    String? nombreDestino,
    String? descripcion,
    bool? agregarBusqueda,
  }) {
    return SearchResult(
      cancelo: cancelo ?? this.cancelo,
      manual: manual ?? this.manual,
      destino: destino ?? this.destino,
      nombreDestino: nombreDestino ?? this.nombreDestino,
      descripcion: descripcion ?? this.descripcion,
      agregarBusqueda: agregarBusqueda ?? this.agregarBusqueda,
    );
  }
}
