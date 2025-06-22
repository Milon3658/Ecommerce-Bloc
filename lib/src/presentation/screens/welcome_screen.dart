import 'package:bloc_ecommerce/src/blocs/authentication/login_bloc.dart';
import 'package:bloc_ecommerce/src/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import '../../routes/route_pages.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          SizedBox(
            width: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('skip'),
                IconButton(
                  icon: const Icon(Icons.skip_next),
                  onPressed: () {
                    context.pushNamed(Routes.HOME);
                  },
                ),
              ],
            ),
          )
        ],
      ),
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
              listener: (context, state) {
                if (state is loginSuccess) {
                  Fluttertoast.showToast(msg: "Login successful");
                  Future.delayed(const Duration(microseconds: 500), () {
                    context.goNamed(Routes.HOME);
                  });
                }
                if (state is facebookLoginSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Coming Soon'),
                      backgroundColor:
                          Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  );
                }
                if (state is twitterLoginSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Coming Soon'),
                      backgroundColor:
                          Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  );
                } else if (state is loginFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Login failed'),
                      backgroundColor:
                          Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  );
                }
              },
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
                          onPressed: () {
                            context
                                .read<LoginBloc>()
                                .add(RequestFacebookLogin());
                          }),
                      const Gap(20),
                      SocialLoginButton(
                          buttonType: SocialLoginButtonType.twitter,
                          onPressed: () {
                            context
                                .read<LoginBloc>()
                                .add(RequestTwitterLogin());
                          }),
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
