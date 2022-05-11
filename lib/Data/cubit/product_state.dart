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
    this.idCategory = 0,
    this.productsFavorite = const [],
    this.currentPage = 0,
  });

  final List<ProductModel> products;
  final StatusPage status;
  final int idCategory;
  final List<ProductModel> productsFavorite;
  final int currentPage;

  ProductState copyWith({
    List<ProductModel>? products,
    StatusPage? status,
    int? idCategory,
    List<ProductModel>? productsFavorite,
    int? currentPage,
  }) {
    return ProductState(
      products: products ?? this.products,
      status: status ?? this.status,
      idCategory: idCategory ?? this.idCategory,
      productsFavorite: productsFavorite ?? this.productsFavorite,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  static ProductState fromJson(Map<String, dynamic> json) {
    return ProductState(
      products:
          (json['products'] as List<dynamic>).map((e) => ProductModel.fromJson(e as Map<String, dynamic>)).toList(),
      status: StatusPage.values.firstWhere((e) => e.toString() == json['status']),
      idCategory: json['idCategory'],
      productsFavorite: (json['productsFavorite'] as List<dynamic>)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentPage: json['currentPage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'products': products.map((e) => e.toJson()).toList(),
      'status': status.toString(),
      'idCategory': idCategory,
      'productsFavorite': productsFavorite.map((e) => e.toJson()).toList(),
      'currentPage': currentPage,
    };
  }

  @override
  List<Object?> get props => [
        products,
        status,
        idCategory,
        productsFavorite,
        currentPage,
      ];
}
