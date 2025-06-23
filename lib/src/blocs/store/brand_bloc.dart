import 'package:bloc/bloc.dart';
import 'package:bloc_ecommerce/src/data/model/brand_model.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_ecommerce/src/data/repository/srote_repository.dart';
part 'brand_event.dart';
part 'brand_state.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  StoreRepository repository;
  BrandBloc(this.repository) : super(BrandInitial()) {
    on<FetchBrands>((event, emit) async {
      try {
        emit(BrandLoading());
        final brands = await repository.getBrands();
        emit(BrandSuccess(brands));
      } catch (e) {
        emit(BrandError(e.toString()));
      }
    });
  }
}
