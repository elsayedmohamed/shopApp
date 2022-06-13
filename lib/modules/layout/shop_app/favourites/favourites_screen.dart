import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/favourites_model.dart';

import '../../../../styles/constant.dart';
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
              itemBuilder: (context, index) => buildFavItem(
                  ShopCubit.get(context).favoriteModel!.data!.data![index],
                  context),
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

  Widget buildFavItem(FavoritesData model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    child: Image(
                      image: NetworkImage(model.product!.image!),
                      width: 120,
                      height: 120,
                    ),
                  ),
                  if (model.product!.discount != 0)
                    Container(
                      color: Colors.red,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5.0,
                      ),
                      child: Text(
                        model.product!.discount!.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8.0,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 20.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.product!.name!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          height: 1.3,
                          overflow: TextOverflow.ellipsis),
                      maxLines: 3,
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          model.product!.price!.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.3,
                            color: defaultColor,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        if (model.product!.oldPrice != 0)
                          Text(
                            model.product!.oldPrice!.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 14,
                              height: 1.3,
                              color: Colors.grey,
                            ),
                          ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context)
                                .changeFavourites(model.product!.id!);
                            print(1);
                          },
                          icon: CircleAvatar(
                            backgroundColor: ShopCubit.get(context)
                                        .favourites[model.product!.id] ==
                                    true
                                ? defaultColor
                                : Colors.grey,
                            radius: 16.0,
                            child: const Icon(
                              Icons.favorite_outline_rounded,
                              size: 14.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
