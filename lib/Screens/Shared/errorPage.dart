import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rick_n_morty_fan_app/Screens/Pager.dart';

///To see the error page, turn off any internet connection on your device and press anything to attempt a request on the API
class ErrorPage extends StatefulWidget {
  ErrorPage({Key? key, required this.error}) : super(key: key);

  late String error;

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  //flag to tell Visibility widget to display the try again button after 10 seconds
  bool showButton = false;

  @override
  Widget build(BuildContext context) {
    Timer(
        // if Loading is up for 30 seconds redirect to error page
        const Duration(seconds: 10),
        () => setState(() {
              showButton = true;
            }));

    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: <Widget>[
            FittedBox(
                fit: BoxFit.fitWidth,
                child: Image.asset('assets/images/giphy.gif')),
            Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                    'assets/images/Rick-And-Morty-PNG-HD-Image.png')),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 40, 10, 0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                    widget.error == ''
                        ? "Oh oh an error occured, please try again!"
                        : widget.error,
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                    textAlign: TextAlign.center),
              ),
            ),
            Visibility(
              visible: showButton,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Positioned(
                      child: ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => const Pager()));
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        fixedSize: const Size(300, 25),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                    child: const Text(
                      "Back to Home Screen",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
