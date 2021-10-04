
part of 'busqueda_bloc.dart';

@immutable
class BusquedaState {
  final bool seleccionManual;
  final List<SearchResult> busquedas;

  BusquedaState({
    this.seleccionManual = false,
    List<SearchResult>? busquedas
  }) : this.busquedas = busquedas ?? [];

  BusquedaState copyWith({
    bool? seleccionManual,
    List<SearchResult>? busquedas,
  }) => 
  BusquedaState(
    seleccionManual: seleccionManual ?? this.seleccionManual,
    busquedas: busquedas ?? this.busquedas
  );
  
}
