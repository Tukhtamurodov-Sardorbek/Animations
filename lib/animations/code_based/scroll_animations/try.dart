import 'dart:math';

import 'package:animations/animations/code_based/scroll_animations/scroll_animations.dart';
import 'package:flutter/material.dart';

class TryPage extends StatefulWidget {
  const TryPage({Key? key}) : super(key: key);

  @override
  State<TryPage> createState() => _TryPageState();
}

class _TryPageState extends State<TryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: MySliverAppBar(
                title: 'Sample',
                minWidth: 50,
                minHeight: 25,
                leftMaxWidth: 200,
                leftMaxHeight: 100,
                rightMaxWidth: 100,
                rightMaxHeight: 50,
                shrinkedTopPos: 10,
              ),
              pinned: true,
            ),
            SliverPersistentHeader(
                pinned: true,
                delegate: MySliver(
                  screenWidth: MediaQuery.of(context).size.width - 32,
                )),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, int i) => Container(
                  height: 50,
                  color: Color.fromARGB(
                    255,
                    Random().nextInt(255),
                    Random().nextInt(255),
                    Random().nextInt(255),
                  ),
                ),
                childCount: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MySliver extends SliverPersistentHeaderDelegate {
  final title = 'Transactions history';
  final titleStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const iconDimension = 60;
  double screenWidth;

  MySliver({required this.screenWidth});

  @override
  double get maxExtent => kToolbarHeight + 80;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant oldDelegate) => false;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final calculatedPercent = shrinkOffset / (maxExtent - minExtent);
    double percent = calculatedPercent > 1 ? 1 : calculatedPercent;

    double pickerWidth = screenWidth - ((screenWidth - iconDimension) * percent);

    return AnimatedContainer(
      height: maxExtent,
      duration: const Duration(milliseconds: 600),
      constraints: BoxConstraints(
        minHeight: minExtent,
        maxHeight: maxExtent,
      ),
      color: Colors.white,
      child: Stack(
        children: [
          titleWidget(tween: percent, width: pickerWidth),
          dateRangePicker(tween: percent, width: pickerWidth),
        ],
      ),
    );
  }


  double titleWidth() {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: title, style: titleStyle),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size.width;
  }

  Widget titleWidget({required double width, required double tween}){

    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      height: kToolbarHeight,
      alignment: tween > 0 && tween < 1 ? Alignment.centerLeft : Alignment.center,

      child: Text(title, style: titleStyle),
    );
  }

  Widget dateRangePicker({required double width, required double tween}) {
    double right = 16 * (1 - tween);
    double top = (maxExtent - kToolbarHeight) * (1 - tween);

    return Positioned(
      right: right,
      top: top,
      child: Container(
        height: kToolbarHeight,
        width: width,
        decoration: width == iconDimension
            ? null
            : BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 16,
                    offset: Offset(0, 12),
                  ),
                ],
              ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            width == screenWidth
                ? const Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      'Date Range Picker',
                      style: TextStyle(
                        color: Colors.purple,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                : const SizedBox.shrink(),
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Icon(Icons.date_range, color: Colors.black)),
          ],
        ),
      ),
    );
  }

  Widget simple() {
    return Container(
      height: 48,
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 16,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              'Date Range Picker',
              style: TextStyle(
                color: Colors.purple,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(Icons.date_range)),
        ],
      ),
    );
  }
}
