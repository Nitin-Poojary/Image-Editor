import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:imageeditor/helperclasses/textedithelperclass.dart';
import 'package:imageeditor/model/savedimages.dart';
import 'package:imageeditor/provider/filterprovider.dart';
import 'package:imageeditor/provider/saveImagesProvider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import '../provider/textprovider.dart';
import '../screens/imageeditscreen.dart';
import '../utils/filters.dart';
import '../utils/permission.dart';

abstract class ImageEditHelper extends State<ImageEdit> with TextEditHelper {
  ScreenshotController ssController = ScreenshotController();

  saveToGallery(BuildContext context) {
    if (Provider.of<TextProvider>(context, listen: false).texts.isNotEmpty ||
        Provider.of<FilterProvider>(context, listen: false).filterMatrix !=
            nofilter) {
      ssController.capture().then((Uint8List? image) async {
        await saveImage(image!, context);
      }).catchError((er) {});
    }
  }

  saveImage(Uint8List image, BuildContext context) async {
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = "screenShot_$time";

    if (await requestPermission(Permission.storage)) {
      if (Platform.isAndroid) {
        Directory? directory = await getExternalStorageDirectory();
        String newPath = '';

        List<String> folders = directory!.path.split('/');
        for (int i = 1; i < folders.length; i++) {
          if (folders[i] != "Android") {
            newPath += "/${folders[i]}";
          } else {
            break;
          }
        }
        newPath += "/Pictures/Image Editor";

        File newDirectory = File("$newPath/$name.jpg");

        if (!await newDirectory.exists()) {
          if (await requestPermission(Permission.manageExternalStorage)) {
            await newDirectory.create(recursive: true);
          }
        }

        if (await newDirectory.exists()) {
          newDirectory.writeAsBytes(image);
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Image saved")));
        }

        saveInSharedPreference(newDirectory.path);
      } else {
        Map path = await ImageGallerySaver.saveImage(
          image,
          name: name,
        );
        saveInSharedPreference(path["filePath"]);
      }
    }
  }

  saveInSharedPreference(String imagePath) async {
    await Provider.of<SaveImages>(context, listen: false)
        .setImagePath(SavedImages(savedImagePath: imagePath));
  }

  removeEdits() {
    Provider.of<TextProvider>(context, listen: false).removeAllTexts();
    Provider.of<FilterProvider>(context, listen: false).removeFilter();
  }
}
