import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:trix_donation/core/pages/home_page/home_page.dart';
import 'package:trix_donation/core/storage/first_time_enter_storage.dart';
import 'package:trix_donation/core/theme/colors.dart';
import 'package:trix_donation/core/theme/theme.dart';
import 'package:trix_donation/features/auth/presentation/cubit/auth_check_cubit.dart';
import 'package:trix_donation/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:trix_donation/features/auth/presentation/pages/login_page.dart';
import 'package:trix_donation/features/auth/presentation/pages/register_page.dart';
import 'package:trix_donation/features/onBoarding/presentation/pages/onBoarding_page.dart';
import 'package:trix_donation/features/organization/presentation/pages/creating_organization_page.dart';
import 'package:trix_donation/features/personal_profile/presentation/pages/personal_profile_page.dart';

import 'core/interceptors/access_interceptor.dart';
import 'core/storage/token_storage.dart';
import 'features/auth/presentation/pages/welcome_auth_page.dart';
import 'features/create_collection/presentation/pages/create_collection_page.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  GetIt.I.registerSingleton<Dio>(Dio());
  addInterceptors(GetIt.I<Dio>());

  GetIt.I.registerSingleton<FirstTimeEnterStorage>(FirstTimeEnterStorage());
  GetIt.I<FirstTimeEnterStorage>().checkFirstTimeEnter();

  Future.delayed(const Duration(seconds: 1), () {
    runApp(const MyApp());
  });
}

void addInterceptors(Dio dio) {
  dio.interceptors.add(PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    responseHeader: true,
  ));
  // dio.interceptors.add(ContentTypeInterceptor());
  dio.interceptors.add(AccessInterceptor());
  dio.interceptors.add(InterceptorsWrapper(
    onError: (error, handler) async {
      if (error.response?.data['code'] == 'token_not_valid') {
        TokenStorage.updateAccessToken();
        // if (message == "update_all") {
        //   // SharedPreferences.getInstance().then((value) => value.clear());
        //   // Navigator.pushNamedAndRemoveUntil(GetIt.I(), '/login', (route) => false);
        // }
      }
      return handler.next(error);
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TRIX Donation',
        theme: ThemeData(
          colorScheme: MaterialTheme.lightScheme().toColorScheme(),
          useMaterial3: true,
          textTheme: CustomTextTheme().customTextTheme(),
        ),
        darkTheme: ThemeData(
          colorScheme: MaterialTheme.darkScheme().toColorScheme(),
          useMaterial3: true,
          textTheme: CustomTextTheme().customTextTheme(),
        ),
        themeMode: ThemeMode.system,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/login':
              return PageTransition(
                child: const LoginPage(),
                type: PageTransitionType.rightToLeftWithFade,
              );
            case '/register':
              return PageTransition(
                child: const RegisterPage(),
                type: PageTransitionType.rightToLeftWithFade,
              );
            case '/forgot_password':
              return PageTransition(
                child: const ForgotPasswordPage(),
                type: PageTransitionType.bottomToTop,
              );
            case '/personal_profile':
              return PageTransition(
                child: const PersonalProfilePage(),
                type: PageTransitionType.rightToLeftWithFade,
              );
            case '/creating_organization':
              return PageTransition(
                child: const CreatingOrganizationPage(),
                type: PageTransitionType.rightToLeftWithFade,
              );
            case '/create_collection':
              return PageTransition(
                child: const CreateCollectionPage(),
                type: PageTransitionType.topToBottom,
                duration: const Duration(milliseconds: 800),
              );
            default:
              return null;
          }
        },
        routes: {
          '/': (context) => const StartingApp(),
          '/welcome_auth': (context) => const WelcomeAuthPage(),
          '/home': (context) => const HomePage(),
          '/onBoarding': (context) => const OnBoardingPage(),
        });
  }
}

class StartingApp extends StatefulWidget {
  const StartingApp({super.key});

  @override
  State<StartingApp> createState() => _StartingAppState();
}

class _StartingAppState extends State<StartingApp> {
  AuthCheckCubit authCheckCubit = AuthCheckCubit();

  @override
  void initState() {
    authCheckCubit.checkTokens();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.5),
            radius: 1,
            colors: [
              primary100Color,
              accent200Color,
            ],
          ),
        ),
        child: Center(
          child: BlocConsumer(
              bloc: authCheckCubit,
              builder: (context, state) {
                return const CircularProgressIndicator();
              },
              listener: (context, state) {
                if (state is AuthCheckAuthorized) {
                  // open home and close everything else
                  Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                  FlutterNativeSplash.remove();
                  debugPrint("Authorized");
                }
                if (state is AuthCheckUnauthorized) {
                  FlutterNativeSplash.remove();
                  Navigator.pushNamed(context, '/welcome_auth');
                }
              }),
        ),
      ),
    );
  }
}
