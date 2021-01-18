import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_loja_ultimo/screens/edit_product/components/image_source_sheet.dart';

class AddTileWidget extends StatelessWidget {
  void onImageSelected(File file){

  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(aspectRatio: 1,child: GestureDetector(
      onTap: (){
        if(Platform.isAndroid){
          showModalBottomSheet(context: context, builder: (context) =>
            ImageSourceSheet(onImageSelected: onImageSelected,)
          );
        }else{
          showModalBottomSheet(context: context, builder: (context) =>
            ImageSourceSheet(onImageSelected: onImageSelected,)
          );
        }
      },
      child: Container(
        color: Colors.white.withAlpha(100),
        child: Icon(Icons.add, color: Colors.white,),
      ),
    ),);
  }
}
