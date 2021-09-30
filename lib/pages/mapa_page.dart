import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:mapa_app/blocs/mapa/mapa_bloc.dart';
import 'package:mapa_app/blocs/ubication/ubication_bloc.dart';
import 'package:mapa_app/widgets/marcadores.dart';

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
        builder: (context, state) {
          if (state.ubicacion == null)
            return Center(
              child: Text('Calculando'),
            );

          final _camaraPosition =
              new CameraPosition(target: state.ubicacion!, zoom: 15);

          final mapaBloc = BlocProvider.of<MapaBloc>(context);

          mapaBloc.add(OnLocationUpdate(state.ubicacion!));

          return Stack(
            children: [

              BlocBuilder<MapaBloc, MapaState>(
                builder: (context, state) {
                  return GoogleMap(
                    initialCameraPosition: _camaraPosition,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                    myLocationEnabled: true,
                    onMapCreated: mapaBloc.initMap,
                    polylines: mapaBloc.state.polylines.values.toSet(),
                    onCameraMove: (cameraPosition) {
                      mapaBloc.posicionCentral = cameraPosition.target;
                    },
                  );
                },
              ),

              Marcadores()
            ],
          );
        },
      ),
    );
  }
}
