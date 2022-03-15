
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadFile extends StatefulWidget {
  const DownloadFile({Key? key}) : super(key: key);

  @override
  _DownloadFileState createState() => _DownloadFileState();
}

class _DownloadFileState extends State<DownloadFile> {


  @override
  void initState() {
    super.initState();

    getPermission ();
    
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Download"),
      ),
      body: Center(
        child: TextButton(
            onPressed: () {
          
            
            },
            child: Text("Press here..")),
      ),
    );
  }


  void getPermission () async{

    print("get permission");

    // await Permission.storage.status;

      var status = await Permission.storage.status;
           if (status.isGranted) {
                // You can request multiple permissions at once.
                Map<Permission, PermissionStatus> statuses = await [
                  Permission.storage,
         
                ].request();
                print(statuses[Permission.storage]); // it should print PermissionStatus.granted
              }



  }


}
