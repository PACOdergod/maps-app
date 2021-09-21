part of 'helpers.dart';


Route navegarFadeIN(BuildContext context, Widget page){
  return PageRouteBuilder(
    pageBuilder: ( context, animation, secondaryAnimation)=>page,
    transitionDuration: Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child){
      return FadeTransition(
        child: page,
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeOut)
        )
      );
    }
  );
}