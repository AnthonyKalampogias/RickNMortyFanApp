import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_n_morty_fan_app/bloc/character_bloc.dart';
import 'PostListItem.dart';
import 'Shared/Loading.dart';

class CharactersList extends StatefulWidget {
  const CharactersList({super.key});

  @override
  State<CharactersList> createState() => _CharactersListState();
}

class _CharactersListState extends State<CharactersList> {
  @override
  void initState() {
    print("Build");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) {
          switch (state.status) {
            case Status.failure:
              return const Center(child: Text('failed to fetch Characters'));
            case Status.initial:
              return const Loading();
            case Status.success:
              if (state.pageInfo == null) {
                return const Center(child: Text('no Characters'));
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return index >= state.characters.length
                            ? const Loading()
                            : CharacterListItem(
                                character: state.characters[index]);
                      },
                      itemCount: state.hasReachedMax
                          ? state.characters.length
                          : state.characters.length + 1,
                    ),
                  ),
                  Container(
                    color: Colors.blueGrey[100],
                    child: Row(
                      children: [
                        Column(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.skip_previous),
                              disabledColor: Colors.grey[600],
                              color: Colors.grey[900],
                              tooltip: 'Previous Page',
                              onPressed: state.pageInfo?.prev == null
                                  ? null
                                  : () => context
                                      .read<CharacterBloc>()
                                      .add(PreviousPage()),
                            ),
                          ],
                        ),
                        Column(
                          children: [],
                        ),
                        Column(
                          children: [
                            IconButton(
                                icon: const Icon(Icons.skip_previous),
                                disabledColor: Colors.grey[600],
                                color: Colors.grey[900],
                                tooltip: 'Next Page',
                                onPressed: () {
                                  context.read<CharacterBloc>().add(NextPage());
                                }),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
