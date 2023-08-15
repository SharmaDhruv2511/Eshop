import 'package:shoppingapp/consts/consts.dart';

Widget bgWidget(Widget? child){
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(image: AssetImage(), fit: BoxFit.fill),
    ),
    child: child,
  );
}