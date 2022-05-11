part of 'product_cubit.dart';

class ProductState extends Equatable {
  const ProductState({
    this.products = const [],
  });

  final List<ProductModel> products;

  ProductState copyWith({
    List<ProductModel>? products,
  }) {
    return ProductState(
      products: products ?? this.products,
    );
  }

  static ProductState fromJson(Map<String, dynamic> json) {
    return ProductState(
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'products': products.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [
        products,
      ];
}
