import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class ImageHandler extends StatelessWidget {
  final String? imageUrl;
  final double height;
  final double width;
  final double radius;
  const ImageHandler(
      {super.key,
      required this.imageUrl,
      this.height = 130,
      this.width = 150,
      this.radius = 10});

  @override
  Widget build(BuildContext context) {
    return (imageUrl == null || imageUrl!.isEmpty)
        ? ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Container(
              height: height,
              width: width,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(color: Colors.grey.shade200),
              child: Image.asset(
                "assets/no-pictures.png",
                fit: BoxFit.cover,
                scale: 3,
              ),
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: CachedNetworkImage(
              imageUrl: loadSprite(imageUrl.toString()),
              fit: BoxFit.cover,
              height: height,
              width: width,
              placeholder: (context, url) => SkeletonAvatar(
                style: SkeletonAvatarStyle(
                    width: 100,
                    height: 100,
                    randomHeight: false,
                    borderRadius: BorderRadius.circular(15)),
              ),
              errorWidget: (context, url, error) => Container(
                  color: Colors.grey.shade200,
                  child: Image.asset(
                    "assets/no-pictures.png",
                    fit: BoxFit.cover,
                    scale: 3,
                  )),
            ),
          );
  }
}

String loadSprite(String url) {
  // Remove the base URL and slashes
  String path = url.replaceAll("https://pokeapi.co/api/v2/pokemon/", "");

  // Split the path by slashes and take the first element
  String numberString = path.split("/")[0];

  // Convert the number string to an integer
  int number = int.tryParse(numberString) ?? 0;
  final imageUrl =
      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$number.png";

  return imageUrl;
}
