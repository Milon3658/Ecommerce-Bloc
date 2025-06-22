import 'package:bloc_ecommerce/src/blocs/blocs.dart';
import 'package:bloc_ecommerce/src/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is LoginInitial) {
            return Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Welcome',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        )),
                    Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Please enter your data to continue',
                          style: Theme.of(context).textTheme.titleSmall,
                        )),
                    Gap(20.h),
                    TextFormField(
                      controller: state.emailcontroller,
                      decoration: InputDecoration(
                          labelText: 'Email',
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
                    Gap(20.h),
                    TextFormField(
                      controller: state.passwordcontroller,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .outlineVariant)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    Gap(20.h),
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
            );
          } else {
            return Container();
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return FullWidthButton(
              buttonChild: state is loginLoading
                  ? LoadingAnimationWidget.discreteCircle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      size: 35.w)
                  : null,
              onPressed: () {
                if (state is LoginInitial) {
                  if (formkey.currentState?.validate() ?? false) {
                    context.read<LoginBloc>().add(RequestLoginWithEmail(
                        email: state.emailcontroller.text.trim(),
                        password: state.passwordcontroller.text.trim()));
                  }
                }
              },
              text: 'Sign in');
        },
      ),
    );
  }
}
