import 'package:bloc_ecommerce/src/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../blocs/blocs.dart';
import '../../routes/route_pages.dart';

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
              BlocConsumer<SignupBloc, SignupState>(
                listener: (context, state) {
                  if (state is SignupSuccess) {
                    context.goNamed(Routes.HOME);
                  }
                  if (state is SignupFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                      ),
                    );
                    context.pushNamed(Routes.REGISTER_ROUTE);
                  }
                },
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
                          const Gap(20),
                          TextFormField(
                            controller: state.confirmPasswordController,
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              labelText: 'Confirm password',
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
                      child: Container(
                        height: 200.h,
                      ),
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
      bottomNavigationBar:
          BlocBuilder<SignupBloc, SignupState>(builder: (context, state) {
        return FullWidthButton(
            text: 'Sign Up',
            buttonChild: state is SignupLoading
                ? LoadingAnimationWidget.discreteCircle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    size: 35.w)
                : null,
            onPressed: () {
              if (state is SignupInitial) {
                if (formKey.currentState?.validate() ?? false) {
                  context.read<SignupBloc>().add(RequestEmailSIgnUp(
                      userName: state.usernameController.text.trim(),
                      email: state.emailController.text.trim(),
                      password: state.passwordController.text.trim(),
                      confirmPassword:
                          state.confirmPasswordController.text.trim()));
                } else {
                  print("Form is invalid, please correct the errors");
                }
              }
            });
      }),
    );
  }
}
