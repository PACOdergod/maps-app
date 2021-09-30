import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mapa_app/blocs/busqueda/busqueda_bloc.dart';
import 'package:mapa_app/widgets/location_buttons.dart';
import 'package:mapa_app/widgets/marcador_manual.dart';
import 'package:mapa_app/widgets/searchbar.dart';

class Marcadores extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        if (state.seleccionManual) return MarcadorManual();
        else return _macadorAutomatico(context);
      },
    );
  }

  Container _macadorAutomatico(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Searchbar(),
          Positioned(right: 20, bottom: 20, child: LocationButtons())
        ],
      ),
    );
  }
}