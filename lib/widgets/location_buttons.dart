import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:mapa_app/blocs/mapa/mapa_bloc.dart';
import 'package:mapa_app/blocs/ubication/ubication_bloc.dart';
import 'package:mapa_app/services/trafic_service.dart';


part 'btn_ubication.dart';
part 'btn_follow.dart';
part 'btn_route.dart';

class LocationButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        BtnUbication(),
        SizedBox(height: 10),
        BtnFollow(),
        SizedBox(height: 10),
        BtnRoute()
      ],
    );
  }
}