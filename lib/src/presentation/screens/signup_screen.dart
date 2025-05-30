import 'package:bloc_ecommerce/src/blocs/authentication/remember_switch_cubit.dart';
import 'package:bloc_ecommerce/src/presentation/widgets/widgets.dart';
import 'package:bloc_ecommerce/src/routes/route_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const DefaultBackButton(),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Sign Up',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Gap(40),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'User name',
                      labelStyle: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .outlineVariant)),
                ),
                const Gap(20),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: 'email',
                      labelStyle: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .outlineVariant)),
                ),
                const Gap(20),
                TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(
                            color:
                                Theme.of(context).colorScheme.outlineVariant),
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.visibility_off),
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                  ),
                ),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Remember me',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    BlocBuilder<RememberSwitchCubit, RememberSwitchState>(
                      builder: (context, state) {
                        return Switch(
                            value: state is RememberSwitchChanged
                                ? state.value
                                : false,
                            onChanged: (value) {
                              context
                                  .read<RememberSwitchCubit>()
                                  .toggleSwitch(value);
                            });
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: FullWidthButton(
          text: 'Sign Up',
          onPressed: () => context.pushNamed(Routes.HOME),
        ));
  }
}
