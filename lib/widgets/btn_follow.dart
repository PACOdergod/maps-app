import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mapa_app/blocs/mapa/mapa_bloc.dart';

class BtnFollow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<MapaBloc, MapaState>(
      builder: (context, state) {
        return FollowAvatar();
      },
    );

  }
}

class FollowAvatar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final mapaBloc = BlocProvider.of<MapaBloc>(context);

    return CircleAvatar(
      backgroundColor: Colors.white,
      maxRadius: 25,
      child: IconButton(
        icon: Icon(
          mapaBloc.state.follow
            ? Icons.directions_run
            : Icons.accessibility_new, 
          color: Colors.black,
        ),
        onPressed: ()=> mapaBloc.add( Onfollow() ),
      ),
    );

  }
}