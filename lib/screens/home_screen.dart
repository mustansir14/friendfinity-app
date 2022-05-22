import 'package:flutter/material.dart';
import 'package:friendfinity/widgets/widgets.dart';
import 'palette.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
class HomeScreen extends StatelessWidget{
    @override
    Widget build(BuildContext context){
        return Scaffold(
            body: CustomScrollView(
                slivers:[
                    SliverAppBar(
                        brightness: Brightness.light,
                        backgroundColor: Colors.purple,
                        title: Text(
                            'FriendFinity',
                            style :const TextStyle(
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
                            key : 0,
                            icon: Icons.search,
                            iconSize: 30.0,
                            onPressed: () => print('Search'),
                            ),
                            CircleButton(
                            key : 1,
                            icon: MdiIcons.facebookMessenger,
                            iconSize: 30.0,
                            onPressed: () => print('Messenger'),
                            ),
                        ],
                    )
                ],
            ),
        );
    }
}