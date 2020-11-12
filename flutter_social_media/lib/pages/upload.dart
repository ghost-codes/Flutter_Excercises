import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_media/models/models.dart';
import 'package:flutter_social_media/util.dart';
import 'package:flutter_social_media/widgets/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:geocoding/geocoding.dart';

// final FirebaseStorage storage = FirebaseStorage.re
class Upload extends StatefulWidget {
  final Users currentUser;

  const Upload({Key key, this.currentUser}) : super(key: key);
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  TextEditingController locationController = TextEditingController();
  TextEditingController captionController = TextEditingController();
  File file;
  bool isUploading = false;
  String postId = Uuid().v4();

  handleChooseFromGallery() async {
    Navigator.pop(context);
    File file = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      this.file = file;
    });
  }

  handleTakePhoto() async {
    Navigator.pop(context);
    File file = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 675,
      maxWidth: 960,
    );
    setState(() {
      this.file = file;
    });
  }

  selectImage(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text("Create Post"),
            children: [
              SimpleDialogOption(
                child: Text('Photo with Camera'),
                onPressed: handleTakePhoto,
              ),
              SimpleDialogOption(
                child: Text('Image from Gallery'),
                onPressed: handleChooseFromGallery,
              ),
              SimpleDialogOption(
                child: Text('Cancel'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  Container buildSplashScreen() {
    return Container(
      color: Theme.of(context).accentColor.withOpacity(0.6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/upload.svg',
            height: 260.0,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: RaisedButton(
              onPressed: () => selectImage(context),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                "Upload Image",
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.white,
                ),
              ),
              color: Colors.deepOrange,
            ),
          )
        ],
      ),
    );
  }

  cleared() {
    file = null;
  }

  // compressImage() async {
  //   final tempDir = await getTemporaryDirectory();
  //   final path = tempDir;
  //   print('Done');
  //   Im.Image imageFile = Im.decodeImage(file.readAsBytesSync());
  //   final compressImage = File('$path/img_$postId.jpg')
  //     ..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 85));
  //     print('Done');
  //   setState(() {
  //     file = compressImage;
  //   });
  // }

  uploadImage(File imagefile) async {
    String downloadUrl;
    await storageRef.ref().child("post_$postId.jpg").putFile(imagefile);
    downloadUrl = await storageRef.ref("/post_$postId.jpg").getDownloadURL();
    //downloadUrl = await uploadTask.snapshot.ref.getDownloadURL();
    // String downloadUrl =
    //     await storageRef.ref("post_$postId.jpg").getDownloadURL();
    print(downloadUrl);
    return downloadUrl;
  }

  createPostInFireStore(
      {String mediaUrl, String location, String description}) {
    postRef.doc(widget.currentUser.id).collection("userPosts").doc(postId).set({
      "postId": postId,
      "ownerId": widget.currentUser.id,
      "username": widget.currentUser.username,
      "mediaUrl": mediaUrl,
      "description": description,
      "location": location,
      "timestamp": timestamp,
      "likes": {},
    });
  }

  handleSubmit() async {
    setState(() {
      isUploading = true;
    });
    // await compressImage();
    String mediaUrl = await uploadImage(file);
    createPostInFireStore(
      mediaUrl: mediaUrl,
      location: locationController.text,
      description: captionController.text,
    );
    captionController.clear();
    locationController.clear();
    setState(() {
      file = null;
      isUploading = false;
      postId = Uuid().v4();
    });
  }

  buildUploadForm() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: cleared,
        ),
        title: Text(
          "Caption Post",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          FlatButton(
            child: Text(
              "Post",
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: isUploading ? null : () => handleSubmit(),
          ),
        ],
      ),
      body: ListView(
        children: [
          isUploading ? linearProgressBar(context) : SizedBox.shrink(),
          Container(
            height: 220.0,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(file),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundImage:
                  CachedNetworkImageProvider(widget.currentUser.photoUrl),
            ),
            title: Container(
              width: 250,
              child: TextField(
                controller: captionController,
                decoration: InputDecoration(
                  hintText: "Write a caption",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.pin_drop, color: Colors.orange, size: 35.0),
            title: Container(
              width: 250,
              child: TextField(
                controller: locationController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Where was this picture taken?",
                ),
              ),
            ),
          ),
          Container(
            width: 200,
            height: 100,
            alignment: Alignment.center,
            child: RaisedButton.icon(
              onPressed: getUserCurrentLocation,
              color: Colors.blueAccent,
              icon: Icon(Icons.my_location, color: Colors.white),
              label: Text(
                "Use Current Location",
                style: TextStyle(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getUserCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    List placemarks = await GeocodingPlatform.instance
        .placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placemarks[0];
    String formattedlocation = "${placemark.locality}, ${placemark.country}";
    locationController.text = formattedlocation;
  }

  @override
  Widget build(BuildContext context) {
    return file == null ? buildSplashScreen() : buildUploadForm();
  }
}
