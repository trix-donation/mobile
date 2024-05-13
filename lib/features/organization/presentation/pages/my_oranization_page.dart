import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trix_donation/core/theme/text_style.dart';
import 'package:trix_donation/features/organization/presentation/manager/my_organization_cubit.dart';

class MyOrganizationPage extends StatefulWidget {
  const MyOrganizationPage({super.key});

  @override
  State<MyOrganizationPage> createState() => _MyOrganizationPageState();
}

class _MyOrganizationPageState extends State<MyOrganizationPage> {
  MyOrganizationCubit myOrganizationCubit = MyOrganizationCubit();

  @override
  void initState() {
    myOrganizationCubit.initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyOrganizationCubit, MyOrganizationState>(
      bloc: myOrganizationCubit,
      listener: (context, state) {
        if (state is MyOrganizationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }

        if (state is MyOrganizationRequestCreateSend) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
              content: Text(
                state.message,
                style: bodyMediumText.copyWith(
                    color: Theme.of(context).colorScheme.onTertiaryContainer),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is MyOrganizationLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is MyOrganizationNotCreated) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Організація не створена',
                  style: bodySemiBoldText,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/creating_organization');
                  },
                  child: Text('Створити організацію'),
                ),
              ],
            ),
          );
        }

        if (state is MyOrganizationLoaded) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('My Organization'),
                SizedBox(height: 20),
                Text('Organization Name:'),
                Text('Organization Description:'),
                Text('Organization Address:'),
                Text('Organization Phone:'),
                Text('Organization Email:'),
                Text('Organization Website:'),
              ],
            ),
          );
        }

        return Center(
          child: Text('Error'),
        );
      },
    );
  }
}
