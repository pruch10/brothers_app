import 'package:flutter/material.dart';

import '../model/photo_model.dart';

class PhotoCell extends StatelessWidget {
  final Photo photo;
   const PhotoCell(this.photo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Hero(
                    tag: 'Image${photo.id}',
                    child: FadeInImage.assetNetwork(
                      placeholder: 'images/No-image-available.png',
                      image: photo.thumbnailUrl.toString(),
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
              ),
              Padding(padding: const EdgeInsets.all(10),
              child: Text(photo.title.toString(),
              softWrap: true,
              textAlign: TextAlign.center,
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
