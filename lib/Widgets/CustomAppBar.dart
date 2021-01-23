import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget {
  final String name;
  final IconData icon1;
  final IconData icon2;

  const CustomAppBar({Key key, this.name, this.icon1, this.icon2}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name,
            style: GoogleFonts.montserrat(
                fontSize: 28.0, fontWeight: FontWeight.w500)),
        Row(
          children: [
            Icon(
              // Icons.search_sharp,
              icon1,
              color: Colors.black,
              size: 28.0,
            ),
            Icon(
              // Icons.more_vert,
              icon2, 
              color: Colors.black, size: 28),
          ],
        ),
      ],
    );
  }
}