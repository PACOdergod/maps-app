import 'package:flutter/material.dart';
import 'package:mapa_app/models/search_result.dart';

class SearchDestino extends SearchDelegate<SearchResult>{
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
    return Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final result = SearchResult(
      cancelo: false,
      manual: true
    );

    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.location_on),
          title: Text('colocar ubicacion manualmente'),
          onTap: ()=> this.close(context, result),
        )
      ],
    );
  }

}