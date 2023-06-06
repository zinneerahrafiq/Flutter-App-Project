import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecom/models/product_model.dart';
import 'package:ecom/repositories/product/product_repository.dart';
import 'package:equatable/equatable.dart';
import 'dart:developer' as dev;

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  StreamSubscription? _categorySubscription;
  final ProductRepository _productRepository;

  ProductsBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(ProductLoading()) {
    on<LoadProduct>(_loadProduct);
    on<UpdateProduct>(_updateProduct);
    on<AddProduct>(_addProduct);
  }

  void _loadProduct(LoadProduct event, Emitter<ProductsState> emit) {
    _categorySubscription?.cancel();
    _categorySubscription =
        _productRepository.getAllProduct().listen((c) => add(UpdateProduct(c)));
    dev.log("state checking ${state.props.map((e) => e)}");
  }

  void _updateProduct(UpdateProduct event, Emitter<ProductsState> emit) {
    dev.log("state is is ${state.props}");
    emit(ProductLoaded(product: event.product));
  }

  void _addProduct(AddProduct event, Emitter<ProductsState> emit) async {
    try {
      await _productRepository.addProduct(event.product);
      emit(ProductAdded());
    } catch (e) {
      dev.log('Error adding product: $e');
    }
  }

  @override
  Future<void> close() {
    _categorySubscription?.cancel();
    return super.close();
  }
}
