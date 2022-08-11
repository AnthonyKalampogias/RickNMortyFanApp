import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:rick_n_morty_fan_app/bloc/character_bloc/bloc/character_bloc.dart';
import 'package:rick_n_morty_fan_app/bloc/page_blocs/pages_bloc.dart';

import 'Characters/CharacterList.dart';

class Pager extends StatelessWidget {
  const Pager({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => PageBloc(httpClient: http.Client())..add(NextPage()),
          ),
          BlocProvider(
            create: (_) => CharacterBloc()..add(const FetchCharacter(0)),
          ),
        ],
        child: const CharactersList(),
      ),
    );
  }
}
