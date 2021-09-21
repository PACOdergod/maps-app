import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_settings/open_settings.dart';

import 'package:mapa_app/helpers/helpers.dart';
import 'package:mapa_app/pages/acess_gps_page.dart';
import 'package:mapa_app/pages/mapa_page.dart';


class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> 
  with WidgetsBindingObserver
{

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if( state == AppLifecycleState.resumed ){
      var isActive = await Geolocator.isLocationServiceEnabled();
      
      if ( isActive ) {
        Navigator.pushReplacement(context, navegarFadeIN(context, MapaPage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: this.chackGPSAndLocation(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {

          return Center(
            child: snapshot.hasData
            ? Column(
              children: [
                Text(snapshot.data, style: TextStyle(fontSize: 20) ),
                MaterialButton(
                  child: Text('Solicitar acceso', 
                    style: TextStyle( color: Colors.white, fontSize: 19 ),
                  ),
                  color: Colors.black,
                  shape: StadiumBorder(),
                  elevation: 0,
                  splashColor: Colors.transparent,
                  onPressed: () {
                    OpenSettings.openLocationSourceSetting();
                  }
                ),
              ],
            )
            : CircularProgressIndicator( strokeWidth: 4 ),
          );

        },
      ),
    );
  }

  Future chackGPSAndLocation(BuildContext context) async {
    // permiso de gps
    final permisoGPS = await Permission.location.isGranted;
    // gps esta cativo?
    final gpsActivo = await Geolocator.isLocationServiceEnabled();
    

    if ( permisoGPS && gpsActivo ) {
      Navigator.pushReplacement(context, navegarFadeIN(context, MapaPage()));
      return '';
    }
    if ( !permisoGPS ) {
      Navigator.pushReplacement(context, navegarFadeIN(context, AccessGPSPage()));
      return 'Es necesario el permiso del gps';
    }
    if ( !gpsActivo ){
      //* enviar el ususario a la pagina para activar el gps
      return 'Debe activar el gps';
    }

  }

}