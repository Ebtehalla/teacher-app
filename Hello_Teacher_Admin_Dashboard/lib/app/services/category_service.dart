import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hello_teacher_admin_dashboard/app/firebase/firebase_collection.dart';
import 'package:hello_teacher_admin_dashboard/app/models/category_model.dart';

class CategoryService {
  Future getAllCategory() async {
    try {
      var categoryRef = await FirebaseCollection().categoryCol.get();
      List<CategoryModel> listCategory =
          categoryRef.docs.map((doc) => doc.data()).toList();
      return listCategory;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<CategoryModel> addNewCategory(CategoryModel category) async {
    try {
      var newCategoryRef = await FirebaseCollection().categoryCol.add(category);
      var newCategoryWithId = await newCategoryRef.get();
      return newCategoryWithId.data()!;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<CategoryModel> editCategory(
      String categoryId, CategoryModel newCategory) async {
    try {
      await FirebaseCollection()
          .categoryCol
          .doc(categoryId)
          .update(newCategory.toJson());
      newCategory.id = categoryId;
      return newCategory;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future deleteCategory(String categoryId) async {
    try {
      await FirebaseCollection().categoryCol.doc(categoryId).delete();
    } catch (e) {
      return Future.error(e);
    }
  }
}
