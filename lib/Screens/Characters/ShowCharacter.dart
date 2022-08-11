import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_n_morty_fan_app/Screens/Shared/Loading.dart';
import 'package:rick_n_morty_fan_app/bloc/character_bloc/bloc/character_bloc.dart';
import 'package:rick_n_morty_fan_app/bloc/page_blocs/pages_bloc.dart';

class ShowCharacter extends StatefulWidget {
  const ShowCharacter({Key? key}) : super(key: key);

  @override
  State<ShowCharacter> createState() => _ShowCharacterState();
}

class _ShowCharacterState extends State<ShowCharacter> {
  @override
  Widget build(BuildContext context) {
    print('mpika');
    context.read<CharacterBloc>();
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Container(child:
          BlocBuilder<CharacterBloc, CharacterState>(builder: (context, state) {
        return state.character == null
            ? const Loading()
            : Column(
                children: [
                  Text('${state.character?.id}'),
                  Text('${state.character?.name}'),
                  Image.network('${state.character?.image}')
                ],
              );
      })),
    );
  }
}
