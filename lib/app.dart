import 'package:bloc_ecommerce/src/blocs/blocs.dart';
import 'package:bloc_ecommerce/src/routes/route_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'theme/theme.dart';

class BlocEcommerceApp extends StatelessWidget {
  const BlocEcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SplashCubit()..endSplash(),
          ),
          BlocProvider(create: (context) => RememberSwitchCubit()),
          BlocProvider(create: (context) => SignupBloc()),
        ],
        child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return MaterialApp.router(
              theme: const MaterialTheme(TextTheme()).light(),
              darkTheme: const MaterialTheme(TextTheme()).dark(),
              debugShowCheckedModeBanner: false,
              routerConfig: RoutePages.ROUTER,
            );
          },
        ));
  }
}
