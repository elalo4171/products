import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products/Data/product_model.dart';
import 'package:products/Theme/colors.dart';

import '../Data/cubit/product_cubit.dart';

class ShowHome extends StatelessWidget {
  const ShowHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              return ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  20,
                  (index) => CategoryItem(
                    onTap: (p0) {
                      context.read<ProductCubit>().changeCategory(index);
                    },
                    title: "Categoria $index",
                    id: index,
                    idSelected: state.idCategory,
                  ),
                ),
              );
            },
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
        )),
      ],
    );
  }
}

class ProductWidget extends StatefulWidget {
  const ProductWidget({
    Key? key,
    required this.productModel,
    required this.onFavorite,
  }) : super(key: key);

  final ProductModel productModel;
  final Function(String) onFavorite;

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    final ProductCubit cubit = context.read<ProductCubit>();
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
                  widget.productModel.imagen,
                ),
              ),
            ),
            ListTile(
              title: Text(widget.productModel.name),
              subtitle: Column(
                children: [
                  Text(
                    widget.productModel.description,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        widget.onFavorite(widget.productModel.id);
                        setState(() {});
                      },
                      icon: Icon(cubit.isFavorite(widget.productModel.id) ? Icons.favorite : Icons.favorite_border),
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
    required this.onTap,
  }) : super(key: key);

  final String title;
  final int id;
  final int idSelected;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = id == idSelected;
    return GestureDetector(
      onTap: () => onTap(id),
      child: Card(
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
      ),
    );
  }
}