import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../screens/home.dart';
import '../screens/imageeditscreen.dart';
import '../utils/permission.dart';

abstract class HomeScreenHelper extends State<HomeScreen> {
  pickImageFromGallery() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    return file;
  }

  takeImageFromCamera() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.camera);
    return file;
  }

  addImage() {
    showModalBottomSheet(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.9),
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.86,
          height: MediaQuery.of(context).size.height * 0.23,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(16.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () async {
                  if (await requestPermission(Permission.storage)) {
                    final image = await pickImageFromGallery();
                    if (image != null) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) =>
                              ImageEdit(imagepath: image.path)),
                        ),
                      );
                    }
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.photo_size_select_actual,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text("Gallery"),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (await requestPermission(Permission.camera)) {
                    final image = await takeImageFromCamera();
                    if (image != null) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) =>
                              ImageEdit(imagepath: image.path)),
                        ),
                      );
                    }
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.photo_camera,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text("Camera"),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
