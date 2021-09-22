import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:mapa_app/helpers/helpers.dart';
import 'package:mapa_app/pages/access_gps_page.dart';
import 'package:mapa_app/pages/mapa_page.dart';


class LoadingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: this.chackGPSAndLocation(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {

          return Center(
            child: CircularProgressIndicator( strokeWidth: 4 ),
          );

        },
      ),
    );
  }


  Future chackGPSAndLocation(BuildContext context) async {
    final permisoGPS = await Permission.location.isGranted;
    final gpsActivo = await Geolocator.isLocationServiceEnabled();
    

    if ( permisoGPS && gpsActivo ) {
      Navigator.pushReplacement(context, navegarFadeIN(context, MapaPage()));
    } 
    else {
      Navigator.pushReplacement(context, navegarFadeIN(context, AccessGPSPage()));
    }
  }
  
}