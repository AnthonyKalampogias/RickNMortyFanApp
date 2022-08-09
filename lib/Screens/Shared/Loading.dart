import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const [
          SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(strokeWidth: 1.5),
          ),
          Text("Loading...")
        ],
      ),
    );
  }
}
