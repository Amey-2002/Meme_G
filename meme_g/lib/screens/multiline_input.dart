// import 'package:flutter/material.dart';

// class MultiLineInput extends StatelessWidget {
//   const MultiLineInput({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(18.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12.0),
//         boxShadow: [
//           BoxShadow(
//             blurRadius: 15,
//             offset: Offset(0.0, 15.0),
//             color: Colors.black,
//           ),
//         ],
//       ),
//       child: TextField(
//         textInputAction: TextInputAction.newline,
//         keyboardType: TextInputType.multiline,
//         maxLines: 5,
//         decoration: InputDecoration(
//           border: InputBorder.none,
//           hintText: 'Additional Comment',
//           hintStyle: TextStyle(
//             color: Colors.black,
//           ),
//         ),
//         onChanged: (value) {
//           print("The value entered is : $value");
//         },
//       ),
//     );
//   }
// }
