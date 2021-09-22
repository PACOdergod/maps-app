part of 'ubication_bloc.dart';

@immutable
class UbicationState {
  final bool seguir;
  final bool existeUltimaUbicacion;
  final LatLng? ubicacion;

  UbicationState({
    this.seguir = true, 
    this.existeUltimaUbicacion = false, 
    this.ubicacion
  });

  UbicationState copyWith({
    bool? seguir,
    bool? existeUltimaUbicacion,
    LatLng? ubicacion,
  })=> new UbicationState(
    seguir: seguir ?? this.seguir,
    existeUltimaUbicacion: existeUltimaUbicacion ?? this.existeUltimaUbicacion,
    ubicacion: ubicacion ?? this.ubicacion,
  );

}
