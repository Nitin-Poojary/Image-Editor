import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/textprovider.dart';

class EditImagePageList extends StatelessWidget {
  const EditImagePageList({Key? key, required this.listItems})
      : super(key: key);

  final listItems;

  @override
  Widget build(BuildContext context) {
    TextProvider pr = Provider.of<TextProvider>(context, listen: false);

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      scrollDirection: Axis.horizontal,
      children: [
        for (var e in listItems)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: InkWell(
              onTap: e.onTap,
              child: Column(
                children: [
                  Icon(e.icon),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(e.iconName),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
