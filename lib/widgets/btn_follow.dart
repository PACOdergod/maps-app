part of 'location_buttons.dart';

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
        onPressed: () {
          final location = BlocProvider.of<UbicationBloc>(context).state.ubicacion;
          TraficService().getSearchResult('san francisco', location??LatLng(0, 0));
          // mapaBloc.add( Onfollow() );
        },
      ),
    );

  }
}