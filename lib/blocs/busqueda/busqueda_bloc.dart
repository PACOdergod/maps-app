import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:mapa_app/models/search_result.dart';

part 'busqueda_event.dart';
part 'busqueda_state.dart';

class BusquedaBloc extends Bloc<BusquedaEvent, BusquedaState> {
  BusquedaBloc() : super(BusquedaState()) {
    on<BusquedaEvent>((event, emit){

      if ( event is OnActivarMarcadorManual ) {
        emit( state.copyWith(seleccionManual: true) );
      }

      if ( event is OnDesactivarMarcadorManual ) {
        emit( state.copyWith(seleccionManual: false) );
      }

      if ( event is OnAgregarBusqueda ){
        final newBusquedas = [ ...state.busquedas, event.busqueda ];
        emit( state.copyWith( busquedas: newBusquedas ) );
      }
    });
  }
}
