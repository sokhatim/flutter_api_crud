import 'package:api_crud/api/api_services.dart';
import 'package:api_crud/screen/post/post_screen.dart';
import 'package:flutter/material.dart';

class PostCreateScreen extends StatefulWidget {
  const PostCreateScreen({super.key});

  @override
  State<PostCreateScreen> createState() => _PostCreateScreenState();
}

class _PostCreateScreenState extends State<PostCreateScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  void createPost(title, body) async {
    ApiServices.createPost("posts", title, body).whenComplete(() => Navigator.push(context, MaterialPageRoute(builder: (context) => const PostScreen())));
  }

  @override
  void initState() {
    super.initState();
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
        title: const Text("Create Post"),
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
            createPost(titleController.text, bodyController.text);
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
