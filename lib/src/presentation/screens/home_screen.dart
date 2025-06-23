import 'package:bloc_ecommerce/src/blocs/blocs.dart';
import 'package:bloc_ecommerce/src/blocs/store/brand_bloc.dart';
import 'package:bloc_ecommerce/src/data/preference/local_preference.dart';
import 'package:bloc_ecommerce/src/presentation/widgets/brand_tile.dart';
import 'package:bloc_ecommerce/src/routes/route_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is SignOutSuccess) {
                context.goNamed(Routes.WELCOME);
              } else if (state is SignOutFailed) {
                Fluttertoast.showToast(msg: state.message);
              }
            },
            child: IconButton(
                onPressed: () {
                  context.read<LoginBloc>().add(RequestSignOut());
                },
                icon: const Icon(Icons.exit_to_app)),
          )
        ],
      ),
      body: Column(
        children: [
          ListTile(
            titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            subtitleTextStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                ),
            title: Text(
              'Hello, ${LocalPreferences.getString('name')}',
            ),
            subtitle: const Text('Welcome to Laza'),
          ),
          Gap(20.h),
          SizedBox(
            height: 40.h,
            child:
                BlocBuilder<BrandBloc, BrandState>(builder: (context, state) {
              if (state is BrandSuccess) {
                return ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => BrandTile(
                          imageUrl: state.brands[index].brandLogo,
                          name: state.brands[index].brandName,
                        ),
                    separatorBuilder: (context, index) => const Gap(10),
                    itemCount: state.brands.length);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
          )
        ],
      ),
    );
  }
}
