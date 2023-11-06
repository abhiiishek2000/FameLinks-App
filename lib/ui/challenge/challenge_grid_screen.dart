import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ChallengeGridScreen extends StatefulWidget {
  @override
  _ChallengeGridScreenState createState() => _ChallengeGridScreenState();
}

class _ChallengeGridScreenState extends State<ChallengeGridScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        child: StaggeredGridView.countBuilder(
            crossAxisCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 100,
                color: Colors.blueAccent,
              );
            },
            staggeredTileBuilder: (int index) {
              return StaggeredTile.count(2, index.isEven ? 2 : 1);
            },
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,),
      ),
    ));
  }
}
