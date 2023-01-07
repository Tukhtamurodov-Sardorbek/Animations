import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animations'),
        centerTitle: true,
        bottom: TabBar(
          controller: tabController,
          splashFactory: NoSplash.splashFactory,
          splashBorderRadius: BorderRadius.circular(50),
          isScrollable: true,
          indicatorColor: CupertinoColors.activeGreen,
          tabs: const <Widget>[
            Padding(
              padding: EdgeInsets.all(14.0),
              child: Text('TabBar 1'),
            ),
            Padding(
              padding: EdgeInsets.all(14.0),
              child: Text('TabBar 2'),
            ),
            Padding(
              padding: EdgeInsets.all(14.0),
              child: Text('TabBar 3'),
            ),
            Padding(
              padding: EdgeInsets.all(14.0),
              child: Text('TabBar 4'),
            ),
            Padding(
              padding: EdgeInsets.all(14.0),
              child: Text('TabBar 5'),
            ),
            Padding(
              padding: EdgeInsets.all(14.0),
              child: Text('TabBar 6'),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        physics: const BouncingScrollPhysics(),
        children: [
          Container(color: Colors.tealAccent),
          Container(color: Colors.green),
          Container(color: Colors.cyanAccent),
          Container(color: Colors.blue),
          Container(color: Colors.red),
          Container(color: Colors.amber),
        ],
      ),
    );
  }

  // return Scaffold(
  //     body: SafeArea(
  //       child: ListView(
  //         padding: const EdgeInsets.symmetric(vertical: 12),
  //         children: [
  //           HorizontalScrollView(
  //             header: 'Practices',
  //             children: [
  //               Button(
  //                 title: 'Container Animations',
  //                 onTap: () {
  //                   Navigator.push(context, MaterialPageRoute(builder: (BuildContext ctx) => const SimpleContainerAnimations()));
  //                 },
  //               ),
  //           ],
  //       ),
  //           HorizontalScrollView(
  //             header: 'Animations',
  //             children: [
  //               Button(
  //                 title: 'Button Animations',
  //                 onTap: () {
  //                   Navigator.push(context, MaterialPageRoute(builder: (BuildContext ctx) => const ButtonsPage()));
  //                 }
  //               ),
  //           ],
  //       ),
  //           HorizontalScrollView(
  //             header: 'Rive Animations',
  //             children: [
  //               Button(
  //                 title: 'Teddy Sign In',
  //                 onTap: () {
  //                   Navigator.push(context, MaterialPageRoute(builder: (BuildContext ctx) => const SignInPage()));
  //                 },
  //              ),
  //           ],
  //       ),
  //         ],
  //       ),
  //     ),
  // );
  Widget Button({required String title, void Function()? onTap}) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          backgroundColor: Colors.deepPurple.shade600,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: Text(title),
      ),
    );
  }
}

class HorizontalScrollView extends StatelessWidget {
  final String header;
  final List<Widget> children;

  const HorizontalScrollView(
      {Key? key, required this.header, required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.deepPurple.shade600,
            alignment: Alignment.center,
            child: Text(
              header,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: children,
            ),
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
