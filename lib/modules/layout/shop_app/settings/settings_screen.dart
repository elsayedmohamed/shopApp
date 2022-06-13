import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/layout/cubit/cubit.dart';
import 'package:shop/modules/layout/cubit/states.dart';
import 'package:shop/styles/constant.dart';

import '../../../../shared/components/reuseable.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

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
            child: Column(
              children: [
                deaFaultFormField(
                    onSubmit: () {},
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
                    onSubmit: () {},
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
                    onSubmit: () {},
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
                    text: 'LOGOUT',
                    background: defaultColor,
                    function: () {
                      // CacheHelper.removeData(key: 'token').then((value) {
                      //   if (value) {
                      //     NavigateAndFinsh(
                      //         context: context, screen: Login_Screen());
                      //   }
                      // }).catchError((error) {});
                      signOut(context);
                    })
              ],
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
