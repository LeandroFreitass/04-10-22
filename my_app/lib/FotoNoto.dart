import 'package:flutter/material.dart';
import 'dart:io';
import 'package:camera/camera.dart';


class FotoNot extends StatefulWidget {
  const FotoNot({ Key? key }) : super(key: key);

  @override
  _FotoNotState createState() => _FotoNotState();
}

class _FotoNotState extends State<FotoNot> {
 List<CameraDescription>? cameras;
 CameraController? controller;
 XFile? image;
 String imagePath = "";

 loadCamera() async {
   cameras = await availableCameras();
   if (cameras != null){
     controller = CameraController(cameras! [0], ResolutionPreset.max);

     controller!.initialize().then((_)  {
       if (!mounted){
         return;
       }
       setState(() {});
     });
   }else{
     print('Nao foi encontrado camera');
   }
 }

 @override
 void initState() {
   loadCamera();
   super.initState();
 }
 @override
 void dispose() {
   controller?.dispose();
   super.dispose();
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tirando Foto")),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(children: [
          ElevatedButton.icon(onPressed: () async {
            try{
              final image = await controller!.takePicture();
            } catch (e) {
              print(e);
            }
          }, 
          icon: const Icon(Icons.photo_camera), 
          label: const Text("Tirar foto"), 
          style: ElevatedButton.styleFrom(),
          ),
          if (imagePath != "")
          Container(
            width: 300, height: 300,
            child: Image.file(File(imagePath))
          )
        ]),
      )  ,
    );
  }
}