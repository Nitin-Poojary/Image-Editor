import 'dart:io';

import 'package:flutter/material.dart';
import 'package:imageeditor/model/text.dart';
import 'package:imageeditor/provider/textprovider.dart';
import 'package:provider/provider.dart';

import '../../model/filterlist.dart';
import '../../provider/filterprovider.dart';
import '../../utils/filters.dart';
import '../../widgets/filterlist.dart';
import '../../widgets/textelement.dart';

class FilterHome extends StatefulWidget {
  const FilterHome({Key? key, required this.imagePath}) : super(key: key);

  final String imagePath;

  @override
  State<FilterHome> createState() => _FilterHomeState();
}

class _FilterHomeState extends State<FilterHome> {
  List<Filters> filter = [
    Filters(filterName: "No filter", filterMatrix: nofilter),
    Filters(filterName: "Yellow", filterMatrix: yellow),
    Filters(filterName: "Black and White", filterMatrix: blackNwhite),
    Filters(filterName: "Sepium", filterMatrix: sepium),
  ];

  int currentIndex = 0;
  PageController controller = PageController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FilterProvider pr = Provider.of<FilterProvider>(context, listen: false);

    List<TextInfo> texts = Provider.of<TextProvider>(context).texts;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Hero(
            tag: "cancel",
            child: Icon(
              Icons.cancel_outlined,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              pr.setFilter(filter[currentIndex].filterMatrix);
              Navigator.of(context).pop();
            },
            child: const Hero(
              tag: "done",
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(
                  Icons.done,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Expanded(
            child: PageView.builder(
              controller: controller,
              onPageChanged: (newIndex) {
                currentIndex = newIndex;
                setState(() {});
              },
              itemCount: filter.length,
              itemBuilder: (context, index) {
                return Center(
                  child: Stack(
                    children: [
                      Hero(
                        tag: "EditableImage",
                        child: ColorFiltered(
                          colorFilter:
                              ColorFilter.matrix(filter[index].filterMatrix),
                          child: Image.file(File(widget.imagePath)),
                        ),
                      ),
                      for (int i = 0; i < texts.length; i++)
                        Positioned(
                          top: texts[i].top,
                          left: texts[i].left,
                          child: Hero(
                            tag: "texts",
                            child: DisplayText(
                              textInfo: texts[i],
                              index: i,
                            ),
                          ),
                        )
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filter.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    currentIndex = index;
                    controller.jumpToPage(currentIndex);
                  },
                  child: FilterList(
                    imagePath: widget.imagePath,
                    filterName: filter[index].filterName,
                    filters: filter[index].filterMatrix,
                    isActive: currentIndex == index,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
