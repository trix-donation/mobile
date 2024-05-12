import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trix_donation/core/theme/text_style.dart';
import 'package:trix_donation/core/widgets/zbir_card.dart';
import 'package:trix_donation/features/search/data/models/enum_filter_query.dart';
import 'package:trix_donation/features/search/data/models/foundedCollectionsModel.dart';
import 'package:trix_donation/features/search/presentation/cubit/search_collection_cubit.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchBarController = TextEditingController();

  SearchCollectionCubit searchCollectionCubit = SearchCollectionCubit();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: SearchBar(
                  controller: _searchBarController,
                  onSubmitted: (value) {
                    searchCollectionCubit.searchCollections(value);
                  },
                  hintText: 'Пошук',
                  leading: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
              PopupMenuButton(
                icon: Icon(
                  Icons.filter_alt,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      onTap: () {
                        searchCollectionCubit.filterCollections(
                            FilterQuery.fromOldToNew, _searchBarController.text);
                      },
                      child: Text('Від старих до нових', style: bodyMedium14Text),
                    ),
                    PopupMenuItem(
                        onTap: () {
                          searchCollectionCubit.filterCollections(
                              FilterQuery.fromNewToOld, _searchBarController.text);
                        },
                        child: Text('Від нових до старих', style: bodyMedium14Text)),
                    PopupMenuItem(
                        onTap: () {
                          searchCollectionCubit.filterCollections(
                              FilterQuery.daysPassed30, _searchBarController.text);
                        },
                        child: Text('Збори котрим > 30 днів', style: bodyMedium14Text)),
                    PopupMenuItem(
                        onTap: () {
                          searchCollectionCubit.filterCollections(
                              FilterQuery.toBiggerGoalAmount, _searchBarController.text);
                        },
                        child: Text('За зростанням цільової суми', style: bodyMedium14Text)),
                    PopupMenuItem(
                        onTap: () {
                          searchCollectionCubit.filterCollections(
                              FilterQuery.toSmallerGoalAmount, _searchBarController.text);
                        },
                        child: Text('За спаданням цільової суми', style: bodyMedium14Text)),
                  ];
                },
              )
            ],
          ),
          const SizedBox(height: 26),
          SearchResultList(
            searchQuery: _searchBarController.text,
            searchCollectionCubit: searchCollectionCubit,
          ),
        ],
      ),
    );
  }
}

class SearchResultList extends StatefulWidget {
  const SearchResultList(
      {super.key, required this.searchQuery, required this.searchCollectionCubit});

  final String searchQuery;
  final SearchCollectionCubit searchCollectionCubit;

  @override
  State<SearchResultList> createState() => _SearchResultListState();
}

class _SearchResultListState extends State<SearchResultList> {
  final ScrollController _scrollController = ScrollController();

  FoundedCollectionsModel? searchCollectionModelLocal;

  String? nextCollectionsPage;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        if (nextCollectionsPage != null) {
          loadNextCollections();
        }
      }
    });
  }

  bool isLoadingMore = false;
  void loadNextCollections() async {
    if (isLoadingMore) {
      return;
    }
    isLoadingMore = true;
    FoundedCollectionsModel? foundedCollectionsModel =
        await widget.searchCollectionCubit.getNextPage(nextCollectionsPage!);
    nextCollectionsPage = foundedCollectionsModel?.next;
    setState(() {
      searchCollectionModelLocal!.results.addAll(foundedCollectionsModel!.results);
    });
    isLoadingMore = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCollectionCubit, SearchCollectionState>(
      bloc: widget.searchCollectionCubit,
      listener: (context, state) {
        if (state is SearchCollectionError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
              content: Text(
                state.message,
                style:
                    bodyMediumText.copyWith(color: Theme.of(context).colorScheme.onErrorContainer),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is SearchCollectionInitial) {
          return Center(child: Text('Введіть запит для пошуку', style: bodyMedium14Text));
        }
        if (state is SearchCollectionLoadedSuccessful) {
          searchCollectionModelLocal ??= state.foundedCollectionsModel;
          nextCollectionsPage ??= searchCollectionModelLocal?.next;

          return Expanded(
            child: ListView.separated(
              controller: _scrollController,
              itemCount: searchCollectionModelLocal!.results.length,
              itemBuilder: (context, index) {
                return ZbirCard(
                    collectionImage: searchCollectionModelLocal!.results[index].preview,
                    collectionTitle: searchCollectionModelLocal!.results[index].goalTitle,
                    collectionDescription: searchCollectionModelLocal!.results[index].description,
                    collectionCollectedAmount: double.parse(
                            searchCollectionModelLocal!.results[index].collectedAmountOnJar) +
                        double.parse(state
                            .foundedCollectionsModel.results[index].collectedAmountOnPlatform) +
                        double.parse(searchCollectionModelLocal!
                            .results[index].collectedAmountFromOtherRequisites),
                    collectionGoalAmount:
                        double.parse(searchCollectionModelLocal!.results[index].goalAmount),
                    collectionId: searchCollectionModelLocal!.results[index].id);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 20);
              },
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
