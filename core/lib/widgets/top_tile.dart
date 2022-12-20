import 'package:flutter/material.dart';

class TopTitle extends StatelessWidget {
  final double height;
  final double blurRadius;
  final String text;

  const TopTitle({super.key,
    this.height = 100,
    this.blurRadius = 30,
    this.text = 'Info Radio',
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: height + 20,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.lightBlue.shade900.withOpacity(0.9),
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(60),
              bottomRight: Radius.circular(60)),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: const Offset(1.0, 1.0), //(x,y)
              blurRadius: blurRadius,
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 15,),
              Text(
                text,
                style: Theme.of(context).textTheme.headline2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
