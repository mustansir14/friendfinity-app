import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:friendfinity/screens/palette.dart';
import 'package:friendfinity/models/models.dart';
import 'package:friendfinity/widgets/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/timeAgo.dart';

class PostContainer extends StatefulWidget {
  final post;

  const PostContainer({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  State<PostContainer> createState() => _PostContainerState();
}

class _PostContainerState extends State<PostContainer> {
  var user;
  var likes;
  var comments;

  @override
  bool get wantKeepAlive => true;

  void initState() {
    getUser(widget.post['userID']);
    getLikes(widget.post['_id']);
    getComments(widget.post['_id']);
  }

  getUser(userID) async {
    var response = await http.get(Uri.parse(
        "https://friend-finity-backend.herokuapp.com/users/" + userID));
    var fetchedUser = jsonDecode(response.body);
    setState(() {
      user = fetchedUser;
    });
  }

  getLikes(postID) async {
    var response = await http.get(Uri.parse(
        "https://friend-finity-backend.herokuapp.com/postlikes/post/" +
            postID));
    var fetchedLikes = jsonDecode(response.body);
    setState(() {
      likes = fetchedLikes;
    });
  }

  getComments(postID) async {
    var response = await http.get(Uri.parse(
        "https://friend-finity-backend.herokuapp.com/comments/post/" + postID));
    var fetchedComments = jsonDecode(response.body);
    setState(() {
      comments = fetchedComments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _PostHeader(post: widget.post, user: user),
                const SizedBox(height: 4.0),
                Text(
                  widget.post['text'] != null ? widget.post['text'] : "",
                ),
                widget.post['imageURL'] != null
                    ? const SizedBox.shrink()
                    : const SizedBox(height: 4.0),
              ],
            ),
          ),
          widget.post['imageURL'] != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CachedNetworkImage(
                      imageUrl:
                          widget.post != null ? widget.post['imageURL'] : ""),
                )
              : const SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: _PostStats(
              post: widget.post,
              likes: likes,
              comments: comments,
            ),
          ),
        ],
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  final post;
  final user;

  const _PostHeader({Key? key, required this.post, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileAvatar(
            imageUrl: user != null
                ? user['profilePicURL']
                : "https://blogtimenow.com/wp-content/uploads/2014/06/hide-facebook-profile-picture-notification.jpg"),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user != null ? user['firstName'] + ' ' + user['lastName'] : "",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${timeAgo(DateTime.parse(post['dateTimePosted']))} • ',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12.0),
                  ),
                  Icon(
                    Icons.public,
                    color: Colors.grey[600],
                    size: 12.0,
                  )
                ],
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.more_horiz),
          onPressed: () => print('More'),
        ),
      ],
    );
  }
}

class _PostStats extends StatelessWidget {
  final post;
  final likes;
  final comments;

  const _PostStats({
    Key? key,
    required this.post,
    required this.likes,
    required this.comments,
    // required this.shares,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Palette.facebookBlue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.thumb_up,
                size: 10.0,
              ),
            ),
            const SizedBox(width: 4.0),
            Expanded(
              child: Text(
                '${likes != null ? likes.length : ""}',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ),
            Text(
              '${comments != null ? comments.length : ""} Comments',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        const Divider(),
        Row(
          children: [
            _PostButton(
              icon: Icon(
                MdiIcons.thumbUpOutline,
                color: Colors.grey[600],
                size: 20.0,
              ),
              label: 'Like',
              onTap: () => print('Like'),
            ),
            _PostButton(
              icon: Icon(
                MdiIcons.commentOutline,
                color: Colors.grey[600],
                size: 20.0,
              ),
              label: 'Comment',
              onTap: () => print('Comment'),
            ),
            _PostButton(
              icon: Icon(
                MdiIcons.shareOutline,
                color: Colors.grey[600],
                size: 25.0,
              ),
              label: 'Share',
              onTap: () => print('Share'),
            )
          ],
        ),
      ],
    );
  }
}

class _PostButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final VoidCallback onTap;

  const _PostButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        child: InkWell(
          onTap: onTap,
          child: Container(
            color: Colors.grey.shade900,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            height: 25.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 4.0),
                Text(label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
