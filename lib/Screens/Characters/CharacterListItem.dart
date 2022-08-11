import 'package:flutter/material.dart';
import 'package:rick_n_morty_fan_app/Models/Character.dart';
import 'package:rick_n_morty_fan_app/Screens/Characters/ShowCharacter.dart';

class CharacterListItem extends StatelessWidget {
  const CharacterListItem({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ShowCharacter(id: character.id!)));
      },
      child: Container(
        color: Colors.blueGrey[900],
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Container(
            color: Colors.blueGrey[600],
            height: 140,
            child: Row(children: [
              Expanded(
                flex: 6,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(character.image!),
                          fit: BoxFit.fill)),
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 15,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(character.name!,
                        style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Container(
                              margin: const EdgeInsets.only(right: 5),
                              child: Icon(
                                Icons.circle,
                                size: 14,
                                color: character.status! == 'Alive'
                                    ? Colors.green
                                    : character.status == 'Dead'
                                        ? Colors.red
                                        : Colors.grey,
                              ),
                            ),
                          ),
                          TextSpan(
                            text: '${character.status} ~ ${character.gender}',
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(children: [
                        const TextSpan(
                            text: "Last Known Location: \n",
                            style: TextStyle(color: Colors.grey)),
                        TextSpan(text: character.location!.name),
                      ]),
                    ),
                    RichText(
                      text: TextSpan(children: [
                        const TextSpan(
                            text: "First seen in: \n",
                            style: TextStyle(color: Colors.grey)),
                        TextSpan(
                          text: character.origin!.name,
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
