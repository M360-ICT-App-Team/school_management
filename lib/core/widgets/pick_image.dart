import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<XFile?> appPickImage(BuildContext context) async {
  XFile? photo;
  final ImagePicker picker = ImagePicker();
  await showModalBottomSheet(
    context: context,
    builder: (_) => Wrap(
      spacing: 15,
      children: [
        const SizedBox(
          height: 10,
        ),
        ListTile(
          onTap: () async {
            await picker.pickImage(source: ImageSource.gallery).then((value) {
              if (value != null) {
                photo = value;
              }
              if(context.mounted){
                Navigator.pop(context, photo);
              }
            });
          },
          contentPadding: const EdgeInsets.symmetric(horizontal: 30),
          leading: const Icon(CupertinoIcons.photo),
          title: const Text("From Gallery"),
        ),
        ListTile(
          onTap: () async {
            await picker.pickImage(source: ImageSource.camera).then((value) {
              if (value != null) {
                photo = value;
              }
              if(context.mounted){
                Navigator.pop(context, photo);
              }
            });
          },
          contentPadding: const EdgeInsets.symmetric(horizontal: 30),
          leading: const Icon(CupertinoIcons.camera),
          title: const Text("Take a Picture"),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    ),
  );

  return photo;
}