import 'package:bloc_ecommerce/src/blocs/blocs.dart';
import 'package:bloc_ecommerce/src/blocs/store/brand_bloc.dart';
import 'package:bloc_ecommerce/src/blocs/store/product_bloc.dart';
import 'package:bloc_ecommerce/src/data/repository/product_repository.dart';
import 'package:bloc_ecommerce/src/data/repository/repository.dart';
import 'package:bloc_ecommerce/src/data/repository/srote_repository.dart';
import 'package:bloc_ecommerce/src/routes/route_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'theme/theme.dart';

class BlocEcommerceApp extends StatelessWidget {
  const BlocEcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => AuthRepository()),
          RepositoryProvider(create: (context) => ProfileRepository()),
          RepositoryProvider(create: (context) => StoreRepository()),
          RepositoryProvider(create: (context) => ProductRepository()),
        ],
        child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => SplashCubit()..startSplash(),
              ),
              BlocProvider(create: (context) => RememberSwitchCubit()),
              BlocProvider(
                  create: (context) =>
                      SignupBloc(context.read<AuthRepository>())),
              BlocProvider(
                  create: (context) =>
                      LoginBloc(context.read<AuthRepository>())),
              BlocProvider(
                  create: (context) =>
                      BrandBloc(context.read<StoreRepository>())
                        ..add(const FetchBrands())),
              BlocProvider(
                  create: (context) =>
                      ProductBloc(context.read<ProductRepository>())
                        ..add(const FetchProducts())),
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
            )));
  }
}
