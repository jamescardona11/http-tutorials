import 'package:firebase_filledstacks_app/models/post_model.dart';
import 'package:firebase_filledstacks_app/ui/shared/ui_helpers.dart';
import 'package:firebase_filledstacks_app/ui/widgets/input_field.dart';
import 'package:firebase_filledstacks_app/viewmodels/create_post_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

class CreatePostView extends StatelessWidget {
  final titleController = TextEditingController();
  final Post edittingPost;

  CreatePostView({Key key, this.edittingPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<CreatePostViewModel>.withConsumer(
      viewModelBuilder: () => CreatePostViewModel(),
      onModelReady: (model) {
        titleController.text = edittingPost?.title ?? '';
        model.setEdittingPost(edittingPost);
      },
      builder: (context, model, child) => Scaffold(
          floatingActionButton: FloatingActionButton(
            child: !model.busy
                ? Icon(Icons.add)
                : CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
            onPressed: () {
              if (!model.busy)
                model.addPost(
                  title: titleController.text,
                );
            },
            backgroundColor: !model.busy ? Theme.of(context).primaryColor : Colors.grey[600],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                verticalSpace(40),
                Text(
                  'Create Post',
                  style: TextStyle(fontSize: 26),
                ),
                verticalSpaceMedium,
                InputField(
                  placeholder: 'Title',
                  controller: titleController,
                ),
                verticalSpaceMedium,
                Text('Post Image'),
                verticalSpaceSmall,
                GestureDetector(
                  onTap: () => model.selectImage(),
                  child: Container(
                    height: 250,
                    decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    child: Text(
                      'Tap to add post image',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
