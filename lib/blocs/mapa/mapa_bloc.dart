import 'dart:convert';

import 'package:flutter/material.dart' show Colors;
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapa_app/blocs/ubication/ubication_bloc.dart';
import 'package:meta/meta.dart';

import 'package:mapa_app/themes/my_map_theme.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  MapaBloc() : super(MapaState());

  //* Controlador 
  late GoogleMapController _controller;

  //* Polyline
  Polyline _miRuta = new Polyline(
    polylineId: PolylineId('mi_ruta'),
    width: 3,
    color: Colors.black
  );

  void initMap( GoogleMapController controller ){
    if( state.mapaListo ) return;

    this._controller = controller;

    this._controller.setMapStyle( json.encode(myMapTheme) );

    add( OnMapaListo() );
  }

  void moverCamara( LatLng destino ){
    final camaraUpdate = CameraUpdate.newLatLng( destino );
    this._controller.animateCamera( camaraUpdate );
  }

  @override
  Stream<MapaState> mapEventToState(MapaEvent event) async* {
    if ( event is OnMapaListo ) yield state.copyWith(mapaListo: true);

    else if (event is OnLocationUpdate) yield _onLocationUpdate(event);

    else if (event is OnMarcarRecorrido) yield _onMarcarRecorrido(event);

    else if (event is Onfollow){
      yield state.copyWith( follow: !state.follow );
    }
  }


  MapaState _onLocationUpdate( OnLocationUpdate event ){

    if ( state.follow ) this.moverCamara( event.newLocation );
    
    List<LatLng> points = [ ..._miRuta.points, event.newLocation ];
    this._miRuta = this._miRuta.copyWith( pointsParam: points );

    final currentPolylines = state.polylines;
    currentPolylines['mi_ruta'] = this._miRuta;

    return state.copyWith( polylines: currentPolylines );
  }

  MapaState _onMarcarRecorrido( OnMarcarRecorrido event ){
    if ( !state.dibujarRecorrido ) {
      this._miRuta = this._miRuta.copyWith( colorParam: Colors.black );
    } else {
      this._miRuta = this._miRuta.copyWith( colorParam: Colors.transparent );
    }

    final currentPolilyne = state.polylines;
    currentPolilyne['mi_ruta'] = this._miRuta;

    return state.copyWith( 
      polylines: currentPolilyne,
      dibujarRecorrido: !state.dibujarRecorrido
    );
  }
}
