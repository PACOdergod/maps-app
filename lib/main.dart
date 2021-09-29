import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapa_app/blocs/busqueda/busqueda_bloc.dart';
import 'package:mapa_app/blocs/mapa/mapa_bloc.dart';
import 'package:mapa_app/blocs/ubication/ubication_bloc.dart';
import 'package:mapa_app/pages/access_gps_page.dart';
import 'package:mapa_app/pages/loading_page.dart';
import 'package:mapa_app/pages/mapa_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=> UbicationBloc()),
        BlocProvider(create: (_)=> MapaBloc()),
        BlocProvider(create: (_)=> BusquedaBloc())
      ],

      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        home: LoadingPage(),
        routes: {
          'mapa': (_) => MapaPage(),
          'loading': (_) => LoadingPage(),
          'acces-gps': (_) => AccessGPSPage(),
        },
      ),
      
    );
  }
}

// pk.eyJ1IjoicGFjb2Rlcmdvc2giLCJhIjoiY2t1NG1lemRjNHNkbDJ4cG1mem5obDZ4MyJ9.2r0aWVJE9-KU7mdKqX4Vhg