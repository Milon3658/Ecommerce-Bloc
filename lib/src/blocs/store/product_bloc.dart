import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_ecommerce/src/data/model/product_model';
import 'package:bloc_ecommerce/src/data/repository/product_repository.dart';
import 'package:equatable/equatable.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;
  ProductBloc(this.repository) : super(ProductInitial()) {
    on<FetchProducts>((event, emit) async {
      try {
        emit(ProductLoading());
        await repository
            .fetchProducts()
            .then((product) => emit(ProductSuccess(product)));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
  }
}
