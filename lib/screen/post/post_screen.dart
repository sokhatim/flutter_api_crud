import 'package:api_crud/api/api_services.dart';
import 'package:api_crud/models/post/post_model.dart';
import 'package:api_crud/screen/post/post_create_screen.dart';
import 'package:api_crud/screen/post/post_update_screen.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<PostModel?> posts = [];

  void getPost() async {
    final data = await ApiServices.fetchAll("posts");
    if (data.isNotEmpty) {
      setState(() {
        posts = data;
      });
    }
  }

  void deletePost(id) async {
    final data = await ApiServices.deletePost("posts", id);
    if (data.isNotEmpty) {
      print(data);
    }
  }

  @override
  void initState() {
    super.initState();
    getPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post App"),
        backgroundColor: Colors.blue,
      ),
      body: _buildListView(),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const PostCreateScreen()));
        },
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(50)),
          child: const Center(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (__, index) {
        final String postId = posts[index]!.id.toString();
        final postTilte = posts[index]!.title;
        final postBody = posts[index]!.body;
        return ListTile(
          leading: Text(postId),
          title: Text(postTilte),
          subtitle: Text(postBody),
          trailing: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PostUpdateScreen(id: posts[index]!.id)));
                },
                child: const Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
              ),
              GestureDetector(
                onTap: () {
                  deletePost(postId);
                },
                child: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
