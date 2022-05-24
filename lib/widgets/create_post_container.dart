import 'package:flutter/material.dart';
import 'package:friendfinity/data/data.dart';
import 'package:friendfinity/models/models.dart';
import 'package:friendfinity/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../screens/profile_screen.dart';

class CreatePostContainer extends StatefulWidget {
  var currentUser;
  final Function addPost;

  CreatePostContainer(
      {Key? key, required this.currentUser, required this.addPost})
      : super(key: key);

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

  var _controller = TextEditingController();

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

  Future<void> uploadPost() async {
    if (!uploadedImage && postText == "") {
      return;
    }
    var object = <String, String>{'userID': widget.currentUser['_id']};
    if (uploadedImage) object['imageURL'] = imageFileString;
    if (postText != "") object['text'] = postText;
    final response = await http.post(
      Uri.parse("https://friend-finity-backend.herokuapp.com/posts/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(object),
    );
    if (response.statusCode == 201) {
      widget.addPost(jsonDecode(response.body));
      postText = "";
      _controller.clear();
      uploadedImage = false;
    }
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
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Profile(
                                userID: widget.currentUser['_id'],
                              )));
                    },
                    child: ProfileAvatar(
                        imageUrl: widget.currentUser != null
                            ? widget.currentUser['profilePicURL']
                            : "https://blogtimenow.com/wp-content/uploads/2014/06/hide-facebook-profile-picture-notification.jpg"),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: TextField(
                      controller: _controller,
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
                      onPressed: uploadPost,
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
