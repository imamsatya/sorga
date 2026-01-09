import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/entities/user_progress.dart';
import '../../core/constants/app_constants.dart';

/// Local database service using Hive
class LocalDatabase {
  static LocalDatabase? _instance;
  static LocalDatabase get instance => _instance ??= LocalDatabase._();
  
  LocalDatabase._();
  
  late Box<UserProgress> _progressBox;
  
  /// Initialize the database
  Future<void> init() async {
    await Hive.initFlutter();
    
    // Register adapters
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserProgressAdapter());
    }
    
    // Open boxes
    _progressBox = await Hive.openBox<UserProgress>(AppConstants.progressBoxName);
  }
  
  /// Get the progress box
  Box<UserProgress> get progressBox => _progressBox;
  
  /// Close the database
  Future<void> close() async {
    await _progressBox.close();
  }
}
