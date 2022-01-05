import 'package:flutter/material.dart';

import 'collage_screen.dart';

class MenuEntry extends StatelessWidget {
  const MenuEntry({
    Key? key,
    required this.title,
    required this.imageName,
    required this.destination,
  }) : super(key: key);

  final String title;
  final Widget destination;
  final String imageName;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () {
           Navigator.push(
             context,
             MaterialPageRoute<void>(
               builder: (context) => destination,
             ),
          );
        },
        child: Stack(
          children: [
            Image.asset(
              'assets/gridtiles/$imageName.jpg',
              fit: BoxFit.fill,
            ),
            Positioned.fill(
              child: FractionallySizedBox(
                heightFactor: 0.25,
                alignment: Alignment.bottomCenter,
                child: ColoredBox(
                  color: Colors.black.withOpacity(0.75),
                  child: Center(
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GridMenu  extends StatefulWidget {
  //const ({ Key? key }) : super(key: key);
   static const String route = "GridMenuRoute";
  @override
  State<GridMenu> createState() => _GridMenuState();
}

class _GridMenuState extends State<GridMenu> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Grid Menu"),),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        children: [
          MenuEntry(
            title: 'Staggered',
            imageName: 'staggered1',
            destination: StaggeredPage.grid(1),
          ),
           MenuEntry(
            title: 'Staggered',
            imageName: 'staggered2',
            destination: StaggeredPage.grid(2),
          ),
           MenuEntry(
            title: 'Staggered',
            imageName: 'staggered4',
            destination: StaggeredPage.grid(4),
          ),
           MenuEntry(
            title: 'Staggered',
            imageName: 'staggered6',
            destination: StaggeredPage.grid(6),
          ),
          
        ],
      ),
    );
  }
}
