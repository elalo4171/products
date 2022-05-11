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
    List<ProductModel> temp = state.productsFavorite;
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
    final List<ProductModel> products = await repository.getProducts(null);
    emit(state.copyWith(products: products, status: StatusPage.loaded));
  }

  void changeCategory(int id) {
    emit(state.copyWith(idCategory: id));
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
