import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'configs/injector/injector_conf.dart';
import 'core/blocs/theme/theme_bloc.dart';
import 'core/blocs/translate/translate_bloc.dart';
import 'core/themes/app_theme.dart';
import 'features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'routes/app_route_conf.dart';
import 'routes/app_route_path.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = getIt<AppRouteConf>().router;
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => GestureDetector(
        onTap: () => primaryFocus?.unfocus(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => getIt<ThemeBloc>(),
            ),
            BlocProvider(
              create: (_) => getIt<TranslateBloc>(),
            ),
            BlocProvider(
              create: (_) =>
                  getIt<AuthBloc>()..add(AuthCheckSignInStatusEvent()),
            ),
          ],
          child: BlocListener<AuthBloc, AuthState>(
            listenWhen: (_, current) =>
                current is AuthCheckSignInStatusSuccessState,
            listener: (_, state) {
              if (state is AuthCheckSignInStatusSuccessState) {
                final user = state.data;
                final userMap = {
                  "user_id": user.userId ?? "",
                  "email": user.email ?? "",
                  "username": user.username ?? "",
                };

                router.goNamed(
                  AppRoute.home.name,
                  pathParameters: userMap,
                );
              }
            },
            child: BlocBuilder<ThemeBloc, ThemeState>(
              builder: (_, state) {
                return MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                  theme: AppTheme.data(state.isDarkMode),
                  routerConfig: router,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
