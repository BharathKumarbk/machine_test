import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'image_viewer.dart';

class CarousalView extends StatelessWidget {
  const CarousalView({Key? key, this.images}) : super(key: key);
  final List<String>? images;

  double viewPort(BoxConstraints constraints) {
    if (constraints.maxWidth < 640) {
      return 1.0;
    } else if (constraints.maxWidth > 640 && constraints.maxWidth < 1000) {
      return 0.8;
    } else {
      return 0.5;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => CarouselSlider(
        items: images!
            .map((e) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  width: double.infinity,
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
        options: CarouselOptions(
          viewportFraction: viewPort(constraints),
          height: 200.0,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          enlargeStrategy: CenterPageEnlargeStrategy.scale,
          autoPlayInterval: const Duration(seconds: 8),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: false,
        ),
      ),
    );
  }
}
