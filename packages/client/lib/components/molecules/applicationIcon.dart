import 'package:flutter/material.dart';
class ApplicationIcon extends StatefulWidget {
  const ApplicationIcon({super.key, required this.title, required this.icon});
  final String title;
  final IconData icon;
  @override
  State<ApplicationIcon> createState() => _ApplicationIconState();
}

class _ApplicationIconState extends State<ApplicationIcon> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        print("Tapped on container");
      },
      child: Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Container(
          decoration: BoxDecoration(),
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                widget.icon,
                size: 50,
              ),
              Text(widget.title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(),)
            ],
          ),
        ),
      ),
    );
  }
}
