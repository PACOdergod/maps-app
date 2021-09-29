part of 'location_buttons.dart';

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