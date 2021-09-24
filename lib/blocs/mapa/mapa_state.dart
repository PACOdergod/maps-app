
part of 'mapa_bloc.dart';

@immutable
class MapaState {
  final bool mapaListo;
  final bool dibujarRecorrido;

  final Map<String, Polyline> polylines;

  MapaState({
    this.mapaListo = false,
    this.dibujarRecorrido = false,
    Map<String, Polyline>? polylines
  }): this.polylines = polylines ?? Map();

  MapaState copyWith({
    bool? mapaListo,
    bool? dibujarRecorrido,
    Map<String, Polyline>? polylines
  }) {
    return MapaState(
      mapaListo: mapaListo ?? this.mapaListo,
      dibujarRecorrido: dibujarRecorrido ?? this.dibujarRecorrido,
      polylines: polylines ?? this.polylines
    );
  }
}
