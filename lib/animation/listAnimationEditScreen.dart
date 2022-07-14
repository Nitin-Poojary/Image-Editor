import 'package:flutter/material.dart';

import '../widgets/bottomlist.dart';

class ListAnimation extends StatefulWidget {
  const ListAnimation({Key? key, required this.listItems}) : super(key: key);
  final listItems;

  @override
  State<ListAnimation> createState() => _ListAnimationState();
}

class _ListAnimationState extends State<ListAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _listAnimationController;
  late Animation<Offset> _animation;
  late Animation<double> _opacity;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listAnimationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _listAnimationController.addListener(() {});

    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _listAnimationController, curve: Curves.fastOutSlowIn));

    _animation = Tween<Offset>(begin: const Offset(0.0, 50.0), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: _listAnimationController, curve: Curves.fastOutSlowIn));

    _listAnimationController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _listAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _listAnimationController,
      builder: (context, child) {
        return Opacity(
          opacity: _opacity.value,
          child: Transform.translate(
            offset: _animation.value,
            child: child,
          ),
        );
      },
      child: SizedBox(
        height: 60,
        child: EditImagePageList(listItems: widget.listItems),
      ),
    );
  }
}
