
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapa_app/helpers/show_loading.dart';

import 'package:polyline_do/polyline_do.dart' as Poly;

import 'package:mapa_app/blocs/busqueda/busqueda_bloc.dart';
import 'package:mapa_app/blocs/mapa/mapa_bloc.dart';
import 'package:mapa_app/blocs/ubication/ubication_bloc.dart';
import 'package:mapa_app/services/trafic_service.dart';

class MarcadorManual extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        Positioned(
          bottom: 40,
          left: 20,
          child: CircleAvatar(
            backgroundColor: Colors.black,
            maxRadius: 25,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: (){
                BlocProvider.of<BusquedaBloc>(context)
                  .add( OnDesactivarMarcadorManual() );
              }
            ),
          ),
        ),

        Center(child: Transform.translate(
          offset: Offset(0, -20), 
          child: Icon(Icons.location_on, size: 50,)
        )),

        Positioned(
          bottom: 100,
          left: 20,
          child: CircleAvatar(
            backgroundColor: Colors.black,
            maxRadius: 25,
            child: IconButton(
              icon: Icon(Icons.check, color: Colors.white),
              onPressed: (){ calcularDestino(context); }
            ),
          ),
        )
      ],
    );
  }

  calcularDestino( BuildContext context ) async {
    final inicio = BlocProvider.of<UbicationBloc>(context).state.ubicacion;
    final fin = BlocProvider.of<MapaBloc>(context).posicionCentral;
    if ( inicio == null || fin == null) return;

    showLoading(context);

    final drivingResp = await TraficService().getCoordsInicioFin(inicio, fin);

    final geometry = drivingResp.routes[0].geometry;
    final duration = drivingResp.routes[0].duration;
    final distance = drivingResp.routes[0].distance;

    final points = Poly.Polyline.Decode(
      encodedString: geometry, 
      precision: 6
    ).decodedCoords;

    final List<LatLng> coords = points.map(
      (p) => LatLng(p.first, p.last)
    ).toList();

    BlocProvider.of<MapaBloc>(context).add( OnCrearRuta(
      coordenadas: coords,
      distancia: distance,
      duracion: duration
    ));

    BlocProvider.of<BusquedaBloc>(context).add(OnDesactivarMarcadorManual());
    Navigator.of(context).pop();
  }

}