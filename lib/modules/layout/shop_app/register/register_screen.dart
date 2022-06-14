import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/layout/shop_app/register/cubit/cubit.dart';
import 'package:shop/modules/layout/shop_app/register/cubit/states.dart';

import '../../../../shared/components/reuseable.dart';
import '../../../../shared/network/local/cache_helper.dart';
import '../../../../styles/constant.dart';
import '../shop_layout.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSucessState) {
            if (state.RegisterModel.status!) {
              CacheHelper.saveData(
                      key: 'token', value: state.RegisterModel.data!.token)
                  .then((value) {
                if (value) {
                  token = state.RegisterModel.data!.token;
                  NavigateAndFinsh(
                      context: context, screen: const ShopLayout());
                }
              });

              ShowToast(
                  msg: '${state.RegisterModel.message}',
                  state: ToastStates.SUCCESS);
            } else {
              ShowToast(
                  msg: '${state.RegisterModel.message}',
                  state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(),
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
                            'REGISTER',
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.black),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Register now to browse our offers',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          deaFaultFormField(
                            // suffixPress: () {},
                            onSubmit: () {},
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter valid Name';
                              }
                            },
                            label: 'UserName',
                            prefixIcon: Icons.person,
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
                            label: 'Email Adress',
                            prefixIcon: Icons.email,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          deaFaultFormField(
                            suffixIcon: ShopRegisterCubit.get(context).suffix,
                            isPassword:
                                ShopRegisterCubit.get(context).isPassword,
                            suffixPress: () {
                              ShopRegisterCubit.get(context)
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
                          deaFaultFormField(
                            // suffixPress: () {},
                            onSubmit: () {},
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter valid Phone Number';
                              }
                            },
                            label: 'Phone Number',
                            prefixIcon: Icons.phone,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          ConditionalBuilder(
                              condition: state is! ShopRegisterLoadingState,
                              builder: (context) => Container(
                                    height: 50.0,
                                    width: double.infinity,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            ShopRegisterCubit.get(context)
                                                .userRegister(
                                              name: nameController.text,
                                              email: emailController.text,
                                              password: passwordController.text,
                                              phone: phoneController.text,
                                            );
                                          }
                                        },
                                        child: const Text('REGISTER')),
                                  ),
                              fallback: (context) => const Center(
                                  child: CircularProgressIndicator())),
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
