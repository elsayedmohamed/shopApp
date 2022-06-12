import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/layout/shop_app/shop_layout.dart';
import 'package:shop/modules/login/cubit/cubit.dart';
import 'package:shop/modules/login/cubit/states.dart';

import '../../shared/components/reuseable.dart';
import '../../shared/network/local/cache_helper.dart';

class Login_Screen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSucessState) {
            if (state.loginModel.status!) {
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                if (value) {
                  NavigateAndFinsh(context: context, screen: ShopLayout());
                }
              });

              ShowToast(
                  msg: '${state.loginModel.message}',
                  state: ToastStates.SUCCESS);
            } else {
              ShowToast(
                  msg: '${state.loginModel.message}', state: ToastStates.ERROR);
            }
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                actions: [
                  // deafaultTextButton(
                  //     onpressed: () {
                  //       NavigateAndFinsh(
                  //           context: context, screen: RegisterScreen());
                  //     },
                  //     text: 'skip'),
                ],
              ),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOGIN',
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.black),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Sign in now to browse our offers',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          deaFaultFormField(
                            // suffixPress: () {},
                            onSubmit: () {},
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter valid Email';
                              }
                            },
                            label: 'Email Address',
                            prefixIcon: Icons.email_rounded,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          deaFaultFormField(
                            suffixIcon: ShopLoginCubit.get(context).suffix,
                            isPassword: ShopLoginCubit.get(context).isPassword,
                            suffixPress: () {
                              ShopLoginCubit.get(context)
                                  .changeSuffixVisibilty();
                            },
                            onSubmit: () {},
                            controller: passwordController,
                            type: TextInputType.text,
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter valid password';
                              }
                            },
                            label: 'Password',
                            prefixIcon: Icons.lock,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          ConditionalBuilder(
                              condition: state is! ShopLoginLoadingState,
                              builder: (context) => Container(
                                    height: 50.0,
                                    width: double.infinity,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            ShopLoginCubit.get(context)
                                                .userlogIn(
                                              email: emailController.text,
                                              password: passwordController.text,
                                            );
                                          }
                                        },
                                        child: const Text('login')),
                                  ),
                              fallback: (context) => const Center(
                                  child: CircularProgressIndicator())),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account ?',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              deafaultTextButton(
                                  onpressed: () {}, text: 'register now'),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}

//=====================================================

// Container(
// height: 50.0,
// width: double.infinity,
// child: ElevatedButton(
// onPressed: () {
// if (_formKey.currentState!.validate()) {
// ShopLoginCubit.get(context).userlogIn(
// email: emailController.text,
// password: passwordController.text,
// );
// }
// },
// child: Text('login')),
// )

// final snackBar = SnackBar(
//   shape: StadiumBorder(),
//   behavior: SnackBarBehavior.floating,
//   backgroundColor: Colors.red,
//   width: 300,
//   elevation: 0.0,
//   content: Padding(
//     padding: const EdgeInsets.all(20.0),
//     child: Expanded(
//       child: Text(
//         '${state.loginModel.message},',
//         style: const TextStyle(
//           fontSize: 15.0,
//           textBaseline: TextBaseline.alphabetic,
//         ),
//       ),
//     ),
//   ),
// );
// ScaffoldMessenger.of(context).showSnackBar(snackBar);
