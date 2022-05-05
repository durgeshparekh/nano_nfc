import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  final String message;

  const CustomProgressBar({required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            color: Colors.grey,
            child: LinearProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.teal),
            ),
          ),
        ],
      ),
    );
  }
}
