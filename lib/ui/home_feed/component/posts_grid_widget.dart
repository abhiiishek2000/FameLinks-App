import 'package:cached_network_image/cached_network_image.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/homedial/model/HomeScreenModel.dart';
import 'package:famelink/util/config/color.dart';
import 'package:flutter/material.dart';
import '../../../util/widgets/FeedVideoPlayer.dart';
import 'grid_header.dart';

class PostsGridWidget extends StatelessWidget {
  const PostsGridWidget({Key? key, required this.postResult}) : super(key: key);
  final PostResult postResult;

  @override
  Widget build(BuildContext context) {
    return GridTile(
        header: GridHeader(title: postResult.cardTitle!),
        child: Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: black.withOpacity(0.5),
                    offset: Offset(0, 4),
                    blurRadius: 4,
                  )
                ],
                border:
                    Border.all(color: Colors.white.withOpacity(0.50), width: 1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                ),
                child: postResult.media![0].type == "video"
                    ? Stack(
                        children: [
                          FeedVideoPlayer(
                            videoUrl:
                                "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/${postResult.media![0].path}",
                          ),
                        ],
                      )
                    : CachedNetworkImage(
                        imageUrl:
                            "${ApiProvider.s3UrlPath}/${ApiProvider.famelinks}/"
                            "${postResult.media![0].path ?? ""}",
                        fit: BoxFit.cover,
                      ),
              ),
            )));
  }
}
