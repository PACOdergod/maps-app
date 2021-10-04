part of 'busqueda_bloc.dart';

@immutable
abstract class BusquedaEvent {}

class OnActivarMarcadorManual extends BusquedaEvent {}

class OnDesactivarMarcadorManual extends BusquedaEvent {}

class OnAgregarBusqueda extends BusquedaEvent {
  OnAgregarBusqueda(this.busqueda);
  final SearchResult busqueda;
}