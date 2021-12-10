import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

imageView(context, {String? image}) {
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Hero(
            transitionOnUserGestures: true,
            tag: image!,
            child: CachedNetworkImage(
              imageUrl: image,
            ),
          ),
        );
      });
}
