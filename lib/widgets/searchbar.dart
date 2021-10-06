import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapa_app/blocs/mapa/mapa_bloc.dart';
import 'package:mapa_app/helpers/show_loading.dart';

import 'package:polyline_do/polyline_do.dart' as Poly;

import 'package:mapa_app/blocs/busqueda/busqueda_bloc.dart';
import 'package:mapa_app/blocs/ubication/ubication_bloc.dart';
import 'package:mapa_app/models/search_result.dart';
import 'package:mapa_app/search/search_destino.dart';
import 'package:mapa_app/services/trafic_service.dart';

class Searchbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(horizontal: 30,),

        child: GestureDetector(
          onTap: () async {
            final result = await showSearch<SearchResult>(
              context: context, 
              delegate: SearchDestino(),
            );
            retornoBusquedo(result, context);
          },
          child: Container(
            width: double.infinity,
            child: Text('donde quieres ir', style: TextStyle(fontSize:20)),
            alignment: Alignment.center,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12, blurRadius: 5,offset: Offset(0, 8)
                )
              ]
            ),
          ),
        ),
      ),
    );
  }

  void retornoBusquedo( SearchResult? result, BuildContext context ) async {
    if ( result == null ) return;
    if ( result.cancelo ) return;
    if ( result.manual == null ) return;
    if ( result.manual! ){
      BlocProvider.of<BusquedaBloc>(context).add(OnActivarMarcadorManual());
      return;
    }

    // calcular la ruta cuando el result tenfa un destino
    if ( result.destino != null ) {

      showLoading(context);

      final inicio = BlocProvider.of<UbicationBloc>(context).state.ubicacion;
      final destino = result.destino;

      final drivingResponse = await TraficService()
                              .getCoordsInicioFin(inicio!, destino!);

      final geometry = drivingResponse.routes[0].geometry;
      final duration = drivingResponse.routes[0].duration;
      final distance = drivingResponse.routes[0].distance;

      final points = Poly.Polyline.Decode(encodedString: geometry, precision: 6);

      final List<LatLng> coordenadas = points.decodedCoords.map(
        (p) => LatLng(p.first, p.last) 
      ).toList();

      BlocProvider.of<MapaBloc>(context).add( OnCrearRuta(
        coordenadas: coordenadas, distancia: distance, duracion: duration
      ));

      Navigator.pop(context);


      // agregar el historial
      if ( result.agregarBusqueda )
      BlocProvider.of<BusquedaBloc>(context).add( OnAgregarBusqueda( result ));
    }
  }
}