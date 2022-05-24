import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:friendfinity/models/models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/post_container.dart';

class Profile extends StatefulWidget {
  final String userID;
  const Profile({Key? key, required this.userID}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var user;
  var posts = [];

  void initState() {
    getUser(widget.userID);
    getPosts(widget.userID);
  }

  getUser(userID) async {
    var response = await http.get(Uri.parse(
        "https://friend-finity-backend.herokuapp.com/users/" + userID));
    var fetchedUser = jsonDecode(response.body);
    setState(() {
      user = fetchedUser;
    });
  }

  getPosts(userID) async {
    var response = await http.get(Uri.parse(
        "https://friend-finity-backend.herokuapp.com/posts/user/" + userID));
    var fetchedPosts = jsonDecode(response.body);
    setState(() {
      posts = fetchedPosts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomCenter,
                children: [
                  Image(
                    height: MediaQuery.of(context).size.height / 3,
                    fit: BoxFit.cover,
                    image: const NetworkImage(
                        'https://images.unsplash.com/photo-1485160497022-3e09382fb310?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTN8fG1vdW50YWluc3xlbnwwfHwwfHw%3D&w=1000&q=80'),
                  ),
                  Positioned(
                      bottom: -50.0,
                      child: CircleAvatar(
                        radius: 80,
                        child: CircleAvatar(
                          radius: 75,
                          backgroundImage: (user != null
                              ? NetworkImage(user['profilePicURL'])
                              : AssetImage("assets/no-profile-pic.png")
                                  as ImageProvider),
                        ),
                      ))
                ]),
            SizedBox(
              height: 45,
            ),
            ListTile(
              title: Center(
                  child: Text(
                      user != null
                          ? user["firstName"] + " " + user["lastName"]
                          : "",
                      style: TextStyle(color: Colors.white))),
              subtitle: Center(
                  child: Text(
                      user != null ? user["city"] + ", " + user["country"] : "",
                      style: TextStyle(color: Colors.white))),
            ),
            ListTile(
              title: Text('Born on', style: TextStyle(color: Colors.white)),
              subtitle: Text(
                  user != null ? user['dateOfBirth'].substring(0, 10) : "",
                  style: TextStyle(color: Colors.white)),
            ),
            for (var post in posts)
              PostContainer(
                post: post,
                currentUser: user,
              )
          ],
        ),
      ),
    );
  }
}
