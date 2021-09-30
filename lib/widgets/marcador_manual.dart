
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapa_app/blocs/busqueda/busqueda_bloc.dart';
import 'package:mapa_app/blocs/mapa/mapa_bloc.dart';

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
              onPressed: (){
                final bloc = BlocProvider.of<MapaBloc>(context);
                
              }
            ),
          ),
        )
      ],
    );
  }
}