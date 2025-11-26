import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

class HydratedStorage {
  static Future<void> init() async {
    HydratedBloc.storage = await HydratedStorage.build();
  }

  static Future<Storage> build() async {
    final directory = await getApplicationDocumentsDirectory();
    return HydratedStorageImpl(directory.path);
  }
}

class HydratedStorageImpl extends Storage {
  HydratedStorageImpl(this.path);

  final String path;

  @override
  dynamic read(String key) {
    // Implementation for reading from storage
    return null;
  }

  @override
  Future<void> write(String key, dynamic value) async {
    // Implementation for writing to storage
  }

  @override
  Future<void> delete(String key) async {
    // Implementation for deleting from storage
  }

  @override
  Future<void> clear() async {
    // Implementation for clearing storage
  }
  
  @override
  Future<void> close() {
    throw UnimplementedError();
  }
}