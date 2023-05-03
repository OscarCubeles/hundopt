import 'package:flutter/material.dart';

import '../constants/constants.dart';

class HorizontalBar extends StatelessWidget{
  const HorizontalBar({super.key});

  @override
  Widget build(BuildContext context) {
   return SizedBox(
     width: MediaQuery.of(context).size.width,
     height: 10,
     child: Stack(
       children: [
         Positioned(
             bottom: 5,
             child: Container(
               width: MediaQuery.of(context).size.width,
               color: Colors.black,
               height: 1,
             )),
         Positioned(
             height: 10,
             left: 20,
             child: Container(
               width: MediaQuery.of(context).size.width*0.4,
               height: 10,
               decoration: BoxDecoration(
                 color: ColorConstants.appColor,
                 borderRadius: BorderRadius.circular(10),
               ),
             )
         )],
     ),
   );
  }

}