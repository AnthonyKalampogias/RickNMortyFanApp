import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_n_morty_fan_app/Screens/Shared/errorPage.dart';
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

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: BlocBuilder<PageBloc, PageState>(
        builder: (context, state) {
          switch (state.status) {
            case Status.failure:
              return ErrorPage(
                  error: "We couldn't fetch any characters, please try again!");
            case Status.initial:
              return const Loading();
            case Status.success:
              if (state.pageInfo == null) {
                return ErrorPage(error: 'No Characters found');
              }
              return Column(
                children: [
                  Flexible(
                    child: ListView.builder(
                        shrinkWrap: true,
                        controller: _scrollController,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: const EdgeInsets.all(5),
                            child: CharacterListItem(
                                character: state.characters[index]),
                          );
                        },
                        itemCount: state.characters.length),
                  ),
                  Container(
                    color: Colors.blueGrey[800],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            icon: const Icon(Icons.skip_previous),
                            disabledColor: Colors.grey[600],
                            color: Colors.white,
                            tooltip: 'Previous Page',
                            onPressed: state.pageInfo?.prev == null
                                ? null
                                : () {
                                    setState(() {
                                      // On pressed scroll to top and get previous page from bloc
                                      _scrollController.animateTo(
                                        _scrollController
                                            .position.minScrollExtent,
                                        curve: Curves.easeOut,
                                        duration:
                                            const Duration(milliseconds: 500),
                                      );
                                      context
                                          .read<PageBloc>()
                                          .add(PreviousPage());
                                    });
                                  }),
                        Text(
                          "${state.currentPage ?? 1}/${state.pageInfo?.pages}",
                          style: const TextStyle(color: Colors.white),
                        ),
                        IconButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            icon: const Icon(Icons.skip_next),
                            disabledColor: Colors.grey[600],
                            color: Colors.white,
                            tooltip: 'Next Page',
                            onPressed: state.pageInfo?.next == null
                                ? null
                                : () {
                                    setState(() {
                                      // On pressed scroll to top and get next page from bloc
                                      _scrollController.animateTo(
                                        _scrollController
                                            .position.minScrollExtent,
                                        curve: Curves.easeOut,
                                        duration:
                                            const Duration(milliseconds: 500),
                                      );
                                      context.read<PageBloc>().add(NextPage());
                                    });
                                  }),
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
