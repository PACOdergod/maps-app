import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapa_app/blocs/mapa/mapa_bloc.dart';
import 'package:mapa_app/blocs/ubication/ubication_bloc.dart';

class BtnUbication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final mapaBloc = BlocProvider.of<MapaBloc>(context);
    final ubicacionBloc = BlocProvider.of<UbicationBloc>(context);

    return Container(
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(Icons.my_location, color: Colors.black,),
          onPressed: (){
            final destino = ubicacionBloc.state.ubicacion;

            mapaBloc.moverCamara( destino! );
          },
        ),
      ),      
    );

  }
}