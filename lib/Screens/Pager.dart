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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
        child: FutureBuilder<ApiPage?>(
          future: fetchPage(requestedPage),
          builder: (context, AsyncSnapshot<ApiPage?> snapshot) {
            if (snapshot.hasData) {
              page = snapshot.data!;
              return SingleChildScrollView(
                child: Card(
                  margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(page.results![0].image!),
                    ),
                    title: Text(page.results![0].name!),
                    subtitle: Text("Gender: ${page.results![0].gender!}"),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // By default, show a loading spinner.
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.all(50),
                  child: CircularProgressIndicator(),
                ),
                Text("Loading, Please wait...")
              ],
            ));
          },
        ),
      ),
    );
  }
}
