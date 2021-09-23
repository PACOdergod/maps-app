import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

import 'package:mapa_app/themes/my_map_theme.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  MapaBloc() : super(MapaState());

  late GoogleMapController _controller;

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
    if ( event is OnMapaListo ) {
      yield state.copyWith(mapaListo: true);
    }
  }
}
