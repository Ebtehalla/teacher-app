import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:halo_teacher/app/models/review_model.dart';
import 'package:halo_teacher/app/models/teacher_model.dart';
import 'package:halo_teacher/app/models/time_slot_model.dart';
import 'package:halo_teacher/app/models/top_rated_teacher_model.dart';
import 'package:halo_teacher/app/models/transaction_model.dart';
import 'package:halo_teacher/app/models/user_model.dart';
import 'package:halo_teacher/app/models/withdraw_method_model.dart';
import 'package:halo_teacher/app/models/withdraw_request_model.dart';

///Firebase collection class to make it easy accessing the firebase collection, if you wanto add new collection
///Just add collection name, and create CollectionReference base on the class model, and initialize it in FirebaseCollection._internal function
///Make sure you follow the template
class FirebaseCollection {
  /// User Collection base on firebase collection name
  static const String userCollectionName = "Users";
  static const String teacherCollectionName = "Teachers";
  static const String reviewCollectionName = "Review";
  static const String timeSlotCollectionName = "TimeSlot";
  static const String transactionCollectionName = "Transaction";
  static const String withdrawMethodCollectionName = "WithdrawMethod";
  static const String withdrawRequestCollectionName = "WithdrawRequest";
  static const String topRatedTeacherCollectionName = "TopRatedTeacher";

  static final FirebaseCollection _singleton = FirebaseCollection._internal();
  static final Map<Type, CollectionReference<dynamic>> _collectionCache = {};
  late CollectionReference<UserModel> userCol;
  late CollectionReference<Teacher> teacherCol;
  late CollectionReference<TimeSlot> timeSlotCol;
  late CollectionReference<ReviewModel> reviewCol;
  late CollectionReference<TransactionModel> transactionCol;
  late CollectionReference<WithdrawMethodModel> withdrawMethodCol;
  late CollectionReference<WithdrawRequestModel> withdrawRequestCol;
  late CollectionReference<TopRatedTeacherModel> topRatedTeacherCol;

  factory FirebaseCollection() {
    return _singleton;
  }

  FirebaseCollection._internal() {
    userCol = _getOrCreateCollection<UserModel>(
        collectionName: userCollectionName,
        fromJson: UserModel.fromFirestore,
        toJson: (UserModel model) => model.toJson());
    teacherCol = _getOrCreateCollection<Teacher>(
        collectionName: teacherCollectionName,
        fromJson: Teacher.fromFirestore,
        toJson: (Teacher model) => model.toJson());
    reviewCol = _getOrCreateCollection<ReviewModel>(
        collectionName: reviewCollectionName,
        fromJson: ReviewModel.fromFirestore,
        toJson: (ReviewModel model) => model.toJson());
    timeSlotCol = _getOrCreateCollection<TimeSlot>(
        collectionName: timeSlotCollectionName,
        fromJson: TimeSlot.fromFirestore,
        toJson: (TimeSlot model) => model.toJson());
    transactionCol = _getOrCreateCollection<TransactionModel>(
        collectionName: transactionCollectionName,
        fromJson: TransactionModel.fromFirestore,
        toJson: (TransactionModel model) => model.toJson());
    withdrawMethodCol = _getOrCreateCollection<WithdrawMethodModel>(
        collectionName: withdrawMethodCollectionName,
        fromJson: WithdrawMethodModel.fromFirestore,
        toJson: (WithdrawMethodModel model) => model.toJson());
    withdrawRequestCol = _getOrCreateCollection<WithdrawRequestModel>(
        collectionName: withdrawRequestCollectionName,
        fromJson: WithdrawRequestModel.fromFirestore,
        toJson: (WithdrawRequestModel model) => model.toJson());
    topRatedTeacherCol = _getOrCreateCollection<TopRatedTeacherModel>(
        collectionName: topRatedTeacherCollectionName,
        fromJson: TopRatedTeacherModel.fromFirestore,
        toJson: (TopRatedTeacherModel model) => model.toJson());
  }
  static CollectionReference<T> _getOrCreateCollection<T>(
      {required String collectionName,
      required T Function(DocumentSnapshot doc) fromJson,
      required Map<String, dynamic> Function(T model) toJson}) {
    final type = T;
    if (_collectionCache.containsKey(type)) {
      return _collectionCache[type] as CollectionReference<T>;
    }
    final collection =
        FirebaseFirestore.instance.collection(collectionName).withConverter<T>(
              fromFirestore: (snapshot, _) => fromJson(snapshot),
              toFirestore: (value, _) => toJson(value),
            );
    _collectionCache[type] = collection;
    return collection;
  }
}
