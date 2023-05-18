import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:vibr/search/search_cubit.dart';
import 'package:vibr/widgets/track_tile.dart';

import '../datasources/isar_datasource.dart';
import '../widgets/section_header.dart';
import 'search_state.dart';

class SearchPanel extends StatelessWidget {
  const SearchPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.read<IsarDataSource>();
    return BlocProvider(
      create: (_) => SearchCubit(db)..load(),
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Icon(Icons.search),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    onSubmitted: (value) =>
                        context.read<SearchCubit>().search(value),
                  ),
                ),
                Expanded(
                  child: ListView(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state.results.isNotEmpty)
                          SectionHeader(title: "Results"),
                        for (final track in state.results) TrackTile(track),
                        SectionHeader(title: "Genres"),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: state.genres
                                .map((genre) => Chip(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .surfaceVariant,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    label: Text(genre)))
                                .toList(),
                          ),
                        ),
                        SectionHeader(title: 'Previous'),
                        for (final search in state.previous)
                          ListTile(
                            title: Text(search.term),
                            trailing: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () =>
                                  context.read<SearchCubit>().remove(search),
                            ),
                          ),
                      ]),
                ),
              ]);
        },
      ),
    );
  }
}
