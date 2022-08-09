import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:rick_n_morty_fan_app/bloc/character_bloc.dart';

import 'CharacterList.dart';

class Pager extends StatelessWidget {
  const Pager({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(title: const Text('Posts')),
      body: BlocProvider(
        create: (_) =>
            CharacterBloc(httpClient: http.Client())..add(NextPage()),
        child: const CharactersList(),
      ),
    );
  }
}
