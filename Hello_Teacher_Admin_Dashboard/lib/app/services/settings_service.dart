import 'package:hello_teacher_admin_dashboard/app/firebase/firebase_collection.dart';
import 'package:hello_teacher_admin_dashboard/app/models/settings_model.dart';

class SettingsService {
  final String withdrawSettingId = 'withdrawSettings';
  Future<SettingsModel?> getSettings() async {
    try {
      var settingsRef =
          await FirebaseCollection().settingsCol.doc(withdrawSettingId).get();
      SettingsModel? settingsModel = settingsRef.data();

      return settingsModel;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future saveSettings(SettingsModel settingsModel) async {
    try {
      print('setting percentage: ' + settingsModel.percentage.toString());
      await FirebaseCollection()
          .settingsCol
          .doc(withdrawSettingId)
          .set(settingsModel);
    } catch (e) {
      return Future.error(e);
    }
  }
}
