import 'package:flutter/material.dart';
import 'package:friendfinity/widgets/widgets.dart';
import 'palette.dart';
import 'package:friendfinity/models/models.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/timeAgo.dart';
import 'profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login.dart';

class HomeScreen extends StatefulWidget {
  final String userID;
  const HomeScreen({Key? key, required this.userID}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List posts = [];
  var currentUser;

  void initState() {
    getUser(widget.userID);
    getPosts(widget.userID);
  }

  getUser(userID) async {
    var response = await http.get(Uri.parse(
        "https://friend-finity-backend.herokuapp.com/users/" + userID));
    var fetchedUser = jsonDecode(response.body);
    setState(() {
      currentUser = fetchedUser;
    });
  }

  getPosts(userID) async {
    var response = await http.get(Uri.parse(
        "https://friend-finity-backend.herokuapp.com/posts/feed/" + userID));
    var fetchedPosts = jsonDecode(response.body);
    setState(() {
      posts = fetchedPosts;
    });
  }

  addPost(post) {
    setState(() {
      posts.insert(0, post);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            brightness: Brightness.light,
            backgroundColor: Colors.purple,
            title: Text(
              'FriendFinity',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -1.2,
              ),
            ),
            centerTitle: false,
            floating: true,
            actions: [
              // CircleButton(
              //   icon: Icons.search,
              //   iconSize: 30.0,
              //   onPressed: () => print('Search'),
              // ),
              Padding(
                padding: EdgeInsets.only(top: 6.0),
                child: PopupMenuButton(
                    onSelected: (value) async {
                      if (value == "Profile") {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Profile(
                                  userID: widget.userID,
                                )));
                      } else {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.remove("userID");
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => Login()),
                            (route) => false);
                      }
                    },
                    child: ProfileAvatar(
                      imageUrl: currentUser != null
                          ? currentUser['profilePicURL']
                          : 'https://blogtimenow.com/wp-content/uploads/2014/06/hide-facebook-profile-picture-notification.jpg',
                      radius: 22.0,
                    ),
                    itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                          const PopupMenuItem(
                            value: "Profile",
                            child: Text('Profile'),
                          ),
                          const PopupMenuItem(
                            value: "Logout",
                            child: Text('Logout'),
                          ),
                        ]),
              )
            ],
          ),
          SliverToBoxAdapter(
            child:
                CreatePostContainer(currentUser: currentUser, addPost: addPost),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return PostContainer(
                  post: posts[index],
                  currentUser: currentUser,
                );
              },
              childCount: posts.length,
            ),
          ),
        ],
      ),
    );
  }
}
