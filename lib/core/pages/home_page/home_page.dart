import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trix_donation/features/onBoarding/presentation/cubit/on_boarding_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final OnBoardingCubit _onBoardingCubit = OnBoardingCubit();

  @override
  void initState() {
    super.initState();
    //after the widget is rendered, check if onboarding is needed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _onBoardingCubit.checkOnBoarding();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnBoardingCubit, OnBoardingState>(
      bloc: _onBoardingCubit,
      listener: (context, state) {
        if (state is OnBoardingNeeded) {
          // open on boarding and close everything else
          Navigator.pushNamedAndRemoveUntil(context, '/onBoarding', (route) => false);
        }
      },
      child: const Scaffold(
        body: Center(
          child: Text('Home Page'),
        ),
      ),
    );
  }
}
