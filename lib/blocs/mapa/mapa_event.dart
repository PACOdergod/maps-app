part of 'mapa_bloc.dart';

@immutable
abstract class MapaEvent {}

class OnMapaListo extends MapaEvent {}

class OnLocationUpdate extends MapaEvent {
  final LatLng newLocation;
  OnLocationUpdate(this.newLocation);
}

class OnMarcarRecorrido extends MapaEvent {}

class Onfollow extends MapaEvent {}