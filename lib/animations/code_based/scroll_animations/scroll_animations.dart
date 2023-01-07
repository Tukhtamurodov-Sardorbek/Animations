import 'package:flutter/material.dart';
import 'dart:math';

class TestAnimation extends StatefulWidget {
  const TestAnimation({Key? key}) : super(key: key);

  @override
  State<TestAnimation> createState() => _TestAnimationState();
}

class _TestAnimationState extends State<TestAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
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
            // TransitionAppBar(
            //   // extent: 250,
            //   extent: 300,
            //   avatar: Container(
            //     decoration: const BoxDecoration(
            //         image: DecorationImage(
            //             image: AssetImage(
            //                 'assets/images/user-avatar.png'), // NetworkImage(user.imageUrl),
            //             fit: BoxFit.cover)),
            //   ),
            //   title: "Emmanuel Olu-Flourish",
            // ),
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

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  MySliverAppBar({
    required this.title,
    required this.minWidth,
    required this.minHeight,
    required this.leftMaxWidth,
    required this.leftMaxHeight,
    required this.rightMaxWidth,
    required this.rightMaxHeight,
    this.titleStyle = const TextStyle(fontSize: 26),
    this.shrinkedTopPos = 0,
  });

  final String title;
  final TextStyle titleStyle;
  final double minWidth;
  final double minHeight;
  final double leftMaxWidth;
  final double leftMaxHeight;
  final double rightMaxWidth;
  final double rightMaxHeight;

  final double shrinkedTopPos;

  final GlobalKey _titleKey = GlobalKey();

  double? _topPadding;
  double? _centerX;
  Size? _titleSize;

  double get _shrinkedTopPos => _topPadding! + shrinkedTopPos;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent,) {
    _topPadding ??= MediaQuery.of(context).padding.top;
    _centerX ??= MediaQuery.of(context).size.width / 2;
    _titleSize ??= _calculateTitleSize(title, titleStyle);

    double percent = shrinkOffset / (maxExtent - minExtent);
    percent = percent > 1 ? 1 : percent;

    return Container(
      color: Colors.red,
      child: Stack(
        children: <Widget>[
          _buildTitle(shrinkOffset),
          _buildLeftImage(percent),
          _buildRightImage(percent),
        ],
      ),
    );
  }

  Size _calculateTitleSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  Widget _buildTitle(double shrinkOffset) => Align(
    alignment: Alignment.topCenter,
    child: Padding(
      padding: EdgeInsets.only(top: _topPadding!),
      child: Opacity(
        opacity: shrinkOffset / maxExtent,
        child: Text(title, key: _titleKey, style: titleStyle),
      ),
    ),
  );

  double getScaledWidth(double width, double percent) => width - ((width - minWidth) * percent);

  double getScaledHeight(double height, double percent) => height - ((height - minHeight) * percent);

  /// 20 is the padding between the image and the title
  double get shrinkedHorizontalPos => (_centerX! - (_titleSize!.width / 2)) - minWidth - 20;

  Widget _buildLeftImage(double percent) {
    final double topMargin = minExtent;
    final double rangeLeft =
        (_centerX! - (leftMaxWidth / 2)) - shrinkedHorizontalPos;
    final double rangeTop = topMargin - _shrinkedTopPos;

    final double top = topMargin - (rangeTop * percent);
    final double left =
        (_centerX! - (leftMaxWidth / 2)) - (rangeLeft * percent);

    return Positioned(
      left: left,
      top: top,
      child: Container(
        width: getScaledWidth(leftMaxWidth, percent),
        height: getScaledHeight(leftMaxHeight, percent),
        color: Colors.black,
      ),
    );
  }

  Widget _buildRightImage(double percent) {
    final double topMargin = minExtent + (rightMaxHeight / 2);
    final double rangeRight =
        (_centerX! - (rightMaxWidth / 2)) - shrinkedHorizontalPos;
    final double rangeTop = topMargin - _shrinkedTopPos;

    final double top = topMargin - (rangeTop * percent);
    final double right =
        (_centerX! - (rightMaxWidth / 2)) - (rangeRight * percent);

    return Positioned(
      right: right,
      top: top,
      child: Container(
        width: getScaledWidth(rightMaxWidth, percent),
        height: getScaledHeight(rightMaxHeight, percent),
        color: Colors.white,
      ),
    );
  }

  @override
  double get maxExtent => 300;

  @override
  double get minExtent => _topPadding! + 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

class TransitionAppBar extends StatelessWidget {
  final Widget avatar;
  final String title;
  final double extent;

  const TransitionAppBar({required this.avatar, required this.title, this.extent = 250, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _TransitionAppBarDelegate(
          avatar: avatar, title: title, extent: extent > 200 ? extent : 200),
    );
  }
}

class _TransitionAppBarDelegate extends SliverPersistentHeaderDelegate {
  final _avatarMarginTween = EdgeInsetsTween(
    end: const EdgeInsets.only(left: 14.0, top: 36.0),
  );

  final _titleMarginTween = EdgeInsetsTween(
    begin: const EdgeInsets.only(bottom: 20),
    end: const EdgeInsets.only(left: 64.0, top: 45.0),
  );

  final _avatarAlignTween =
  AlignmentTween(begin: Alignment.bottomCenter, end: Alignment.topLeft);
  final _iconAlignTween =
  AlignmentTween(begin: Alignment.bottomRight, end: Alignment.topRight);

  final Widget avatar;
  final String title;
  final double extent;

  _TransitionAppBarDelegate({required this.avatar, required this.title, this.extent = 250})
      : assert(extent >= 200);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double tempVal = 72 * maxExtent / 100;
    final progress = shrinkOffset > tempVal ? 1.0 : shrinkOffset / tempVal;
    final avatarMargin = _avatarMarginTween.lerp(progress);
    final titleMargin = _titleMarginTween.lerp(progress);

    final avatarAlign = _avatarAlignTween.lerp(progress);
    final iconAlign = _iconAlignTween.lerp(progress);

    final avatarSize = (1 - progress) * 200 + 32;

    return Stack(
      children: <Widget>[
        AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          height: 80,
          constraints: BoxConstraints(maxHeight: minExtent),
          color: Colors.white,
        ),
        Padding(
          padding: avatarMargin,
          child: Align(
            alignment: avatarAlign,
            child: SizedBox(
              height: avatarSize,
              width: avatarSize,
              child: avatar,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            height: progress < 0.4 ? 100 * (1 - progress) * 1.5 : 0,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.pink[200]!.withOpacity(0.05),
                      Colors.pink[400]!.withOpacity(0.8),
                    ])),
          ),
        ),
        Padding(
          padding: titleMargin,
          child: Align(
            alignment: avatarAlign,
            child: Text(
              title,
              style: TextStyle(
                color: progress < 0.4 ? Colors.white : Colors.black,
                fontSize: 18 + (5 * (1 - progress)),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Padding(
          padding: titleMargin,
          child: Align(
            alignment: iconAlign,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: GestureDetector(
                onTap: () {
                },
                child: Icon(
                  Icons.search,
                  size: 30,
                  color: progress < 0.4 ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => extent;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(_TransitionAppBarDelegate oldDelegate) {
    return avatar != oldDelegate.avatar || title != oldDelegate.title;
  }
}