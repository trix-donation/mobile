import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trix_donation/core/theme/colors.dart';
import 'package:trix_donation/core/theme/text_style.dart';
import 'package:trix_donation/features/spilnota/presentation/cubit/get_organizations_cubit.dart';

class SpilnotaPage extends StatefulWidget {
  const SpilnotaPage({super.key});

  @override
  State<SpilnotaPage> createState() => _SpilnotaPageState();
}

class _SpilnotaPageState extends State<SpilnotaPage> {
  GetOrganizationsCubit getOrganizationsCubit = GetOrganizationsCubit();

  @override
  void initState() {
    getOrganizationsCubit.getOrganizations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetOrganizationsCubit, GetOrganizationsState>(
      bloc: getOrganizationsCubit,
      listener: (context, state) {
        if (state is GetOrganizationsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style:
                    bodyMediumText.copyWith(color: Theme.of(context).colorScheme.onErrorContainer),
              ),
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is GetOrganizationsLoaded) {
          return Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: GridView.builder(
              itemCount: state.organizations.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.shadow.withOpacity(0.3),
                          offset: const Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                          child: CachedNetworkImage(
                              height: 200,
                              width: double.infinity,
                              imageUrl: state.organizations[index].avatar,
                              fit: BoxFit.cover),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            state.organizations[index].name,
                            style: bodySemiBold14Text,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        SizedBox(
                          height: 30,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: accent200Color,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: () {},
                            child: AutoSizeText(
                              maxLines: 2,
                              maxFontSize: 16,
                              'Переглянути',
                              style: bodyMedium14Text.copyWith(
                                  color: Theme.of(context).colorScheme.onBackground),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                      ],
                    ),
                  ),
                );
              },
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 2 / 3.4),
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
