import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapa_app/blocs/busqueda/busqueda_bloc.dart';
import 'package:mapa_app/models/search_result.dart';
import 'package:mapa_app/search/search_destino.dart';

class Searchbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(horizontal: 30,),

        child: GestureDetector(
          onTap: () async {
            final result = await showSearch<SearchResult>(
              context: context, delegate: SearchDestino());
            retornoBusquedo(result, context);
          },
          child: Container(
            width: double.infinity,
            child: Text('donde quieres ir', style: TextStyle(fontSize:20)),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12, blurRadius: 5,offset: Offset(0, 8)
                )
              ]
            ),
          ),
        ),
      ),
    );
  }

  void retornoBusquedo( SearchResult? result, BuildContext context ){
    if ( result == null ) return;
    if ( result.cancelo ) return;
    if ( result.manual == null ) return;
    if ( result.manual! ){
      BlocProvider.of<BusquedaBloc>(context).add(OnActivarMarcadorManual());
      return;
    }
  }
}