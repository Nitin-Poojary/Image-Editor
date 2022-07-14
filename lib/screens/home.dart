import 'package:flutter/material.dart';
import 'package:imageeditor/model/savedimages.dart';
import 'package:imageeditor/provider/saveImagesProvider.dart';
import 'package:imageeditor/screens/viewimage/viewimage.dart';
import 'package:provider/provider.dart';

import '../helperclasses/homescreenhelperclass.dart';
import '../model/imagemodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends HomeScreenHelper {
  @override
  Widget build(BuildContext context) {
    List<SavedImages> imageList = Provider.of<SaveImages>(context).imagePaths;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Editor'),
      ),
      body: imageList.isNotEmpty
          ? CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    color: Colors.grey[400],
                    child: Row(
                      children: const [
                        Text("Saved Images"),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(4.0),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 3,
                      mainAxisSpacing: 3,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      childCount: imageList.length,
                      (context, index) => InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ViewImage(
                                imagePath:
                                    imageList[index].savedImagePath.toString(),
                              ),
                            )),
                        child: HomeScreenImages(
                          imagePath: imageList[index].savedImagePath.toString(),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          : const Center(
              child: Text('No images'),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addImage(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
