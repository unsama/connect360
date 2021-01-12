import 'package:email_signin_example/page/editprofile.dart';
import 'package:email_signin_example/page/qrscreen.dart';
import 'package:email_signin_example/provider/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoggedInWidget extends StatefulWidget {
  @override
  _WeightChartState createState() => _WeightChartState();
}

class _WeightChartState extends State<LoggedInWidget>  {
  final user = FirebaseAuth.instance.currentUser;

  bool _hasBeenPressed = false;
  bool active;
  num count = 3;

 

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



  void initState() {
      super.initState();
      _fetchUserData();
    }
    void _fetchUserData() async {
      FirebaseFirestore.instance.collection("users").doc(user.uid).snapshots().listen((snapshot) {
          setState(() {
              name = snapshot.data()["profilename"];
              avatar = snapshot.data()["avatar"];
              active = snapshot.data()["active"];
              bio = snapshot.data()["bio"];
              username = snapshot.data()["username"];
              fb = snapshot.data()["facebook"];
              instagram = snapshot.data()["instagram"];
              sn = snapshot.data()["snapchat"];
              li = snapshot.data()["linkedin"];
              yt = snapshot.data()["youtube"];
              tw = snapshot.data()["twitter"];
              tt = snapshot.data()["ticktok"];
              sound = snapshot.data()["soundcloud"];
              spot = snapshot.data()["spotify"];
              pn = snapshot.data()["pn"];
              paypal = snapshot.data()["paypal"];
              link = snapshot.data()["link"];
              em = snapshot.data()["em"];
              twitch = snapshot.data()["twitch"];
              apple = snapshot.data()["apple"];
              website = snapshot.data()["website"];
              venmo = snapshot.data()["venmo"];
              cash = snapshot.data()["cash"];
              whatsapp = snapshot.data()["whatsapp"];
              map = snapshot.data()["map"];
            });
       });  
  } 

   String avatar,sound, name, bio, username, fb, instagram, sn, tw, li, em, yt, spot, paypal, link, pn, tt, sc, twitch,
   apple, website, venmo, cash, whatsapp, map; 

  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    

Future<void> _signOut() async {
    await _auth.signOut();
  }

//   FirebaseFirestore.instance.collection("users").doc(user.uid).snapshots().listen((snapshot) {
//   print(snapshot.data());
//    name = snapshot.data()['profilename'];
// });
 
  // FirebaseFirestore.instance
  //   .collection('users').doc(user.uid).get()
  //   .then((DocumentSnapshot documentSnapshot) {
  //     if (documentSnapshot.exists) {
        
  //       bio = documentSnapshot.data()['bio'];
  //       username = documentSnapshot.data()['username'];
  //       fb = documentSnapshot.data()['facebook'];
  //       instagram = documentSnapshot.data()['instagram'];
  //       sn = documentSnapshot.data()['snapchat'];
  //       li = documentSnapshot.data()['linkedin'];
  //       yt = documentSnapshot.data()['youtube'];
  //       tw = documentSnapshot.data()['twitter'];
  //       tt = documentSnapshot.data()['ticktok'];
  //       spot = documentSnapshot.data()['spotify'];
  //       pn = documentSnapshot.data()['pn'];
  //       paypal = documentSnapshot.data()['paypal'];
  //       link = documentSnapshot.data()['link'];
  //       em = documentSnapshot.data()['em'];
        
  //       print('Document data: ${documentSnapshot.data()['profilename']}');
  //     } else {
  //       print('Document does not exist on the database');
  //     }
  //   });

        return Scaffold(
          appBar: AppBar(
            title: Text("Profile"),
            backgroundColor: Colors.black,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.developer_board, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QRscreen()));
                },
              ),
            ],
          ),
          body: Stack(
            children: <Widget>[
              Container(
                  margin: const EdgeInsets.only(left: 58.0, top: 53),
                  width: 88.0,
                  height: 98.0,
                  child: CircleAvatar(
                    backgroundColor: Color(0xff000000),
                    radius: 100,
                    child: ClipOval(
                            child: new SizedBox(
                              width: 98.0,
                              height: 98.0,
                               child: (avatar != null)?Image.network(
                                avatar,
                                fit: BoxFit.fill,
                              ):Image.network(
                                "https://360connect.io/wp-content/uploads/2020/11/place.jpg",
                                fit: BoxFit.fill,
                              ),
                            )
                     )
                  )
              ),
              Container(
                margin: const EdgeInsets.only(left: 164.0, top: 56),
                child: Text(
                   (name  != null)? name
              :"Profile name",
              style: TextStyle(
                fontFamily: 'Josefin Sans',
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w600,
                height: 0.95,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 164.0, top: 86),
            child: Text(
              (bio != null)?bio
              :"360 connect",
              style: TextStyle(
                fontFamily: 'Josefin Sans',
                fontSize: 11,
                color: Colors.black,
                height: 1.2727272727272727,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
             margin: const EdgeInsets.only(left: 155.2, top: 139),
            child: SizedBox(
              width: 156.0,
              child: Text(
                'Connect Count: 234',
                style: TextStyle(
                  fontFamily: 'Josefin Sans',
                  fontSize: 13,
                  color: Colors.black,
                  height: 0.6923076923076923,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
             margin: const EdgeInsets.only(left: 68, top: 169),
            child: SizedBox(
              width: 250.0,
              height: 50.0,
              child: Text(
                (username != null)?"Your 360 Connect profile link: https://profile.360connect.io/index/"+ username:
                "Your 360 Connect profile link: https://360connect.io/example",
                style: TextStyle(
                  fontFamily: 'Josefin Sans',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(left: 58.0, top: 227.0),
              child: SizedBox(
              width: 127.0,
              height: 41.0,
              child: RaisedButton(
              color: (active == true ) ? Colors.green : Colors.black,
              textColor: Colors.white,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.black,
              onPressed: () {
                setState(() {
                  _hasBeenPressed = !_hasBeenPressed;
                  FirebaseFirestore.instance.collection("users").doc(user.uid)
                      .update({
                            'active': _hasBeenPressed,
                            'updatedAt': FieldValue.serverTimestamp()
                            }).then((result){
                              print("new USer true");
                            }).catchError((onError){
                            print("onError");
                            }); 
                });
                },
              child: Text(
                (active == true ) ? "Active: On" : "Active: Off",
              style: TextStyle(fontSize: 20.0),
                ),
              )
            ),
          ),
          Container(
              margin: const EdgeInsets.only(left: 200.0, top: 227.0),              
              child: SizedBox(
              width: 127.0,
              height: 41.0,
              child: RaisedButton(
              color: Colors.black,
              textColor: Colors.white,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.black,
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => MyApp()));
                  },
              child: Text(
                    "Edit Profile",
              style: TextStyle(fontSize: 20.0),
                 ),
              )
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 30.0, top: 283, right: 30.0,),
        //     child: GridView.builder(
        //     itemCount: images.length,
        //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
        //     itemBuilder: (BuildContext context, int index){
        //       return Image.network(images[index]);
        //     },
        // ),

          child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          children: <Widget>[
            if(fb != "" && fb != null) Image.asset('assets/images/fb.png'),
            if(instagram != "" && instagram != null) Image.asset('assets/images/IG.png'),
            if(sn != "" && sn != null) Image.asset('assets/images/SC.png'),
            if(li != "" && li != null) Image.asset('assets/images/link32.png'),
            if(paypal != "" && paypal != null) Image.asset('assets/images/pp.png'),
            if(em != "" && em != null) Image.asset('assets/images/Mail.png'),
            if(link != "" && link != null) Image.asset('assets/images/Link.png'),
            if(pn != "" && pn != null) Image.asset('assets/images/Messages.png'),
            if(spot != "" && spot != null) Image.asset('assets/images/Spotify.png'),
            if(tt != "" && tt != null) Image.asset('assets/images/Tiktrr.png'),
            if(tw != "" && tw != null) Image.asset('assets/images/TW54.png'),
            if(yt != "" && yt != null) Image.asset('assets/images/YT.png'),
            if(sound != "" && sound != null) Image.asset('assets/images/SCL.png'),
            if(twitch != "" && twitch != null) Image.asset('assets/images/TWT.png'),
            if(apple != "" && apple != null) Image.asset('assets/images/itune.png'),
            if(website != "" && website != null) Image.asset('assets/images/Safari.png'),
            if(whatsapp != "" && whatsapp != null) Image.asset('assets/images/WT.png'),
            if(map != "" && map != null) Image.asset('assets/images/Map.png'),
            if(venmo != "" && venmo != null) Image.asset('assets/images/Ve.png'),
            if(cash != "" && cash != null) Image.asset('assets/images/Money.png'),
          ],
        ),
          )
          // Container(
          //     margin: const EdgeInsets.only(left: 58.0, top: 283),
          //     width: 127.0,
          //     height: 127.0,
          //     decoration: BoxDecoration(
          //       image: DecorationImage(
          //         image: const AssetImage('assets/images/fb.png'),
          //         fit: BoxFit.cover,
          //       ),
                
          //       boxShadow: [
          //         BoxShadow(
          //           color: const Color(0x0d000000),
          //           offset: Offset(0, 10),
          //           blurRadius: 99,
          //         ),
          //       ],
          //     ),
          // ),
          // Container(
          //     margin: const EdgeInsets.only(left: 200.0, top: 283),
          //     width: 127.0,
          //     height: 127.0,
          //     decoration: BoxDecoration(
          //       image: DecorationImage(
          //         image: const AssetImage('assets/images/plus.png'),
          //         fit: BoxFit.cover,
          //       ),
                
          //       boxShadow: [
          //         BoxShadow(
          //           color: const Color(0x0d000000),
          //           offset: Offset(0, 10),
          //           blurRadius: 99,
          //         ),
          //       ],
          //     ),
          // ),
         
        ],
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
          // Update the state of the app.
          // ...
          Navigator.pop(context);
        },
      ),
      ListTile(
        leading: const Icon(Icons.person),
        title: Text('Edit Profile'),
        onTap: () {
        Navigator.push(context,MaterialPageRoute(builder: (context) => MyApp()));
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

