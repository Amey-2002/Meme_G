import 'package:flutter/material.dart';
import 'package:meme_g/screens/homescreen.dart';

import 'collage_screen.dart';

class MenuEntry extends StatelessWidget {
  const MenuEntry({
    Key? key,
    required this.imageName,
    required this.destination,
  }) : super(key: key);

  final Widget destination;
  final String imageName;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute<void>(
              builder: (context) => destination,
            ),
          );
        },
        child: Image.asset(
          'assets/gridtiles/$imageName.jpg',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class GridMenu extends StatefulWidget {
  //const ({ Key? key }) : super(key: key);
  static const String route = "GridMenuRoute";
  @override
  State<GridMenu> createState() => _GridMenuState();
}

class _GridMenuState extends State<GridMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, Homescreen.route);
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
        title: Text("Grid Menu"),
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        children: [
          MenuEntry(
            imageName: 'staggered1',
            destination: StaggeredPage.grid(1),
          ),
          MenuEntry(
            imageName: 'staggered2',
            destination: StaggeredPage.grid(2),
          ),
          MenuEntry(
            imageName: 'staggered3',
            destination: StaggeredPage.grid(3),
          ),
          MenuEntry(
            imageName: 'staggered3h',
            destination: StaggeredPage.grid(5),
          ),
          MenuEntry(
            imageName: 'staggered4',
            destination: StaggeredPage.grid(4),
          ),
          MenuEntry(
            imageName: 'staggered6',
            destination: StaggeredPage.grid(6),
          ),
        ],
      ),
    );
  }
}
