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
    this.categories = const [],
    this.currentPage = 0,
    this.pagination = 1,
    this.category = "",
  });

  final List<ProductModel> products;
  final StatusPage status;
  final int idCategory;
  final List<ProductModel> productsFavorite;
  final List<String> categories;
  final int currentPage;
  final int pagination;
  final String category;

  ProductState copyWith({
    List<ProductModel>? products,
    StatusPage? status,
    int? idCategory,
    List<ProductModel>? productsFavorite,
    int? currentPage,
    int? pagination,
    List<String>? categories,
    String? category,
  }) {
    return ProductState(
      products: products ?? this.products,
      status: status ?? this.status,
      idCategory: idCategory ?? this.idCategory,
      productsFavorite: productsFavorite ?? this.productsFavorite,
      currentPage: currentPage ?? this.currentPage,
      pagination: pagination ?? this.pagination,
      categories: categories ?? this.categories,
      category: category ?? this.category,
    );
  }

  static ProductState fromJson(Map<String, dynamic> json) {
    return ProductState(
      // products:
      //     (json['products'] as List<dynamic>).map((e) => ProductModel.fromJson(e as Map<String, dynamic>)).toList(),
      products: const [],
      status: StatusPage.values.firstWhere((e) => e.toString() == json['status']),
      idCategory: json['idCategory'],
      productsFavorite: (json['productsFavorite'] as List<dynamic>)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentPage: json['currentPage'],
      pagination: 1,
      categories: (json['categories'] as List<dynamic>).cast<String>(),
      category: "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'products': products.map((e) => e.toJson()).toList(),
      'status': status.toString(),
      'idCategory': idCategory,
      'productsFavorite': productsFavorite.map((e) => e.toJson()).toList(),
      'currentPage': currentPage,
      'pagination': pagination,
      'categories': categories,
      'category': category,
    };
  }

  @override
  List<Object?> get props => [
        products,
        status,
        idCategory,
        productsFavorite,
        currentPage,
        pagination,
        categories,
        category,
      ];
}
