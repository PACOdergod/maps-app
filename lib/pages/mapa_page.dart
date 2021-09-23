import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapa_app/blocs/ubication/ubication_bloc.dart';


class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {

  @override
  void initState() {
    BlocProvider.of<UbicationBloc>(context).iniciarSeguimiento();
    super.initState();
  }

  @override
  void dispose() {
    BlocProvider.of<UbicationBloc>(context).cancelarSeguimiento();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UbicationBloc, UbicationState>(
        builder: (context, state)=> coordenadas(state)
      )
    );
  }
}

coordenadas( UbicationState state ){
  if ( state.ubicacion == null ) return Center(
    child: Text('Calculando'),
  );

  // else return Center(
  //   child: Text(
  //     '${state.ubicacion?.latitude}, ${state.ubicacion?.longitude}',
  //     style: TextStyle( fontSize: 20 ),
  //   ),
  // );

  final _camaraPosition = new CameraPosition(
    target: state.ubicacion!,
    zoom: 15
  );

  return GoogleMap(
    initialCameraPosition: _camaraPosition,
    compassEnabled: true,
    myLocationEnabled: true,
    myLocationButtonEnabled: true,
  );
}