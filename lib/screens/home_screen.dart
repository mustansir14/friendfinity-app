import 'package:flutter/material.dart';
import 'package:friendfinity/widgets/widgets.dart';
import 'palette.dart';
import 'package:friendfinity/models/models.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/timeAgo.dart';

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
              CircleButton(
                icon: Icons.search,
                iconSize: 30.0,
                onPressed: () => print('Search'),
              ),
              CircleButton(
                icon: MdiIcons.facebookMessenger,
                iconSize: 30.0,
                onPressed: () => print('Messenger'),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: CreatePostContainer(currentUser: currentUser),
          ),
          // SliverPadding(
          //   padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
          //   sliver: SliverToBoxAdapter(
          //     child: Rooms(onlineUsers: onlineUsers),
          //   ),
          // ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return PostContainer(post: posts[index]);
              },
              childCount: posts.length,
            ),
          ),
        ],
      ),
    );
  }
}
