import 'dart:io';

import 'package:email_signin_example/widget/logged_in_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flat_icons_flutter/flat_icons_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final databaseReference = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  // ignore: unused_field
  File _image;
  final picker = ImagePicker();


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

    final proname = TextEditingController();
    final biod = TextEditingController();
    final faceb = TextEditingController();
    final instag = TextEditingController();
    final snap = TextEditingController();
    final tweet = TextEditingController();
    final linkedin = TextEditingController();
    final email = TextEditingController();
    final youtube = TextEditingController();
    final phonenum = TextEditingController();
    final ticktok = TextEditingController();
    final sound = TextEditingController();
    final anylink = TextEditingController();
    final spoty = TextEditingController();
    final paypa = TextEditingController();
    final username = TextEditingController();
    final twitch = TextEditingController();
    final apple = TextEditingController();
    final website = TextEditingController();
    final venmo = TextEditingController();
    final cash = TextEditingController();
    final whatsapp = TextEditingController();
    final map = TextEditingController();

    void initState() {
      super.initState();
      _fetchUserData();
    }
    void _fetchUserData() async {
      FirebaseFirestore.instance.collection("users").doc(user.uid).snapshots().listen((snapshot) {
          setState(() {
              proname.text = snapshot.data()["profilename"];
              avatar = snapshot.data()["avatar"];
              username.text = snapshot.data()["username"];
              biod.text = snapshot.data()["bio"];
              faceb.text = snapshot.data()["facebook"];
              instag.text = snapshot.data()["instagram"];
              snap.text = snapshot.data()["snapchat"];
              linkedin.text = snapshot.data()["linkedin"];
              youtube.text = snapshot.data()["youtube"];
              tweet.text = snapshot.data()["twitter"];
              ticktok.text = snapshot.data()["ticktok"];
              spoty.text = snapshot.data()["spotify"];
              phonenum.text = snapshot.data()["pn"];
              paypa.text = snapshot.data()["paypal"];
              anylink.text = snapshot.data()["link"];
              sound.text = snapshot.data()["soundcloud"];
              email.text = snapshot.data()["em"];
              twitch.text = snapshot.data()["twitch"];
              apple.text = snapshot.data()["apple"];
              website.text = snapshot.data()["website"];
              venmo.text = snapshot.data()["venmo"];
              cash.text = snapshot.data()["cash"];
              whatsapp.text = snapshot.data()["whatsapp"];
              map.text = snapshot.data()["map"];
            });
       });  
  }  


String downlaodUrl, avatar, name, bio, fb, insta, sn, tw, li, em, yt, spot, paypal, link, pn, tt, sc, twt, applem, web, ve, ca, wa, ma;
  final GlobalKey _formKey = GlobalKey();
     
Future getImage() async {
     final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
    }

   Future uploadPic(BuildContext context) async{
      String fileName = basename(_image.path);
      StorageReference firebaseStorageRef  = FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
      StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
      downlaodUrl = await taskSnapshot.ref.getDownloadURL();
       setState(() {
          print("Profile Picture uploaded // $downlaodUrl");
       }); 
       FirebaseFirestore.instance.collection("users").doc(user.uid).update({
        'updatedAt': FieldValue.serverTimestamp(),
        'avatar': downlaodUrl,
          }).then((result){

          print("profile added in user profile");

          }).catchError((onError){

          print("image error");
          }); 
          FirebaseFirestore.instance.collection("users").doc(username.text).update({
        'updatedAt': FieldValue.serverTimestamp(),
        'avatar': downlaodUrl,
          }).then((result){

          print("profile added in user profile");

          }).catchError((onError){

          print("image error");
          }); 
    }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final FirebaseAuth _auth = FirebaseAuth.instance;

    // FirebaseFirestore.instance.collection("users").doc(user.uid).get().then((snapshot){
    //    print(snapshot.data());
    //   this.name = snapshot.data()["profilename"];
    // });

// FirebaseFirestore.instance.collection("users").doc(user.uid).snapshots().listen((snapshot) {
//   print(snapshot.data());
//    this.name = snapshot.data()["profilename"];
// });

 Future<void> _signOut() async {
    await _auth.signOut();
  }

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.developer_board, color: Colors.white),
            onPressed: () => (context),
          ),
        ],
      ),
      body: Form(
              key: _formKey,
              child:
              Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
              children: [
              SizedBox(height: 30.0),
              CircleAvatar(
                backgroundColor: Color(0xff000000),
                radius: 100,
                child: ClipOval(
                        child: new SizedBox(
                          width: 180.0,
                          height: 180.0,
                           child: (_image!=null)?Image.file(
                            _image,
                            fit: BoxFit.fill,
                          ):Image.network(
                            "https://360connect.io/wp-content/uploads/2020/11/place.jpg",
                            fit: BoxFit.fill,
                          ),
                        )
                 )
                 
                ),
                Padding(
                    padding: EdgeInsets.only(top: 0.0),
                    child: IconButton(
                      icon: new Icon(FlatIcons.photo_camera),
                      onPressed: () {
                        getImage();
                      },
                    )
                  ),
              SizedBox(height: 20.0,),
              Column(
              children: [
                TextFormField(
                        controller: proname,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {      
                              proname.clear();                
                            },
                          ),
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              width: 0, 
                              style: BorderStyle.none,
                          )
                          ),
                          fillColor: Colors.black,
                          filled: true,
                          hintText: 'Profile name',
                              hintStyle: TextStyle(
                                    color: Colors.grey,
                              ),
                        icon: new Icon(FlatIcons.user),
                       
                    ),
                      keyboardType: TextInputType.text,
                      // ignore: missing_return
                        onChanged: (value){
                             this.name = value;
                                 },
                     ),

                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextFormField(
                      controller: biod,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {      
                              biod.clear();                
                            },
                          ),
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              width: 0, 
                              style: BorderStyle.none,
                          )
                          ),
                          fillColor: Colors.black,
                          filled: true,
                          hintText: 'Your Bio',
                              hintStyle: TextStyle(
                                    color: Colors.grey,
                              ),
                      icon: new Icon(FlatIcons.notebook),
                      ),
                      keyboardType: TextInputType.multiline,
                      // ignore: missing_return
                      onChanged: (value){
                      this.bio = value;
                      },
                      ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 20) ,
                        child: TextFormField(
                        controller: faceb,
                        style: TextStyle(color: Colors.white),
                           decoration: InputDecoration(
                             suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {      
                              faceb.clear();                
                            },
                          ),
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              width: 0, 
                              style: BorderStyle.none,
                          )
                          ),
                          fillColor: Colors.black,
                          filled: true,
                          hintText: 'Facebook Username',
                          hintStyle: TextStyle(
                                color: Colors.grey,
                          ),
                              icon: Image.asset('assets/images/fb.png', height: 30, width: 30),
                        ),
                            keyboardType: TextInputType.text,   
                                    onChanged: (value){
                                      this.fb = value;
                                 },
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: TextFormField(
                        controller: instag,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {      
                              instag.clear();                
                            },
                          ),
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              width: 0, 
                              style: BorderStyle.none,
                          )
                          ),
                          fillColor: Colors.black,
                          filled: true,
                          hintText: 'Instagram Username',
                          hintStyle: TextStyle(
                                color: Colors.grey,
                          ),
                          icon: Image.asset('assets/images/IG.png', height: 30, width: 30),
                          ),
                          keyboardType: TextInputType.text,   
                          onChanged: (value){
                            this.insta = value;
                          },
                          ),
                        ),
                    
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: TextFormField(
                        controller: snap,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                           suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {      
                              snap.clear();                
                            },
                          ),
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          ),
                          fillColor: Colors.black,
                          filled: true,
                          hintText: 'Snapchat Username',
                          hintStyle: TextStyle(
                                color: Colors.grey,
                          ),
                          icon: Image.asset('assets/images/SC.png', height: 30, width: 30),
                          ),
                        keyboardType: TextInputType.text,   
                          onChanged: (value){
                            this.sn = value;
                          },
                      ),
                       ),

                       Padding(
                         padding: const EdgeInsets.only(top: 20),
                         child: TextFormField(
                           style: TextStyle(color: Colors.white),
                          controller: tweet,
                           decoration: InputDecoration(
                             suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {      
                              tweet.clear();                
                            },
                          ),
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          ),
                          fillColor: Colors.black,
                          filled: true,
                          hintText: 'Twitter Username',
                          hintStyle: TextStyle(
                                color: Colors.grey,
                          ),
                              icon: Image.asset('assets/images/TW54.png', height: 30, width: 30),
                          ),
                            keyboardType: TextInputType.text,   
                                    onChanged: (value){
                                      this.tw = value;
                                 },
                      )
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: TextFormField(
                        controller: linkedin,
                        style: TextStyle(color: Colors.white),
                           decoration: InputDecoration(
                             suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {      
                              linkedin.clear();                
                            },
                          ),
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          ),
                          fillColor: Colors.black,
                          filled: true,
                          hintText: 'linkedin Profile link',
                          hintStyle: TextStyle(
                                color: Colors.grey,
                          ),
                              icon: Image.asset('assets/images/link32.png', height: 30, width: 30),
                        ),
                            keyboardType: TextInputType.text,   
                                    onChanged: (value){
                                      this.li = value;
                                 },
                        ) 
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 20) ,
                          child: TextFormField(
                        controller: email,
                        style: TextStyle(color: Colors.white),
                           decoration: InputDecoration(
                              suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {      
                              email.clear();                
                            },
                          ),
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          ),
                          fillColor: Colors.black,
                          filled: true,
                          hintText: 'Email',
                          hintStyle: TextStyle(
                                color: Colors.grey,
                          ),
                              icon: Image.asset('assets/images/Mail.png', height: 30, width: 30),
                        ),
                            keyboardType: TextInputType.emailAddress,   
                                    onChanged: (value){
                                      this.em = value;
                                 },
                      ),
                          ),
                      
                   
                      
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: TextFormField(
                        controller: phonenum,
                        style: TextStyle(color: Colors.white),
                           decoration: InputDecoration(
                              suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {      
                              phonenum.clear();                
                            },
                          ),
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          ),
                          fillColor: Colors.black,
                          filled: true,
                          hintText: 'Text',
                          hintStyle: TextStyle(
                                color: Colors.grey,
                          ),
                              icon: Image.asset('assets/images/Messages.png', height: 30, width: 30),
                        ),
                            keyboardType: TextInputType.number,   
                                    onChanged: (value){
                                      this.pn = value;
                                 },
                        ), 
                        ),
                      
                      Padding(
                        padding: const EdgeInsets.only(top: 20), 
                        child: TextFormField(
                        controller: ticktok,
                        style: TextStyle(color: Colors.white),
                           decoration: InputDecoration(
                              suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {      
                              ticktok.clear();                
                            },
                          ),
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          ),
                          fillColor: Colors.black,
                          filled: true,
                          hintText: 'Ticktok Username',
                          hintStyle: TextStyle(
                                color: Colors.grey,
                          ),
                              icon: Image.asset('assets/images/Tiktrr.png', height: 30, width: 30),
                        ),
                            keyboardType: TextInputType.text,   
                                    onChanged: (value){
                                      this.tt = value;
                                 },
                        ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: TextFormField(
                        controller: sound,
                        style: TextStyle(color: Colors.white),
                           decoration: InputDecoration(
                              suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {      
                              sound.clear();                
                            },
                          ),
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          ),
                          fillColor: Colors.black,
                          filled: true,
                          hintText: 'Soundcloud Username',
                          hintStyle: TextStyle(
                                color: Colors.grey,
                          ),
                              icon: Image.asset('assets/images/SCL.png', height: 30, width: 30),
                        ),
                            keyboardType: TextInputType.text,   
                                    onChanged: (value){
                                      this.sc = value;
                                 },
                        ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: TextFormField(
                            controller: spoty,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                               suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {      
                              spoty.clear();                
                            },
                          ),
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          ),
                          fillColor: Colors.black,
                          filled: true,
                          hintText: 'Spotify link',
                          hintStyle: TextStyle(
                                color: Colors.grey,
                          ),
                              icon: Image.asset('assets/images/Spotify.png', height: 30, width: 30),
                           ),
                            keyboardType: TextInputType.text,   
                                    onChanged: (value){
                                      this.spot = value;
                                 },
                            ),
                            ),
                      
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: TextFormField(
                        controller: youtube,
                        style: TextStyle(color: Colors.white),
                           decoration: InputDecoration(
                              suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {      
                              youtube.clear();                
                            },
                          ),
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          ),
                          fillColor: Colors.black,
                          filled: true,
                          hintText: 'Youtube Profile link',
                          hintStyle: TextStyle(
                                color: Colors.grey,
                          ),
                              icon: Image.asset('assets/images/YT.png', height: 30, width: 30),
                        ),
                            keyboardType: TextInputType.text,   
                                    onChanged: (value){
                                      this.yt = value;
                                 },
                        ),
                        ),
                      
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: TextFormField(
                        controller: paypa,
                        style: TextStyle(color: Colors.white),
                           decoration: InputDecoration(
                              suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {      
                              paypa.clear();                
                            },
                          ),
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          ),
                          fillColor: Colors.black,
                          filled: true,
                          hintText: 'Paypal link',
                          hintStyle: TextStyle(
                                color: Colors.grey,
                          ),
                              icon: Image.asset('assets/images/pp.png', height: 30, width: 30),
                        ),
                            keyboardType: TextInputType.text,   
                                    onChanged: (value){
                                      this.paypal = value;
                                 },
                        ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: TextFormField(
                          controller: anylink,
                          style: TextStyle(color: Colors.white),
                           decoration: InputDecoration(
                              suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {      
                              anylink.clear();                
                            },
                          ),
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          ),
                          fillColor: Colors.black,
                          filled: true,
                          hintText: 'Any/Custom link',
                          hintStyle: TextStyle(
                                color: Colors.grey,
                          ),
                              icon: Image.asset('assets/images/Link.png', height: 30, width: 30),
                        ),
                            keyboardType: TextInputType.text,   
                                    onChanged: (value){
                                      this.link = value;
                                 },
                          ),
                          ),

                          Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: TextFormField(
                          controller: twitch,
                          style: TextStyle(color: Colors.white),
                           decoration: InputDecoration(
                              suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {      
                              twitch.clear();                
                            },
                          ),
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          ),
                          fillColor: Colors.black,
                          filled: true,
                          hintText: 'Twitch Username',
                          hintStyle: TextStyle(
                                color: Colors.grey,
                          ),
                              icon: Image.asset('assets/images/TWT.png', height: 30, width: 30),
                        ),
                            keyboardType: TextInputType.text,   
                                    onChanged: (value){
                                      this.twt = value;
                                 },
                          ),
                          ),
                          Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: TextFormField(
                          controller: apple,
                          style: TextStyle(color: Colors.white),
                           decoration: InputDecoration(
                              suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {      
                              apple.clear();                
                            },
                          ),
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          ),
                          fillColor: Colors.black,
                          filled: true,
                          hintText: 'Apple Music link',
                          hintStyle: TextStyle(
                                color: Colors.grey,
                          ),
                              icon: Image.asset('assets/images/itune.png', height: 30, width: 30),
                        ),
                            keyboardType: TextInputType.text,   
                                    onChanged: (value){
                                      this.applem = value;
                                 },
                          ),
                          ),
                          Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: TextFormField(
                          controller: website,
                          style: TextStyle(color: Colors.white),
                           decoration: InputDecoration(
                              suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {      
                              website.clear();                
                            },
                          ),
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          ),
                          fillColor: Colors.black,
                          filled: true,
                          hintText: 'Website',
                          hintStyle: TextStyle(
                                color: Colors.grey,
                          ),
                              icon: Image.asset('assets/images/Safari.png', height: 30, width: 30),
                        ),
                            keyboardType: TextInputType.text,   
                                    onChanged: (value){
                                      this.web = value;
                                 },
                          ),
                          ),
                          Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: TextFormField(
                          controller: venmo,
                          style: TextStyle(color: Colors.white),
                           decoration: InputDecoration(
                              suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {      
                              venmo.clear();                
                            },
                          ),
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          ),
                          fillColor: Colors.black,
                          filled: true,
                          hintText: 'Venmo Username',
                          hintStyle: TextStyle(
                                color: Colors.grey,
                          ),
                              icon: Image.asset('assets/images/Ve.png', height: 30, width: 30),
                        ),
                            keyboardType: TextInputType.text,   
                                    onChanged: (value){
                                      this.ve = value;
                                 },
                          ),
                          ),
                          Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: TextFormField(
                          controller: cash,
                          style: TextStyle(color: Colors.white),
                           decoration: InputDecoration(
                              suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {      
                              cash.clear();                
                            },
                          ),
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          ),
                          fillColor: Colors.black,
                          filled: true,
                          hintText: 'Cash App',
                          hintStyle: TextStyle(
                                color: Colors.grey,
                          ),
                              icon: Image.asset('assets/images/Money.png', height: 30, width: 30),
                        ),
                            keyboardType: TextInputType.text,   
                                    onChanged: (value){
                                      this.ca = value;
                                 },
                          ),
                          ),
                          Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: TextFormField(
                          controller: whatsapp,
                          style: TextStyle(color: Colors.white),
                           decoration: InputDecoration(
                              suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {      
                              whatsapp.clear();                
                            },
                          ),
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          ),
                          fillColor: Colors.black,
                          filled: true,
                          hintText: 'Whatsapp Number',
                          hintStyle: TextStyle(
                                color: Colors.grey,
                          ),
                              icon: Image.asset('assets/images/WT.png', height: 30, width: 30),
                        ),
                            keyboardType: TextInputType.text,   
                                    onChanged: (value){
                                      this.wa = value;
                                 },
                          ),
                          ),
                          Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: TextFormField(
                          controller: map,
                          style: TextStyle(color: Colors.white),
                           decoration: InputDecoration(
                              suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {      
                              map.clear();                
                            },
                          ),
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          ),
                          fillColor: Colors.black,
                          filled: true,
                          hintText: 'Business Address',
                          hintStyle: TextStyle(
                                color: Colors.grey,
                          ),
                              icon: Image.asset('assets/images/Map.png', height: 30, width: 30),
                        ),
                            keyboardType: TextInputType.text,   
                                    onChanged: (value){
                                      this.ma = value;
                                 },
                          ),
                          ),
                      
                      

                    SizedBox(height: 20.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                       RaisedButton(
                              onPressed: (){
                                uploadPic(context);
                  FirebaseFirestore.instance.collection("users").doc(user.uid)
                      .update({
                            'profilename': proname.text,
                            'bio': biod.text,
                            'facebook': faceb.text,
                            'instagram': instag.text,
                            'snapchat': snap.text,
                            'soundcloud': sound.text,
                            'linkedin': linkedin.text,
                            'paypal': paypa.text,
                            'link': anylink.text,
                            'spotify': spoty.text,
                            'youtube': youtube.text,
                            'pn': phonenum.text,
                            'ticktok': ticktok.text,
                            'twitter': tweet.text,
                            'em': email.text,
                            'twitch': twitch.text,
                            'apple': apple.text,
                            'website': website.text,
                            'venmo': venmo.text,
                            'cash': cash.text,
                            'whatsapp': whatsapp.text,
                            'map': map.text,
                            'updatedAt': FieldValue.serverTimestamp()
                            }).then((result){
                              print("new USer true");
                            }).catchError((onError){
                            print("onError");
                            }); 

                            FirebaseFirestore.instance.collection("users").doc(username.text)
                      .update({
                            'profilename': proname.text,
                            'bio': biod.text,
                            'facebook': faceb.text,
                            'instagram': instag.text,
                            'snapchat': snap.text,
                            'soundcloud': sound.text,
                            'linkedin': linkedin.text,
                            'paypal': paypa.text,
                            'link': anylink.text,
                            'spotify': spoty.text,
                            'youtube': youtube.text,
                            'pn': phonenum.text,
                            'ticktok': ticktok.text,
                            'twitter': tweet.text,
                            'em': email.text,
                            'twitch': twitch.text,
                            'apple': apple.text,
                            'website': website.text,
                            'venmo': venmo.text,
                            'cash': cash.text,
                            'whatsapp': whatsapp.text,
                            'map': map.text,
                            'updatedAt': FieldValue.serverTimestamp()
                            }).then((result){
                              print("new USer true");
                            }).catchError((onError){
                            print("onError");
                            }); 
                            Navigator.push(context,
                            MaterialPageRoute(builder: (context) => LoggedInWidget()));
                          },
                          child: Text('Save'),
                          color: Colors.black,
                          textColor: Colors.white,
                          ),
                      ],
                    ),
                ],
              ),

      ],
    ),
        ),
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




  

    
 

  

    
      // body: Stack(
      //   children: <Widget>[
         
      //    Container(
      //       margin: const EdgeInsets.only(left: 50.0, top: 24),
      //        child: SizedBox(
      //         width: 97.0,
      //         height: 16.0,
      //         child: Stack(
      //           children: <Widget>[
      //             Pinned.fromSize(
      //               bounds: Rect.fromLTWH(0.0, 0.0, 97.0, 16.0),
      //               size: Size(97.0, 16.0),
      //               pinLeft: true,
      //               pinRight: true,
      //               pinTop: true,
      //               pinBottom: true,
      //               child: Text(
      //                 'Profile Name',
      //                 style: TextStyle(
      //                   fontFamily: 'Josefin Sans',
      //                   fontSize: 16,
      //                   color: const Color(0xff5663ff),
      //                   fontWeight: FontWeight.w600,
      //                   height: 0.9375,
      //                 ),
      //                 textAlign: TextAlign.left,
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //     Container(
      //         margin: const EdgeInsets.only(left: 22.0, top: 46.0),
      //         child: Container(
      //       width: 331,
      //       padding: EdgeInsets.all(10.0),
      //       child: TextField(
      //       maxLength: 15,
      //       autocorrect: true,
      //       decoration: InputDecoration(
      //         hintText: 'usama...',
      //         hintStyle: TextStyle(color: Colors.grey),
      //         filled: true,
      //         fillColor: Colors.white70,
      //         enabledBorder: OutlineInputBorder(
      //           borderRadius: BorderRadius.all(Radius.circular(18.0)),
      //           borderSide: BorderSide(color: Colors.grey, width: 2),
      //          ),
      //         focusedBorder: OutlineInputBorder(
      //           borderRadius: BorderRadius.all(Radius.circular(18.0)),
      //           borderSide: BorderSide(color: Colors.grey),
      //         ),
      //       ),)
      //     )
      //     ),

      //     Container(
      //       margin: const EdgeInsets.only(left: 50.0, top: 138.0),
      //       child: SizedBox(
      //         width: 51.0,
      //         height: 16.0,
      //         child: Stack(
      //           children: <Widget>[
      //             Pinned.fromSize(
      //               bounds: Rect.fromLTWH(0.0, 0.0, 51.0, 16.0),
      //               size: Size(51.0, 16.0),
      //               pinLeft: true,
      //               pinRight: true,
      //               pinTop: true,
      //               pinBottom: true,
      //               child: Text(
      //                 'My Bio',
      //                 style: TextStyle(
      //                   fontFamily: 'Josefin Sans',
      //                   fontSize: 16,
      //                   color: const Color(0xff5663ff),
      //                   fontWeight: FontWeight.w600,
      //                   height: 0.9375,
      //                 ),
      //                 textAlign: TextAlign.left,
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),


      //     Container(
      //       margin: const EdgeInsets.only(left: 22.0, top: 155.0),
      //       child: Container(
      //       width: 331,
      //       padding: EdgeInsets.all(10.0),
      //       child: TextField(
      //       keyboardType: TextInputType.multiline,
      //       maxLines: 2,
      //       maxLength: 100,
      //       autocorrect: true,
      //       decoration: InputDecoration(
      //         hintText: 'usama...',
      //         hintStyle: TextStyle(color: Colors.grey),
      //         filled: true,
      //         fillColor: Colors.white70,
      //         enabledBorder: OutlineInputBorder(
      //           borderRadius: BorderRadius.all(Radius.circular(18.0)),
      //           borderSide: BorderSide(color: Colors.grey, width: 2),
      //          ),
      //         focusedBorder: OutlineInputBorder(
      //           borderRadius: BorderRadius.all(Radius.circular(18.0)),
      //           borderSide: BorderSide(color: Colors.grey),
      //         ),
      //       ),)
      //     )
      //     ),

      //     Container(
      //       margin: const EdgeInsets.only(left: 50.0, top: 270.0),    
      //       child: SizedBox(
      //         width: 111.0,
      //         height: 16.0,
      //         child: Stack(
      //           children: <Widget>[
      //             Pinned.fromSize(
      //               bounds: Rect.fromLTWH(0.0, 0.0, 111.0, 16.0),
      //               size: Size(111.0, 16.0),
      //               pinLeft: true,
      //               pinRight: true,
      //               pinTop: true,
      //               pinBottom: true,
      //               child: Text(
      //                 'Privacy Setting',
      //                 style: TextStyle(
      //                   fontFamily: 'Josefin Sans',
      //                   fontSize: 16,
      //                   color: const Color(0xff5663ff),
      //                   fontWeight: FontWeight.w600,
      //                   height: 0.9375,
      //                 ),
      //                 textAlign: TextAlign.left,
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),

      //     Container(
      //       margin: const EdgeInsets.only(left: 50.0, top: 295.0),
      //       child: Text(
      //         'Your profile is now public',
      //         style: TextStyle(
      //           fontFamily: 'Josefin Sans',
      //           fontSize: 16,
      //           color: const Color(0xff8a98ba),
      //           height: 0.9375,
      //         ),
      //         textAlign: TextAlign.left,
      //       ),
      //     ),

      //     Container(
      //       margin: const EdgeInsets.only(left: 22.7, top: 335.0),
      //       child:
      //           // Adobe XD layer: 'facebook' (shape)
      //           Container(
      //         width: 39.6,
      //         height: 37.9,
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(22.0),
      //           image: DecorationImage(
      //             image: const AssetImage('assets/images/icon.png'),
      //             fit: BoxFit.cover,
      //             colorFilter: new ColorFilter.mode(
      //                 Colors.black.withOpacity(0.85), BlendMode.dstIn),
      //           ),
      //           boxShadow: [
      //             BoxShadow(
      //               color: const Color(0x0b000000),
      //               offset: Offset(0, 10),
      //               blurRadius: 99,
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),

      //     Container(
      //       margin: const EdgeInsets.only(left: 66.0, top: 318.0),
      //       child: Container(
      //       width: 280,
      //       height: 67.9,
      //       padding: EdgeInsets.all(10.0),
      //       child: TextField(
      //       autocorrect: true,
      //       onChanged: (value){
      //                        this.fb = value;
      //                            },
      //       decoration: InputDecoration(
      //         hintText: 'facebook.com/afdawda...',
      //         hintStyle: TextStyle(color: Colors.grey),
      //         filled: true,
      //         fillColor: Colors.white70,
      //         enabledBorder: OutlineInputBorder(
      //           borderRadius: BorderRadius.all(Radius.circular(18.0)),
      //           borderSide: BorderSide(color: Colors.grey, width: 2),
      //          ),
      //         focusedBorder: OutlineInputBorder(
      //           borderRadius: BorderRadius.all(Radius.circular(18.0)),
      //           borderSide: BorderSide(color: Colors.grey),
      //         ),
      //       ),)
      //     )
      //     ),

      //     Container(
      //       margin: const EdgeInsets.only(left: 2.0, top: 0.0),
      //       child:
      //           Container(
      //         width: 373.0,
      //         height: 35.0,
      //         decoration: BoxDecoration(
      //           image: DecorationImage(
      //             image: const AssetImage(''),
      //             fit: BoxFit.fill,
      //             colorFilter: new ColorFilter.mode(
      //                 Colors.black.withOpacity(0.8), BlendMode.dstIn),
      //           ),
      //         ),
      //       ),
      //     ),
        
      //       Container(
      //         margin: const EdgeInsets.only(left: 66.0, top: 518.0),
      //         child: RaisedButton(
      //         child: Text('Create Record'),
      //         onPressed: () {
      //         if (_fbKey.currentState.saveAndValidate()) {
      //             FirebaseFirestore.instance
      //                 .collection('message')
      //                 .doc()
      //                 .set({
      //               'name': _fbKey.currentState.value['name'],
      //               'email': _fbKey.currentState.value['email'],
      //               'details': _fbKey.currentState.value['details'],
      //               'category': _fbKey.currentState.value['category']
      //                       });
      //         }
      //         }
      //           )
      //       )
          
      //   ],
      // ),
     
  
   