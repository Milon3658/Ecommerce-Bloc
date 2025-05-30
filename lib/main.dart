import 'package:bloc/bloc.dart';
import 'package:bloc_ecommerce/app.dart';
import 'package:bloc_ecommerce/src/blocs/bloc_ecommerce_observer.dart';
import 'package:flutter/material.dart';

void main() {
  Bloc.observer = BlocEcommerceObserver();
  runApp(const BlocEcommerceApp());
}
