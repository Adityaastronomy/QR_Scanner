import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';
import 'dart:async';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: HomePage(),
));

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String result = "Hey There!";
  Future _scanQR() async{
    try{
      String qrResult = await FlutterBarcodeScanner.scanBarcode("#ff6666", "Cancel", false, ScanMode.DEFAULT);
      setState(() {
        result = qrResult;
      });
    }on PlatformException catch(ex){
      if(ex.code == 'PERMISSION_NOT_GRANTED'){
        setState(() {
          result =  "Camera Permission was denied";
        });
      }
      else
     {
      setState(() {
        result = "Unknown Error ! $ex";
      });
     }
    } on FormatException{
      result = "You Pressed The back Button before sannning anything ";
    } catch(ex){
      setState(() {
        result = "Unknown Error ! $ex";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Scanner"),
      ),
      body: Center(
        child: Text(result,style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: _scanQR, 
      icon: Icon(Icons.camera_alt_outlined),
      label: Text("Scan"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
    
  }
}
