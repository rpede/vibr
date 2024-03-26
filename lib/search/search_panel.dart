import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../datasources/isar_datasource.dart';
import '../widgets/section_header.dart';
import '../widgets/track_tile.dart';
import 'search_cubit.dart';
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
                      suffixIcon: const Padding(
                        padding: EdgeInsets.only(right: 12),
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
                          const SectionHeader(title: "Results"),
                        for (final track in state.results) TrackTile(track),
                        const SectionHeader(title: "Genres"),
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
                        const SectionHeader(title: 'Previous'),
                        for (final search in state.previous)
                          ListTile(
                            title: Text(search.term),
                            trailing: IconButton(
                              icon: const Icon(Icons.close),
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
