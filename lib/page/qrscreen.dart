import 'package:email_signin_example/widget/logged_in_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class QRscreen extends StatefulWidget {
  @override
  _WeightChartState createState() => _WeightChartState();
}

class _WeightChartState extends State<QRscreen>  {
    User user = FirebaseAuth.instance.currentUser;

 void initState() {
      super.initState();
      _fetchUserData();
    }
    void _fetchUserData() async {
      FirebaseFirestore.instance.collection("users").doc(user.uid).snapshots().listen((snapshot) {
          setState(() {
              username = snapshot.data()["username"];
              faceb = snapshot.data()["facebook"];
              active = snapshot.data()["active"];
              
            });
       });  
  } 

  String username, faceb;
  bool active;


_launchURL() async {
  const url = 'https://360connect.io';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_showbottommodal(context){
    showModalBottomSheet(context: context, builder: (BuildContext context) {
      return Center(
        child: Column(
         children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
                child:Text(
  'Ready to Scan',
  textAlign: TextAlign.center,
  style: TextStyle(
      color: Colors.grey[800],
      fontWeight: FontWeight.bold,
      fontSize: 25)
        ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
                height: 100.0,
                width: 100.0,
                decoration: new BoxDecoration(
                    image: DecorationImage(
                        image: new AssetImage('assets/images/smartphone.png'),
                        fit: BoxFit.fill
                    ),
                ),
              ),
               Container(
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20),
                child:Text(
  'Hold a 360 connect to the middle back of your phone to view profile. Hold the 360 there untill the profile appears!',
  textAlign: TextAlign.center,
  style: TextStyle(
      fontFamily: 'Josefin Sans',
      color: Colors.grey[800],
      fontWeight: FontWeight.bold,
      fontSize: 20)
        ),
              ),
             const SizedBox(height: 20, width: 40),
          RaisedButton(
            color: Color(0xFF000000),
            textColor: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel', style: TextStyle(fontSize: 20)),
          ),
        ]
        ),
      );
      
    });
  }




  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> _signOut() async {
    await _auth.signOut();
  }

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile QR Code"),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children:  <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 100),
                child:Text(
  'Scan this code with any camera to share your 360 connect profile',
  textAlign: TextAlign.center,
  style: TextStyle(
      color: Colors.grey[800],
      fontWeight: FontWeight.bold,
      fontSize: 20)
        ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 50, top: 250),
                child: QrImage(
                data:  "https://facebook.com/"+ faceb,
                version: QrVersions.auto,
                size: 300.0
                ),
              ),  
        ]
      ),
      drawer: Drawer(
        child: Container(
          
child: ListView(
    // Important: Remove any padding from the ListView.
    padding: EdgeInsets.zero,
    children: <Widget>[
        DrawerHeader(
              child: Image.asset('assets/images/logo1.png',
              height: 100,
              )
              ),
           
      ListTile(
        leading: const Icon(Icons.home),                            
        title: Text('Home'),
        
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoggedInWidget()));
        },
      ),
      ListTile(
        leading: const Icon(Icons.person),
        title: Text('Edit Profile'),
        onTap: () {
        
        },
      ),
      ListTile(
        leading: const Icon(Icons.satellite),
        title: Text('Activate 360'),
        onTap: () {
          Navigator.pop(context);
          _showbottommodal(context);
          
        },
      ),
      ListTile(
        leading: const Icon(Icons.phone_android),
        title: Text('Read 360'),
        onTap: () {
          Navigator.pop(context);
          _showbottommodal(context);
        },
      ),
      ListTile(
        leading: const Icon(Icons.phone_android),
        title: Text('Buy 360'),
        onTap: () {
          Navigator.pop(context);
          _launchURL();
        },
      ),
      ListTile(
        leading: const Icon(Icons.phone_android),
        title: Text('Signout'),
        onTap: () {
          _signOut();
        },
      ),
    ],
  ),

        )
 
  
)

    );
  }
}
