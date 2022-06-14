import 'package:brothers_app/network_reques_text/network_request_text.dart';
import 'package:flutter/material.dart';

import '../comment_model/comment_model.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({Key? key}) : super(key: key);

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  listView(AsyncSnapshot<List<Comment>> snapshot) {
    List<Comment> comments = snapshot.data!;
    return ListView.builder(
        itemCount: comments.length,
        itemBuilder: (context, snapshot) {
          Comment comment = comments[snapshot];
          return Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Text(
                  comment.email.toString(),
                ),
                Text(
                  comment.name.toString(),
                ),
                Text(comment.body.toString())
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Comment>>(
        future: NetworkRequestText.fetchComments(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error ${snapshot.error}');
          } else if (snapshot.hasData) {
            return listView(snapshot);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
