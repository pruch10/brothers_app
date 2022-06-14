import 'package:brothers_app/cell/grid_cell.dart';
import 'package:brothers_app/comments_page/comments_page.dart';
import 'package:brothers_app/model/photo_model.dart';
import 'package:brothers_app/network/network_request.dart';
import 'package:brothers_app/ontap_full_size_photo/grid_photo.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  gridView(AsyncSnapshot<List<Photo>> snapshot) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        childAspectRatio: 1,
        crossAxisSpacing: 4,
        children: snapshot.data!.map((photo) {
          return GestureDetector(
            child: GridTile(
              child: PhotoCell(photo),
            ),
            onTap: () {
              toDetailPage(context, photo);
            },
          );
        }).toList(),
      ),
    );
  }

  toDetailPage(BuildContext context, Photo photo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => GridFsPhoto(photo: photo),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var currentIndex = 0;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Builder(builder: (context) {
          if (currentIndex == 0) {}
          if (currentIndex == 1) {return CommentsPage();
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                  child: FutureBuilder<List<Photo>>(
                future: NetworkRequest.fetchPhotos(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return gridView(snapshot);
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ))
            ],
          );
        }),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (newIndex) {
            setState(() {
              currentIndex = newIndex;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.photo,
                  size: 20,
                ),
                label: 'photos'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.comment,
                  size: 20,
                ),
                label: 'comments')
          ],
        ),
      ),
    );
  }
}
