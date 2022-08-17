import 'package:flutter/material.dart';
import 'package:rick_n_morty_fan_app/Models/Character.dart';

class CharacterDetails extends StatefulWidget {
  CharacterDetails({super.key, required this.char});

  late Character char;
  @override
  State<CharacterDetails> createState() => _CharacterDetailsState();
}

class _CharacterDetailsState extends State<CharacterDetails> {
  @override
  Widget build(BuildContext context) {
    var character = widget.char;
    return ListView(
      children: [
        Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                const TextSpan(
                    text: "Species: \n", style: TextStyle(color: Colors.grey)),
                TextSpan(text: character.species),
              ]),
            )),
        Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                const TextSpan(
                    text: "Type: \n", style: TextStyle(color: Colors.grey)),
                TextSpan(
                    text: character.type == '' ? 'Unknown' : character.type),
              ]),
            )),
        Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                const TextSpan(
                    text: "Last Known Location: \n",
                    style: TextStyle(color: Colors.grey)),
                TextSpan(text: character.location!.name),
              ]),
            )),
        Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                const TextSpan(
                    text: "First seen in: \n",
                    style: TextStyle(color: Colors.grey)),
                TextSpan(text: character.origin!.name),
              ]),
            )),
      ],
    );
  }
}
