import 'package:flutter/material.dart';
import 'package:hari/widget/progress.dart';

class LoadingDialog extends StatelessWidget {
final String?message;

  const LoadingDialog({this.message});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content:Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          circularProgress(),
        const  SizedBox(height: 10,),
          Text( message! +" , Please wait...")
        ],
      )
     
      // actions: [
      //   ElevatedButton(onPressed: (){
      //     Navigator.pop(context);
      //   }, child: Center(
      //     child: Text("Ok"),
      //   ),
      //   style: ElevatedButton.styleFrom(primary: Colors.red),
      //   )
      // ],
    );
  }
}