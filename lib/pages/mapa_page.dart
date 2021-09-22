import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
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
        builder: (context, state) {
          return Center(
            child: Text(
              '${state.ubicacion?.latitude}, ${state.ubicacion?.longitude}',
              style: TextStyle( fontSize: 20 ),
            ),
          );
        },
      )
    );
  }
}