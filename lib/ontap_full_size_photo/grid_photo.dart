import 'package:flutter/material.dart';
import 'package:brothers_app/model/photo_model.dart';

class GridFsPhoto extends StatefulWidget {
  const GridFsPhoto({required this.photo, Key? key}) : super(key: key);
  final Photo photo;

  @override
  _GridFsPhotoState createState() => _GridFsPhotoState();
}

class _GridFsPhotoState extends State<GridFsPhoto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: 'image${widget.photo.id}',
              child: FadeInImage.assetNetwork(
                placeholder: 'images/No-image-available.png',
                image: widget.photo.url.toString(),
              ),
            ),
            const SizedBox(
              width: 40,
            ),
            IconButton(
              alignment: Alignment.topLeft,
              onPressed: (() => Navigator.of(context).pop()),
              icon: const Icon(Icons.arrow_back),
              iconSize: 20,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
