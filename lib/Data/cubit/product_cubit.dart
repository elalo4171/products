import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:products/Data/product_model.dart';

import '../product_repository.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> with HydratedMixin {
  final ProductRepositoryI repository;
  ProductCubit(this.repository) : super(const ProductState()) {
    loadFirstProducts();
  }

  void getMoreProducts() async {
    final products = await repository.getProducts(state.pagination + 1);
    emit(state.copyWith(
      status: StatusPage.loaded,
      products: state.products + products,
      pagination: state.pagination + 1,
    ));
    createCategories();
  }

  void changePage(int index) {
    emit(state.copyWith(currentPage: index));
  }

  void removeFavorite(String id) {
    List<ProductModel> temp = state.productsFavorite;
    temp.removeWhere((e) => e.id == id);
    emit(state.copyWith(productsFavorite: temp));
  }

  void addProdutToFavorite(ProductModel product) {
    if (isFavorite(product.id)) {
      removeFavorite(product.id);
      return;
    }
    List<ProductModel> temp = state.productsFavorite.toList();
    temp.add(product);
    emit(
      state.copyWith(
        productsFavorite: temp,
      ),
    );
  }

  bool isFavorite(String id) {
    if (state.productsFavorite.isEmpty) {
      return false;
    }
    return state.productsFavorite.any((e) => e.id == id);
  }

  Future<void> loadFirstProducts() async {
    if (state.products.isNotEmpty) {
      return;
    }
    emit(state.copyWith(status: StatusPage.loading));
    final List<ProductModel> products = await repository.getProducts(null);
    emit(state.copyWith(products: products, status: StatusPage.loaded));
    createCategories();
  }

  void createCategories() {
    List<String> categories = [];
    for (var e in state.products) {
      if (!categories.contains(e.category)) {
        categories.add(e.category);
      }
    }
    emit(state.copyWith(categories: categories));
  }

  void changeCategory(String category) {
    emit(state.copyWith(category: state.category == category ? "" : category));
  }

  @override
  ProductState? fromJson(Map<String, dynamic> json) {
    return ProductState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(ProductState state) {
    return state.toJson();
  }
}
