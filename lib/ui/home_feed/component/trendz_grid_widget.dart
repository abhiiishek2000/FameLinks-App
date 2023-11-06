import 'package:cached_network_image/cached_network_image.dart';
import 'package:famelink/networking/config.dart';
import 'package:famelink/ui/homedial/model/HomeScreenModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../util/config/color.dart';
import 'grid_header.dart';

class TrendzGridWidget extends StatelessWidget {
  const TrendzGridWidget({Key? key, required this.postResult})
      : super(key: key);
  final TrendzResult postResult;

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
              child: InkWell(
                onTap: () {},
                child: CachedNetworkImage(
                  imageUrl: "${ApiProvider.challenges}/${postResult.images![0]}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ));
  }
}
