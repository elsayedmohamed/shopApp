import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/layout/shop_app/search/cubit/cubit.dart';
import 'package:shop/modules/layout/shop_app/search/cubit/states.dart';
import 'package:shop/modules/layout/shop_app/shop_layout.dart';

import '../../../../shared/components/component.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();

    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  NavigateTo(context: context, screen: const ShopLayout());
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
              title: Text(
                'Search Screen',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            body: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    deaFaultFormField(
                        onSubmit: (value) {
                          SearchCubit.get(context).Search(
                            text: searchController.text,
                          );
                        },
                        controller: searchController,
                        type: TextInputType.text,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'enter text to search';
                          }
                        },
                        label: 'Search',
                        prefixIcon: Icons.search),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchLoadingState) LinearProgressIndicator(),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchScucessState)
                      Expanded(
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => buildListProduct(
                                SearchCubit.get(context)
                                    .model!
                                    .data!
                                    .data![index],
                                context,
                                isOldPrice: false),
                            separatorBuilder: (context, index) => Container(
                                  height: 1.0,
                                  color: Colors.grey,
                                ),
                            itemCount: SearchCubit.get(context)
                                .model!
                                .data!
                                .data!
                                .length),
                      )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
