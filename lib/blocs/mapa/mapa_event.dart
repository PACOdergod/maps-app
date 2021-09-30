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

class OnCrearRuta extends MapaEvent {
  final List<LatLng> coordenadas;
  final double distancia;
  final double duracion;

  OnCrearRuta({
    required this.coordenadas, 
    required this.distancia, 
    required this.duracion
  });
}