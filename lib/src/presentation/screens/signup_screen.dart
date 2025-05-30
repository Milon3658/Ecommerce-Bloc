import 'package:bloc_ecommerce/src/blocs/authentication/remember_switch_cubit.dart';
import 'package:bloc_ecommerce/src/presentation/widgets/widgets.dart';
import 'package:bloc_ecommerce/src/routes/route_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../blocs/blocs.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
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
                BlocBuilder<SignupBloc, SignupState>(
                  builder: (context, state) {
                    if (state is SignupInitial) {
                      return Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: state.usernameController,
                              decoration: InputDecoration(
                                  labelText: 'User name',
                                  labelStyle: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .outlineVariant)),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your username';
                                }
                                return null;
                              },
                            ),
                            const Gap(20),
                            TextFormField(
                              controller: state.emailController,
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                            ),
                            const Gap(20),
                            TextFormField(
                              controller: state.passwordController,
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outlineVariant),
                                suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.visibility_off),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .outlineVariant,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: Container(),
                      );
                    }
                  },
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
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                print("Form is valid, proceed with signup");
              } else {
                print("Form is invalid, please correct the errors");
              }
            }));
  }
}
