part of 'ubication_bloc.dart';

@immutable
abstract class UbicationEvent {}

class OnChangeUbication extends UbicationEvent {
  final LatLng ubicacion;

  OnChangeUbication(this.ubicacion);
}