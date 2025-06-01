import 'package:bloc_ecommerce/src/blocs/authentication/login_bloc.dart';
import 'package:bloc_ecommerce/src/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import '../../routes/route_pages.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Let’s Get Started',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is loginLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SocialLoginButton(
                          buttonType: SocialLoginButtonType.facebook,
                          onPressed: () {}),
                      const Gap(20),
                      SocialLoginButton(
                          buttonType: SocialLoginButtonType.twitter,
                          onPressed: () {}),
                      const Gap(20),
                      SocialLoginButton(
                          buttonType: SocialLoginButtonType.google,
                          onPressed: () {
                            context.read<LoginBloc>().add(RequestGoogleLogin());
                          }),
                    ],
                  ),
                );
              },
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                    TextButton(
                        onPressed: () {
                          context.pushNamed(Routes.LOGIN_ROUTE);
                        },
                        child: Text(
                          'Sign In',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
                const Gap(5),
                FullWidthButton(
                    text: "Create an Account",
                    onPressed: () {
                      context.pushNamed(Routes.REGISTER_ROUTE);
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
