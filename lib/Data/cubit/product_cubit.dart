import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:products/Data/product_model.dart';

import '../product_repository.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> with HydratedMixin {
  final ProductRepositoryI repository;
  ProductCubit(this.repository) : super(const ProductState()){
    loadFirstProducts();
  }


  Future<void> loadFirstProducts() async {
    final List<ProductModel> products = await repository.getProducts(null);
    emit(state.copyWith(products: products, status: StatusPage.loaded));
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
