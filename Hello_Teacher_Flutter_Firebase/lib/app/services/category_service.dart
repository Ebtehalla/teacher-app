import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:halo_teacher/app/models/category_model.dart';

class CategoryService {
  FirebaseFirestore? _instance;

  final List<CategoryModel> _category = [];

  List<CategoryModel> get getCategories => _category;

  Future<List<CategoryModel>> getListCategory() async {
    _instance = FirebaseFirestore.instance;
    CollectionReference categoryRef = _instance!.collection('Category');

    QuerySnapshot snapshot = await categoryRef.get();

    final allData = snapshot.docs.map((doc) {
      var data = doc.data() as Map<String, dynamic>;
      data['categoryId'] = doc.reference.id;
      return data;
    });

    for (var category in allData) {
      CategoryModel doc = CategoryModel.fromJson(category);
      _category.add(doc);
    }

    return _category;
  }
}
