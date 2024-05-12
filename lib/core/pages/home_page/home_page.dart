import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trix_donation/core/cubits/get_collections/GetCollectionsModel.dart';
import 'package:trix_donation/core/cubits/get_collections/get_collections_cubit.dart';
import 'package:trix_donation/core/theme/text_style.dart';
import 'package:trix_donation/core/widgets/zbir_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GetCollectionsCubit getCollectionsCubit = GetCollectionsCubit();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    getCollectionsCubit.getCollectionsFromNewToOld();
  }

  int _bottomNavIndex = 0;

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_rounded),
            onPressed: () {},
          ),
        ],
        title: const Center(child: Text('TRIX Donation')),
      ),
      body: Padding(
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
              void _onScroll() async {
                if (_scrollController.position.pixels >=
                    _scrollController.position.maxScrollExtent) {
                  if (state.getCollectionModel.next == null) {
                    return;
                  }
                  GetCollectionsModel? getCollectionsModel = await getCollectionsCubit
                      .getCollectionNextPage(state.getCollectionModel.next);

                  setState(() {
                    if (getCollectionsModel != null) {
                      getCollectionsCubit.addOtherCollections(getCollectionsModel);
                    }
                  });
                }
              }

              // _scrollController.removeListener(_onScroll);
              _scrollController.addListener(_onScroll);

              return ListView.separated(
                controller: _scrollController,
                itemCount: state.getCollectionModel.results.length,
                itemBuilder: (context, index) {
                  return ZbirCard(
                    organizationName: 'Хтось',
                    organizationType: 'Щось',
                    collectionImage: state.getCollectionModel.results[index].preview,
                    collectionTitle: state.getCollectionModel.results[index].goalTitle,
                    collectionDescription: state.getCollectionModel.results[index].description,
                    collectionCollectedAmount: double.parse(
                            state.getCollectionModel.results[index].collectedAmountOnPlatform) +
                        double.parse(state.getCollectionModel.results[index].collectedAmountOnJar) +
                        double.parse(state
                            .getCollectionModel.results[index].collectedAmountFromOtherRequisites),
                    collectionGoalAmount:
                        double.parse(state.getCollectionModel.results[index].goalAmount),
                    collectionId: state.getCollectionModel.results[index].id,
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: bodySemiBold14Text,
        unselectedLabelStyle: bodyMedium14Text,
        onTap: (index) {
          _bottomNavIndex = index;
          switch (index) {
            case 0:
              // Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
              _scrollController.jumpTo(0);
              getCollectionsCubit.getCollectionsFromNewToOld();
              break;
            case 1:
              Navigator.pushNamedAndRemoveUntil(context, '/search', (route) => false);
              break;
            case 2:
              Navigator.pushNamedAndRemoveUntil(context, '/community', (route) => false);
              break;
            case 3:
              Navigator.pushNamedAndRemoveUntil(context, '/organization', (route) => false);
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Головна',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Пошук',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_people_rounded),
            label: 'Спільнота',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business_center_rounded),
            label: 'Організація',
          ),
        ],
      ),
    );
  }
}
