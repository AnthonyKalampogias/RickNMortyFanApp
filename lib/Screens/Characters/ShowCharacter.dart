import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_n_morty_fan_app/Models/StatusEnum.dart';
import 'package:rick_n_morty_fan_app/Screens/Characters/CharacterDetails.dart';
import 'package:rick_n_morty_fan_app/Screens/Shared/Loading.dart';
import 'package:rick_n_morty_fan_app/Screens/Shared/errorPage.dart';
import 'package:rick_n_morty_fan_app/bloc/character_bloc/character_bloc.dart';

class ShowCharacter extends StatefulWidget {
  ShowCharacter({Key? key, required this.id}) : super(key: key);
  late int id;

  @override
  State<ShowCharacter> createState() => _ShowCharacterState();
}

class _ShowCharacterState extends State<ShowCharacter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: BlocProvider(
        create: (_) => CharacterBloc()..add(FetchCharacter(widget.id)),
        child: Builder(
          builder: (context) => (BlocBuilder<CharacterBloc, CharacterState>(
              builder: (context, state) {
            return state.status == Status.failure
                ? ErrorPage(error: "Couldn't find character")
                : state.character == null
                    ? const Loading()
                    : SafeArea(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    state.character!.name!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: FittedBox(
                                      fit: BoxFit.cover,
                                      child: Image.network(
                                          state.character!.image!)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        WidgetSpan(
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(right: 5),
                                            child: Icon(
                                              Icons.circle,
                                              size: 14,
                                              color: state.character!.status! ==
                                                      'Alive'
                                                  ? Colors.green
                                                  : state.character!.status ==
                                                          'Dead'
                                                      ? Colors.red
                                                      : Colors.grey,
                                            ),
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              '${state.character!.status} ~ ${state.character!.gender}',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                    color: Colors.blueGrey[800],
                                    height: 110,
                                    child: CharacterDetails(
                                        char: state.character!)),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: ElevatedButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.green,
                                    fixedSize: const Size(300, 50),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50))),
                                child: const Text(
                                  "Back to list",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 25),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
          })),
        ),
      ),
    );
  }
}
