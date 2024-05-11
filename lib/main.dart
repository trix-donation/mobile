import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:trix_donation/core/theme/colors.dart';
import 'package:trix_donation/core/theme/theme.dart';
import 'package:trix_donation/features/auth/presentation/cubit/auth_check_cubit.dart';
import 'package:trix_donation/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:trix_donation/features/auth/presentation/pages/login_page.dart';
import 'package:trix_donation/features/auth/presentation/pages/register_page.dart';

import 'core/interceptors/access_interceptor.dart';
import 'core/token_storage.dart';
import 'features/auth/presentation/pages/email_verification_page.dart';
import 'features/auth/presentation/pages/welcome_auth_page.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  GetIt.I.registerSingleton<TokenStorage>(TokenStorage());
  GetIt.I.registerSingleton<Dio>(Dio());
  addInterceptors(GetIt.I<Dio>());

  Future.delayed(const Duration(seconds: 1), () {
    runApp(const MyApp());
  });
}

void addInterceptors(Dio dio) {
  dio.interceptors.add(PrettyDioLogger());
  // dio.interceptors.add(ContentTypeInterceptor());
  dio.interceptors.add(AccessInterceptor());
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
                child: LoginPage(),
                type: PageTransitionType.rightToLeftWithFade,
              );
              break;
            case '/register':
              return PageTransition(
                child: RegisterPage(),
                type: PageTransitionType.rightToLeftWithFade,
              );
              break;
            case '/forgot_password':
              return PageTransition(
                child: ForgotPasswordPage(),
                type: PageTransitionType.bottomToTop,
              );
              break;
            case '/email_verification':
              return PageTransition(
                child: EmailVerificationPage(),
                type: PageTransitionType.rightToLeftWithFade,
              );
              break;
            default:
              return null;
          }
        },
        routes: {
          '/': (context) => const StartingApp(),
          '/welcome_auth': (context) => const WelcomeAuthPage(),
          // '/login': (context) => const LoginPage(),
          '/home': (context) => const WelcomeAuthPage(),
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
                  // Navigator.pushNamed(context, '/home');
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
