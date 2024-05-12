import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trix_donation/core/cubits/get_collections/GetCollectionsModel.dart';

import '../../cubits/get_collections/get_collections_cubit.dart';
import '../../theme/text_style.dart';
import '../../widgets/zbir_card.dart';

class HomePageCollectionsList extends StatefulWidget {
  const HomePageCollectionsList({super.key});

  @override
  State<HomePageCollectionsList> createState() => _HomePageCollectionsListState();
}

class _HomePageCollectionsListState extends State<HomePageCollectionsList> {
  GetCollectionsCubit getCollectionsCubit = GetCollectionsCubit();

  GetCollectionsModel? getCollectionModelLocal;
  String? nextCollectionsPage;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getCollectionsCubit.getCollectionsFromNewToOld();

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
    GetCollectionsModel? getCollectionModelHere =
        await getCollectionsCubit.getCollectionNextPage(nextCollectionsPage!);
    nextCollectionsPage = getCollectionModelHere?.next;
    setState(() {
      getCollectionModelLocal?.results.addAll(getCollectionModelHere!.results);
    });
    isLoadingMore = false;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: BlocConsumer<GetCollectionsCubit, GetCollectionsState>(
        bloc: getCollectionsCubit,
        listener: (context, state) {
          if (state is GetCollectionsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Theme.of(context).colorScheme.errorContainer,
                content: Text(
                  state.error,
                  style: bodyMedium14Text.copyWith(
                      color: Theme.of(context).colorScheme.onErrorContainer),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is GetCollectionsLoadedSuccessful) {
            getCollectionModelLocal ??= state.getCollectionModel;
            nextCollectionsPage ??= getCollectionModelLocal?.next;

            return ListView.separated(
              controller: _scrollController,
              itemCount: getCollectionModelLocal!.results.length,
              itemBuilder: (context, index) {
                return ZbirCard(
                  collectionImage: getCollectionModelLocal!.results[index].preview,
                  collectionTitle: getCollectionModelLocal!.results[index].goalTitle,
                  collectionDescription: getCollectionModelLocal!.results[index].description,
                  collectionCollectedAmount: double.parse(
                          getCollectionModelLocal!.results[index].collectedAmountOnPlatform) +
                      double.parse(getCollectionModelLocal!.results[index].collectedAmountOnJar) +
                      double.parse(getCollectionModelLocal!
                          .results[index].collectedAmountFromOtherRequisites),
                  collectionGoalAmount:
                      double.parse(getCollectionModelLocal!.results[index].goalAmount),
                  collectionId: getCollectionModelLocal!.results[index].id,
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 20);
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
