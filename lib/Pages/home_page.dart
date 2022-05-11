import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products/Data/cubit/product_cubit.dart';
import 'package:products/Data/product_model.dart';
import 'package:products/Data/product_repository.dart';
import 'package:products/Theme/colors.dart';

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
        body: Column(
          children: [
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  20,
                  (index) => CategoryItem(title: "Categoria $index", id: index),
                ),
              ),
            ),
            Expanded(child: BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                if (state.status == StatusPage.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView(
                  children: state.products
                      .map<Widget>(
                        (e) => ProductWidget(productModel: e),
                      )
                      .toList(),
                );
              },
            )),
          ],
        ));
  }
}

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.network(
                  productModel.imagen,
                ),
              ),
            ),
            ListTile(
              title: Text(productModel.name),
              subtitle: Column(
                children: [
                  Text(
                    productModel.description,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.title,
    required this.id,
    this.idSelected = 0,
  }) : super(key: key);

  final String title;
  final int id;
  final int idSelected;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = id == idSelected;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: isSelected ? ColorsCustom.primary : Colors.white,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
