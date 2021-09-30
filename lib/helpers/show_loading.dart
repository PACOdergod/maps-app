import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void showLoading( BuildContext context ){

  showDialog(
    context: context, 
    builder: ( context )=> Center(
      child: Container(
        height: 100,
        width: 100,
        child: CircularProgressIndicator(),
      ),
    )
  );
}