import 'package:animations/animations/code_based/buttons/animations/simple3D.dart';
import 'package:flutter/material.dart';

class ButtonsPage extends StatefulWidget {
  const ButtonsPage({Key? key}) : super(key: key);

  @override
  State<ButtonsPage> createState() => _ButtonsPageState();
}

class _ButtonsPageState extends State<ButtonsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 40)),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Center(child: Simple3DButton(title: 'Simple 3D button', onTap: () {})),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
