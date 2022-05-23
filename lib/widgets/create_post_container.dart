import 'package:flutter/material.dart';
import 'package:friendfinity/models/models.dart';
import 'package:friendfinity/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';

class CreatePostContainer extends StatefulWidget {
  var currentUser;

  CreatePostContainer({
    Key? key,
    required this.currentUser,
  }) : super(key: key);

  @override
  State<CreatePostContainer> createState() => _CreatePostContainerState();
}

class _CreatePostContainerState extends State<CreatePostContainer> {
  final _formKey = GlobalKey<FormState>();

  String postText = "";
  String imageFileString = "";
  late File chosenImageFile;
  bool uploadedImage = false;
  var postImage;

  Future<void> chooseImage() async {
    var choosedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    //set source: ImageSource.camera to get image from camera
    setState(() {
      chosenImageFile = File(choosedimage!.path);
      postImage = Image.file(chosenImageFile, fit: BoxFit.cover);
      final bytes = chosenImageFile.readAsBytesSync();
      imageFileString = "data:image/jpeg;base64," + base64Encode(bytes);
      uploadedImage = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  ProfileAvatar(
                      imageUrl: widget.currentUser != null
                          ? widget.currentUser['profilePicURL']
                          : "https://blogtimenow.com/wp-content/uploads/2014/06/hide-facebook-profile-picture-notification.jpg"),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration.collapsed(
                        hintText: 'What is on your Mind?',
                      ),
                      onChanged: (value) {
                        setState(
                          () {
                            postText = value;
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              if (uploadedImage) Image.file(chosenImageFile),
              const Divider(height: 10.0, thickness: 0.5),
              Container(
                height: 40.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FlatButton.icon(
                      onPressed: chooseImage,
                      icon: const Icon(
                        Icons.photo_library,
                        color: Colors.green,
                      ),
                      label: Text('Photo'),
                    ),
                    const VerticalDivider(width: 8.0),
                    FlatButton.icon(
                      onPressed: () => print('File'),
                      icon: const Icon(
                        Icons.upload,
                        color: Colors.purpleAccent,
                      ),
                      label: Text('Post'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
