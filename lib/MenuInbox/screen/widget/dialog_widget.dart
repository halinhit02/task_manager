import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DialogWidget extends StatefulWidget {
  const DialogWidget({Key? key}) : super(key: key);

  @override
  State<DialogWidget> createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  PickedFile? _imagefile;
  final ImagePicker _picker = ImagePicker();

  Future getImage(ImageSource Source) async {
    final PickedFile = await _picker.getImage(source: Source);
    // final  imagetamp = File(image.path);
    setState(() {
      _imagefile = PickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 15),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => getImage(ImageSource.gallery),
              child: Row(
                children: [
                  Icon(Icons.file_copy, color: Colors.teal),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'File/Document',
                    style: TextStyle(color: Colors.teal, fontSize: 20),
                  )
                ],
              ),
            ),
            Divider(
              thickness: 1,
            ),
            GestureDetector(
              onTap: () => getImage(ImageSource.camera),
              child: Row(
                children: [
                  Icon(Icons.camera_alt_rounded, color: Colors.blueAccent),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Take a photo',
                    style: TextStyle(color: Colors.blueAccent, fontSize: 20),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
