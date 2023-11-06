import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class SavedFileLocation extends StatelessWidget {
  final List<String>? paths;
  final List<Uint8List>? imageBytes;

  const SavedFileLocation({Key? key, @required this.paths, @required this.imageBytes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: ListView.builder(
       itemCount: paths!.length,
       itemBuilder: (context,index){
         return  Padding(
           padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
           child: Row(
             children: [
               Image.memory(
                 imageBytes![index],
                 height: 100,
                 width: 100,
                 fit: BoxFit.cover,
               ),
               const SizedBox(width: 10,),
               Expanded(child: Text('Image Location : Internal Storage/Pictures/${paths![index]}'))
             ],
           ),
         );
       },
      )
    );
  }
}
