import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';


class AccessGPSPage extends StatefulWidget {
  @override
  _AccessGPSPageState createState() => _AccessGPSPageState();
}

class _AccessGPSPageState extends State<AccessGPSPage> 
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
  void didChangeAppLifecycleState(AppLifecycleState state)async {
    if( state == AppLifecycleState.resumed ){
      if ( await Permission.location.isGranted ) {
        Navigator.pushReplacementNamed(context, 'loading');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[

            Text('Es necesario el GPS para usar esta app',
              style: TextStyle( color: Colors.black, fontSize: 18 ),
            ),

            SizedBox(height: 10),

            MaterialButton(
              child: Text('Solicitar acceso', 
                style: TextStyle( color: Colors.white, fontSize: 19 ),
              ),
              color: Colors.black,
              shape: StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent,
              onPressed: () async {
                final status = await Permission.location.request();
                this.accesoGPS(status);
              }
            ),

          ],
        )
      ),
    );
  }

  void accesoGPS( PermissionStatus status){

    switch( status ){
      
      case PermissionStatus.granted:
        Navigator.pushReplacementNamed(context, 'mapa');
        break;
      
      case PermissionStatus.limited:
      case PermissionStatus.restricted:
      case PermissionStatus.denied:
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
        break;
    }
  }
}