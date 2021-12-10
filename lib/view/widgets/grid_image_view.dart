import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'image_viewer.dart';

class GridImageView extends StatelessWidget {
  const GridImageView({Key? key, this.images}) : super(key: key);
  final List<String>? images;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: LayoutBuilder(builder: (context, constraints) {
        int crossCount = (constraints.maxWidth ~/ 100).toInt();
        return GridView.count(
          crossAxisCount: crossCount < 3 ? 3 : crossCount,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: images!
              .map((e) => Hero(
                    tag: e,
                    transitionOnUserGestures: true,
                    child: InkWell(
                      onTap: () => imageView(context, image: e),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: CachedNetworkImage(
                          imageUrl: e,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ))
              .toList(),
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        );
      }),
    );
  }
}

