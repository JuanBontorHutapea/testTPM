// import 'package:flutter/material.dart';

// Widget customDropdown(
//   List<String> items,
//   String value,
//   void onChange(val)
// ) {
//   return Container(
//     padding: EdgeInsets.symmetric(vertical: 4.0,horizontal: 18.0),
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(8)
//     ),
//     child: DropdownButton<String>(
//       value: value,
//       onChanged: (String val){
//         onChange(val);
//       },
//       items: items.map<DropdownMenuItem<String>>?( (String val){
//         return DropdownMenuItem(
//           value: val,
//           child: Text(val),
//           );
//       }),
//     ),
//   );
// }
