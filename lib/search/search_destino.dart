import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapa_app/blocs/busqueda/busqueda_bloc.dart';

import 'package:mapa_app/blocs/ubication/ubication_bloc.dart';
import 'package:mapa_app/models/search_response.dart';
import 'package:mapa_app/models/search_result.dart';
import 'package:mapa_app/services/trafic_service.dart';

class SearchDestino extends SearchDelegate<SearchResult>{

  final _trafficService = new TraficService();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: ()=> this.query = ''
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    final result = SearchResult(cancelo: true);

    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: ()=> this.close(context, result)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _constuirSugerencias(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    final busquedas = BlocProvider.of<BusquedaBloc>(context).state.busquedas;

    if ( this.query.length == 0) return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.location_on),
          title: Text('Colocar ubicacion manualmente'),
          onTap: ()=>  this.close(context, SearchResult(
            cancelo: false,
            manual: true
          )),
        ),

        ...busquedas.map(( b ) => ListTile(
          leading: Icon( Icons.history ),
          title: Text( b.nombreDestino.toString() ),
          subtitle: Text( b.descripcion.toString() ),
          onTap: (){ 
            this.close(context, b.copyWith( agregarBusqueda: false )); 
          },
        ))

      ],
    );

    else return _constuirSugerencias(context);
  }

  Widget _constuirSugerencias( BuildContext context ){

    if ( this.query.length == 0 ) return Container();

    final location = BlocProvider.of<UbicationBloc>(context).state.ubicacion;

    this._trafficService.getSugerenciasPorQuery(this.query.trim(), location!);
    
    return StreamBuilder(
      stream: this._trafficService.sugerenciasStream,
      builder: (BuildContext context, AsyncSnapshot<SearchResponse> snapshot) {
        
        if ( !snapshot.hasData ) return Center(child: CircularProgressIndicator());

        final lugares = snapshot.data?.features;

        if ( lugares == null ) return Container();
        //todo que pasa cuando lugares esta basio

        return ListView.separated(
          itemCount: lugares.length,
          separatorBuilder: (_, i)=> Divider(), 
          itemBuilder: (_, i){

            final lugar = lugares[i];
            return ListTile(
              leading: Icon(Icons.place),
              title: Text( lugar.textEs! ),
              subtitle: Text( lugar.placeNameEs! ),
              onTap: (){
                this.close(context, SearchResult(
                  cancelo: false,
                  manual: false,
                  destino: LatLng( lugar.center![1], lugar.center![0] ),
                  nombreDestino: lugar.placeNameEs
                ));
              },
            );
          },
        );
      }
    );
  }

}