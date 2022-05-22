import 'package:flutter/material.dart';
import 'package:friendfinity/screens/palette.dart';
import 'package:friendfinity/models/models.dart';
import 'package:friendfinity/widgets/widgets.dart';

class Rooms extends StatelessWidget {
  final List<User> onlineUsers;

  const Rooms({
    Key? key,
    required this.onlineUsers,
  }) : super(key: key);
  @override
  Widget build(BuildContext context){
      return Container(
          height: 60.0,
           color: Colors.white,
           child: ListView.builder(
            padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 4.0,
          ),
          scrollDirection: Axis.horizontal,
          itemCount: 1 + onlineUsers.length,
          itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0)
              );
          }     
             final User user = onlineUsers[index - 1]; 
              return Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ProfileAvatar(
                imageUrl: user.imageUrl,
                isActive: true,
              ),
              );
          },
        ),
      );
  }
}
