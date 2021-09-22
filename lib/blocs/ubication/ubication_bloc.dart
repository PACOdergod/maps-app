import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

part 'ubication_event.dart';
part 'ubication_state.dart';

class UbicationBloc extends Bloc<UbicationEvent, UbicationState> {

  UbicationBloc() : super(UbicationState());

  late StreamSubscription<Position> _positionSubs;

  void iniciarSeguimiento(){

    this._positionSubs = Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.high,
      distanceFilter: 10
    )
    .listen((Position pos) { 
      final newLocation = new LatLng(pos.latitude, pos.longitude);
      add( OnChangeUbication(newLocation) );
    });

  }

  void cancelarSeguimiento(){
    this._positionSubs.cancel();
  }

  @override
  Stream<UbicationState> mapEventToState(UbicationEvent event) async* {

    if ( event is OnChangeUbication ) {
      yield state.copyWith(
        existeUltimaUbicacion: true,
        ubicacion: event.ubicacion
      );
    }
    
  }
}
