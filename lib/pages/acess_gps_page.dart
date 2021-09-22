import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:open_settings/open_settings.dart';
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
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if( state == AppLifecycleState.resumed ){
      var res = await checkGPSAndLocation();
      if ( res == 'listo' ) {
        Navigator.pushReplacementNamed(context, 'loading');
      }

      else setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: FutureBuilder(
          future: checkGPSAndLocation(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {

            if ( snapshot.data == 'activarGPS') return _activarGPS();

            if ( snapshot.data == 'permisoGPS' ) return _accesoGPS();

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Future<String> checkGPSAndLocation() async {
      final permisoGPS = await Permission.location.isGranted;
      final gpsActivo = await Geolocator.isLocationServiceEnabled();
      
      if ( !permisoGPS ) return 'permisoGPS';
      if ( !gpsActivo ) return 'activarGPS';
      else return 'listo';
  }

}

Widget _activarGPS()=> Access(
  text: 'Debe activar el GPS',
  buttonText: 'Activar GPS',
  onPress: ()=> OpenSettings.openLocationSourceSetting()
);


Widget _accesoGPS()=> Access(
  text: 'Debe dar permisos para usar el GPS', 
  buttonText: 'Solicitar acceso', 
  onPress: ()=> openAppSettings()
);


class Access extends StatelessWidget {
  const Access({
    Key? key, 
    required this.text, 
    required this.buttonText, 
    required this.onPress
  }) : super(key: key);

  final String text;
  final String buttonText;
  final void Function() onPress;


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[

          Text( this.text,
            textAlign: TextAlign.center,
            style: TextStyle( color: Colors.black, fontSize: 19 ),
          ),

          SizedBox(height: 10),

          AccesButton(
            text: this.buttonText,
            onPress: this.onPress
          ),

        ],
      )
    );
  }
}

class AccesButton extends StatelessWidget {
  const AccesButton({
    Key? key, 
    required this.text, 
    required this.onPress,
  }) : super(key: key);

  final String text;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text( this.text, 
        style: TextStyle( color: Colors.white, fontSize: 15 ),
      ),
      color: Colors.black,
      shape: StadiumBorder(),
      elevation: 0,
      splashColor: Colors.transparent,
      onPressed: this.onPress
    );
  }
}