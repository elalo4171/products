import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products/Data/cubit/product_cubit.dart';
import 'package:products/Data/product_repository.dart';
import 'package:products/widgets/show_home.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductRepository repository = ProductRepository();
    return BlocProvider(
      create: (context) => ProductCubit(repository),
      child: const _BuildHomePage(),
    );
  }
}

class _BuildHomePage extends StatelessWidget {
  const _BuildHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          return AnimatedSwitcher(
            duration: const Duration(
              milliseconds: 500,
            ),
            child: state.currentPage == 0
                ? const ShowHome()
                : BlocBuilder<ProductCubit, ProductState>(
                    builder: (context, state) {
                      if (state.productsFavorite.isEmpty) {
                        return const Center(
                          child: Text('No hay productos favoritos'),
                        );
                      }
                      return ListView(
                        children: state.productsFavorite
                            .map<Widget>(
                              (e) => ProductWidget(
                                productModel: e,
                                onFavorite: (id) {
                                  context.read<ProductCubit>().addProdutToFavorite(e);
                                },
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          return BottomNavigationBar(
              currentIndex: state.currentPage,
              onTap: (index) {
                context.read<ProductCubit>().changePage(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorites',
                ),
              ]);
        },
      ),
    );
  }
}
