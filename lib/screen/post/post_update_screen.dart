import 'package:api_crud/api/api_services.dart';
import 'package:api_crud/screen/post/post_screen.dart';
import 'package:flutter/material.dart';

class PostUpdateScreen extends StatefulWidget {
  final int id;
  const PostUpdateScreen({super.key, required this.id});

  @override
  State<PostUpdateScreen> createState() => _PostUpdateScreenState();
}

class _PostUpdateScreenState extends State<PostUpdateScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  void updatePost(title, body, id) async {
    ApiServices.updatePost("posts", title, body, id).whenComplete(() => Navigator.push(context, MaterialPageRoute(builder: (context) => const PostScreen())));
  }

  @override
  void initState() {
    super.initState();
    ApiServices.fetchById("posts", widget.id).then(
      (value) {
        titleController.text = value!.title;
        bodyController.text = value.body;
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    bodyController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Post"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: _buildCreateView(),
      ),
    );
  }

  Widget _buildCreateView() {
    return Column(
      children: [
        TextField(
          controller: titleController,
          decoration: const InputDecoration(
            labelText: "Title",
          ),
        ),
        TextField(
          controller: bodyController,
          decoration: const InputDecoration(
            labelText: "Body",
          ),
        ),
        TextButton(
          style: const ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(Colors.blue),
          ),
          onPressed: () {
            updatePost(titleController.text, bodyController.text, widget.id);
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
