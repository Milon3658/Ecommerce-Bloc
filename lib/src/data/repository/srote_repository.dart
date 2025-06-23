import 'package:bloc_ecommerce/src/data/dummy/dummy_brands.dart';
import 'package:bloc_ecommerce/src/data/dummy/dummy_products.dart';
import 'package:bloc_ecommerce/src/data/model/brand_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StoreRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<void> createNewBrand() async {
    try {
      for (var brand in dummyBrands) {
        await _firestore.collection('brands').add(brand.toJson());
      }
    } catch (e) {
      throw Exception('Failed to create new brand: $e');
    }
  }

  Future<void> createNewProduct() async {
    try {
      for (var product in dummyProducts) {
        await _firestore.collection('products').add(product.toJson());
      }
    } catch (e) {
      throw Exception('Failed to create new product: $e');
    }
  }

  Future<List<BrandModel>> getBrands() async {
    final List<BrandModel> brandList = [];
    try {
      final data = await _firestore.collection('brands').get();
      if (data.docs.isNotEmpty) {
        for (var doc in data.docs) {
          brandList.add(BrandModel.fromJson(doc.data()));
        }
      }
      return brandList;
    } catch (e) {
      throw Exception('Failed to fetch brands: $e');
    }
  }
}
