// // ignore_for_file: prefer_typing_uninitialized_variables

// import 'package:flutter/material.dart';

// class TextFieldBox extends StatelessWidget {

//   final controller;
//   final String hintText;
//   final bool obscureText;

//   const TextFieldBox({super.key, this.controller, required this.hintText, required this.obscureText});

//   @override
//   Widget build(BuildContext context) {
//     return Container(

      
//       decoration: BoxDecoration(
//           color: Colors.white38,
//           borderRadius: BorderRadius.circular(30),
//         ),

        
//       child: Padding(
        
//         padding: const EdgeInsets.symmetric(horizontal: 35.0),
//         child: TextField(
//           controller: controller,
//           obscureText: obscureText,
//           decoration: InputDecoration(
//             enabledBorder: const OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.white24) 
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.grey.shade200),
//             ),
            
//             // fillColor: Colors.grey.shade200,
//             // // filled: true,
//             hintText: hintText,
//             hintStyle: TextStyle(color: Colors.grey[500]),
//           ),
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';

// class TextFieldBox extends StatelessWidget {
//   final TextEditingController? controller;
//   final String hintText;
//   final bool obscureText;

//   const TextFieldBox({
//     Key? key,
//     this.controller,
//     required this.hintText,
//     required this.obscureText,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white38,
//         borderRadius: BorderRadius.circular(30),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 35.0),
//         child: TextField(
//           controller: controller,
//           obscureText: obscureText,
//           decoration: InputDecoration(
//             enabledBorder: const OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.white24),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.grey.shade200),
//             ),
//             hintText: hintText,
//             hintStyle: TextStyle(color: Colors.grey[500]),
//           ),
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';

// class TextFieldBox extends StatelessWidget {
//   final TextEditingController? controller;
//   final String hintText;
//   final bool obscureText;

//   const TextFieldBox({
//     Key? key,
//     this.controller,
//     required this.hintText,
//     required this.obscureText,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 35.0), // Add horizontal padding
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white38,
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: TextField(
//           controller: controller,
//           obscureText: obscureText,
//           decoration: InputDecoration(
//             enabledBorder: const OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.white24),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.grey.shade200),
//             ),
//             hintText: hintText,
//             hintStyle: TextStyle(color: Colors.grey[500]),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

class CustomOutlineInputBorder extends OutlineInputBorder {
  @override
  final BorderRadius borderRadius;

  const CustomOutlineInputBorder({
    required this.borderRadius,
    borderSide = const BorderSide(),
    gapPadding = 4.0,
  }) : super(
          borderSide: borderSide,
          borderRadius: borderRadius,
          gapPadding: gapPadding,
        );
}

class TextFieldBox extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool obscureText;

  const TextFieldBox({
    Key? key,
    this.controller,
    required this.hintText,
    required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius = BorderRadius.circular(25);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white38,
          borderRadius: borderRadius,
        ),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            enabledBorder: CustomOutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: const BorderSide(color: Colors.white24),
            ),
            focusedBorder: CustomOutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500]),
          ),
        ),
      ),
    );
  }
}
