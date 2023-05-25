import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Hitchcake/ui/widgets/rounded_icon_button.dart';
import 'package:Hitchcake/ui/widgets/image_portrait.dart';

class AddPhotoScreen extends StatefulWidget {
  final Function(String) onPhotoChanged;

  AddPhotoScreen({required this.onPhotoChanged});

  @override
  AddPhotoScreenState createState() => AddPhotoScreenState();
}

class AddPhotoScreenState extends State<AddPhotoScreen> {
  final picker = ImagePicker();
  late String _imagePath = '';

  Future<void> pickImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      widget.onPhotoChanged(pickedFile.path);
    }

    setState(() {
      _imagePath = pickedFile!.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Add photo',
            style: Theme.of(context).textTheme.headline3,
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  child: _imagePath == null || _imagePath!.isEmpty
                      ? ImagePortrait(imageType: ImageType.NONE)
                      : ImagePortrait(
                          imagePath: _imagePath!,
                          imageType: ImageType.FILE_IMAGE,
                        ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: _imagePath == null || _imagePath!.isEmpty
                        ? RoundedIconButton(
                            onPressed: pickImageFromGallery,
                            iconData: Icons.add,
                            iconSize: 20,
                          )
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
