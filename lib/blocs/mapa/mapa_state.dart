
part of 'mapa_bloc.dart';

@immutable
class MapaState {
  final bool mapaListo;
  final bool dibujarRecorrido;
  final bool follow;

  final Map<String, Polyline> polylines;
  final Map<String, Marker> markets;

  MapaState({
    this.mapaListo = false,
    this.dibujarRecorrido = false,
    this.follow = true,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markets
  }): this.polylines = polylines ?? Map(),
      this.markets = markets ?? Map();

  MapaState copyWith({
    bool? mapaListo,
    bool? dibujarRecorrido,
    bool? follow,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markets
  }) {
    return MapaState(
      mapaListo: mapaListo ?? this.mapaListo,
      dibujarRecorrido: dibujarRecorrido ?? this.dibujarRecorrido,
      follow: follow ?? this.follow,
      polylines: polylines ?? this.polylines,
      markets: markets ?? this.markets
    );
  }
}
