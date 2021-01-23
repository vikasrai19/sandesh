import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatUserHeader extends StatelessWidget {
  final String name;
  final String imgUrl;

  const ChatUserHeader({Key key, this.name, this.imgUrl}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor, shape: BoxShape.circle),
        ),
        SizedBox(height: 20.0),
        Text(
          this.name,
          style: GoogleFonts.montserrat(
              fontSize: 22.0, fontWeight: FontWeight.w500, letterSpacing: -1.2),
        )
      ],
    );
  }
}