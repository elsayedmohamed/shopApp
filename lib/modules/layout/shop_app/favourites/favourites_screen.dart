import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/components/component.dart';
import '../../cubit/cubit.dart';
import '../../cubit/states.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavouriteState &&
              ShopLoadingGetFavouriteState != null,
          builder: (context) => ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildListProduct(
                    ShopCubit.get(context)
                        .favoriteModel!
                        .data!
                        .data![index]
                        .product!,
                    context,
                  ),
              separatorBuilder: (context, index) => Container(
                    height: 1.0,
                    color: Colors.grey,
                  ),
              itemCount:
                  ShopCubit.get(context).favoriteModel!.data!.data!.length),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
