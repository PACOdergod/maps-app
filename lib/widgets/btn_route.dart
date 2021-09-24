import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mapa_app/blocs/mapa/mapa_bloc.dart';

class BtnRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final mapaBloc = BlocProvider.of<MapaBloc>(context);

    return Container(
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(Icons.more_horiz, color: Colors.black,),
          onPressed: (){
            mapaBloc.add( OnMarcarRecorrido() );
          },
        ),
      ),      
    );

  }
}