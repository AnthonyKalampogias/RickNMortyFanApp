import 'package:flutter/material.dart';
import 'package:rick_n_morty_fan_app/Models/ApiPage.dart';
import 'package:rick_n_morty_fan_app/Services/CallAPI.dart';

class Pager extends StatefulWidget {
  const Pager({Key? key}) : super(key: key);

  @override
  State<Pager> createState() => _PagerState();
}

class _PagerState extends State<Pager> {
  int requestedPage = 1;
  late ApiPage page;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ApiPage?>(
      future: fetchPage(requestedPage),
      builder: (context, AsyncSnapshot<ApiPage?> snapshot) {
        if (snapshot.hasData) {
          page = snapshot.data!;
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }
}
