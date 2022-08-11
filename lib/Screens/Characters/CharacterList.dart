import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_n_morty_fan_app/bloc/page_blocs/pages_bloc.dart';
import 'CharacterListItem.dart';
import '../Shared/Loading.dart';

class CharactersList extends StatefulWidget {
  const CharactersList({super.key});

  @override
  State<CharactersList> createState() => _CharactersListState();
}

class _CharactersListState extends State<CharactersList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: BlocBuilder<PageBloc, PageState>(
        builder: (context, state) {
          switch (state.status) {
            case Status.failure:
              return const Center(
                  child: Text(
                      "We couldn't fetch any characters, please try again!"));
            case Status.initial:
              return const Loading();
            case Status.success:
              if (state.pageInfo == null) {
                return const Center(child: Text('No Characters found'));
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: const EdgeInsets.all(15.0),
                            child: CharacterListItem(
                                character: state.characters[index]),
                          );
                        },
                        itemCount: state.characters.length),
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
                                      .read<PageBloc>()
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
                                icon: const Icon(Icons.skip_next),
                                disabledColor: Colors.grey[600],
                                color: Colors.grey[900],
                                tooltip: 'Next Page',
                                onPressed: state.pageInfo?.next == null
                                    ? null
                                    : () => context
                                        .read<PageBloc>()
                                        .add(NextPage())),
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
