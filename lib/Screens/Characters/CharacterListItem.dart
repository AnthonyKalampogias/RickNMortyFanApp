import 'package:flutter/material.dart';
import 'package:rick_n_morty_fan_app/Models/Character.dart';
import 'package:rick_n_morty_fan_app/Screens/Characters/ShowCharacter.dart';

class CharacterListItem extends StatelessWidget {
  const CharacterListItem({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.blueGrey[900],
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: Colors.blueGrey[600],
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(character.image!),
            ),
            title: Text(
              character.name!,
              style: const TextStyle(color: Colors.white),
            ),
            isThreeLine: true,
            subtitle: RichText(
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
            dense: false,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ShowCharacter(id: character.id!)),
              );
            },
          ),
        ));
  }
}
