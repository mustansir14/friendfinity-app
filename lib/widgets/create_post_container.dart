import 'package:flutter/material.dart';
import 'package:friendfinity/models/models.dart';
import 'package:friendfinity/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
class CreatePostContainer extends StatelessWidget {
  final User currentUser;

  const CreatePostContainer({
    Key? key,
    required this.currentUser,
  }) : super(key: key);

@override
Widget build(BuildContext context){
      return Container(
          padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
          color: Colors.white,
          child: Column(
              children: [
                  Row(
                      children: [
                            ProfileAvatar(imageUrl: currentUser.imageUrl),
                            const SizedBox(width:8.0),

                          Expanded(
                              child : TextField(
                                  decoration: InputDecoration.collapsed(
                                      hintText: 'What is on your Mind?',
                                  ),
                              ),
                          ),
                      ],
                  ),
                  const Divider(height: 10.0, thickness: 0.5),
                   Container(
              height: 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton.icon(
                    onPressed: () => print('Video'),
                    icon: const Icon(
                      Icons.videocam,
                      color: Colors.red,
                    ),
                    label: Text('Video'),
                  ),
                  const VerticalDivider(width: 8.0),
                  FlatButton.icon(
                    onPressed: () => print('Photo'),
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
                      Icons.drive_folder_upload,
                      color: Colors.purpleAccent,
                    ),
                    label: Text('File'),
                  ),
                ],
              ),
            ),  
              ],
          ),
      );
  }
}