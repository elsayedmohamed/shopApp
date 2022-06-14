import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/layout/cubit/cubit.dart';
import 'package:shop/modules/layout/cubit/states.dart';
import 'package:shop/styles/constant.dart';

import '../../../../shared/components/component.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final model = ShopCubit.get(context).userLoginModel;

        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).userLoginModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    if (state is ShopLoadingUpdateUserDataState)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    deaFaultFormField(
                        controller: nameController,
                        type: TextInputType.text,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'name must not be empty';
                          } else {}
                        },
                        label: 'Name',
                        prefixIcon: Icons.person),
                    const SizedBox(
                      height: 10.0,
                    ),
                    deaFaultFormField(
                        controller: emailController,
                        type: TextInputType.text,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Email Adress must not be empty';
                          } else {}
                        },
                        label: 'Email ',
                        prefixIcon: Icons.email),
                    const SizedBox(
                      height: 10.0,
                    ),
                    deaFaultFormField(
                        controller: phoneController,
                        type: TextInputType.text,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Phone must not be empty';
                          } else {}
                        },
                        label: 'Phone',
                        prefixIcon: Icons.phone),
                    const SizedBox(
                      height: 10.0,
                    ),
                    defaultButton(
                        text: 'Update',
                        background: defaultColor,
                        function: () {
                          if (_formKey.currentState!.validate()) {
                            ShopCubit.get(context).updateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                            );

                            ShowToast(
                                msg: 'Update Scussfully',
                                state: ToastStates.SUCCESS);
                          } else {
                            ShowToast(
                                msg: 'No Changes to Updated ',
                                state: ToastStates.WARNING);
                          }
                        }),
                    const SizedBox(
                      height: 10.0,
                    ),
                    defaultButton(
                        text: 'Logout',
                        background: defaultColor,
                        function: () {
                          signOut(context);
                        })
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
