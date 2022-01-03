import 'package:flutter/material.dart';

class SelectTemplate extends StatelessWidget {
  const SelectTemplate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          InkWell(
            child: Image.network(
              'https://indianmemetemplates.com/wp-content/uploads/abhi-maza-ayega-na-bhidu.jpg',
              //'https://picsum.photos/$width/$height?random=$index',
              fit: BoxFit.cover,
            ),
            onTap: () {
              
            },
          ),
        ],
      ),
    );
  }
}
