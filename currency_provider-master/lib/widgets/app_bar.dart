import 'package:flutter/material.dart';
import 'package:flutter_application_1/utills/constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Currency",
          style: kTextStyle(
            color: Colors.white,
            size: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(25),
          child: Container(
            height: 50,
            width: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white12),
            ),
            child: const Icon(
              Icons.more_vert,
              size: 25,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
