import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            height: 100,
            width: 100,
            margin: const EdgeInsets.fromLTRB(0, 150, 0, 25),
            child: Image.asset('assets/images/giphy.gif'),
          ),
          const Text(
            "Loading...",
            style: TextStyle(color: Colors.white, fontSize: 20),
          )
        ],
      ),
    );
  }
}
