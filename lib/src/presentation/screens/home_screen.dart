import 'package:bloc_ecommerce/src/blocs/blocs.dart';
import 'package:bloc_ecommerce/src/blocs/store/brand_bloc.dart';
import 'package:bloc_ecommerce/src/blocs/store/product_bloc.dart';
import 'package:bloc_ecommerce/src/data/preference/local_preference.dart';
import 'package:bloc_ecommerce/src/data/utils/shimmer_effect.dart';
import 'package:bloc_ecommerce/src/presentation/widgets/brand_tile.dart';
import 'package:bloc_ecommerce/src/routes/route_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

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
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              subtitleTextStyle:
                  Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                  return ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          const ShimmerEffect.rectangular(
                              width: 120, height: 40),
                      separatorBuilder: (context, index) => const Gap(10),
                      itemCount: 4);
                }
              }),
            ),
            Gap(20.h),
            BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
              if (state is ProductSuccess) {
                return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.w,
                      crossAxisSpacing: 10.h,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (context, index) => Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surfaceVariant,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.r),
                                child: Image(
                                  image: NetworkImage(state
                                      .products[index].imageGallary![0].imageUrl
                                      .toString()),
                                ),
                              ),
                              Text(
                                state.products[index].productName.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text(
                                '\$${state.products[index].productPrice.toString()}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        ),
                    itemCount: state.products.length);
              } else {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 10.w,
                    crossAxisSpacing: 10.h,
                    childAspectRatio: 3.0,
                  ),
                  itemBuilder: (context, index) => ShimmerEffect.rectangular(
                    width: 120.w,
                    height: 40.h,
                  ),
                  itemCount: 10,
                );
              }
            })
          ],
        ),
      ),
    );
  }
}
