part of 'brand_bloc.dart';

abstract class BrandEvent extends Equatable {
  const BrandEvent();

  @override
  List<Object> get props => [];
}

class FetchBrands extends BrandEvent {
  const FetchBrands();

  @override
  List<Object> get props => [];
}
