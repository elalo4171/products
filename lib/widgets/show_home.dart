import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products/Data/product_model.dart';
import 'package:products/Theme/colors.dart';

import '../Data/cubit/product_cubit.dart';

class ShowHome extends StatefulWidget {
  const ShowHome({
    Key? key,
  }) : super(key: key);

  @override
  State<ShowHome> createState() => _ShowHomeState();
}

class _ShowHomeState extends State<ShowHome> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  String search = '';

  @override
  void initState() {
    final bloc = context.read<ProductCubit>();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        bloc.getMoreProducts();
      }
    });
    super.initState();
  }

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
                  children: List.from(state.categories.map((e) => CategoryItem(
                        onTap: () {
                          context.read<ProductCubit>().changeCategory(e);
                          setState(() {});
                        },
                        title: e,
                        selected: state.category,
                      ))));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _searchController,
            decoration:  InputDecoration(
              hintText: 'Buscar producto',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(onPressed: (){
                search = "";
                _searchController.clear();
              }, icon: const Icon(Icons.close))
              
            ),
            onChanged: (e) {
              // context.read<ProductCubit>().changeSearch(e);
              search = e;
              setState(() {});
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
            List<ProductModel> products = state.products.toList();
            if (state.category.isNotEmpty) {
              products.removeWhere((element) => element.category != state.category);
            }
            if (search.isNotEmpty) {
              products.removeWhere((element) => !element.name.toLowerCase().contains(search.toLowerCase()));
            }
            return ListView(
              controller: _scrollController,
              children: products
                  .map<Widget>(
                    (e) => ProductWidget(
                      productModel: e,
                      onFavorite: (id) {
                        if (!state.productsFavorite.contains(e)) {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text('Agregar a favoritos'),
                              content: const Text('¿Desea agregar este producto a favoritos?'),
                              actions: [
                                ElevatedButton(
                                  child: const Text('Cancelar'),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                ElevatedButton(
                                  child: const Text('Agregar'),
                                  onPressed: () {
                                    context.read<ProductCubit>().addProdutToFavorite(e);
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        } else {
                          context.read<ProductCubit>().addProdutToFavorite(e);
                        }
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
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Text(
                        widget.productModel.category,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '\$${widget.productModel.unitPrice}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
    this.selected = "",
    required this.onTap,
  }) : super(key: key);

  final String title;
  final String selected;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final bool isSelected = title == selected;
    return GestureDetector(
      onTap: () => onTap(),
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
