part of 'product_cubit.dart';

enum StatusPage {
  loading,
  loaded,
  error,
}

class ProductState extends Equatable {
  const ProductState({
    this.products = const [],
    this.status = StatusPage.loading,
  });

  final List<ProductModel> products;
  final StatusPage status;

  ProductState copyWith({
    List<ProductModel>? products,
    StatusPage? status,
  }) {
    return ProductState(
      products: products ?? this.products,
      status: status ?? this.status,
    );
  }

  static ProductState fromJson(Map<String, dynamic> json) {
    return ProductState(
      products:
          (json['products'] as List<dynamic>).map((e) => ProductModel.fromJson(e as Map<String, dynamic>)).toList(),
      status:  StatusPage.values.firstWhere((e) => e.toString() == json['status']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'products': products.map((e) => e.toJson()).toList(),
      'status': status.toString(),
    };
  }

  @override
  List<Object?> get props => [
        products,
        status,
      ];
}
