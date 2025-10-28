import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/core/services/abstracts/storage.dart';
import 'package:tictactoe/core/services/hive_storage.dart';

part 'storage_provider.g.dart';

@Riverpod(keepAlive: true)
Storage storage(Ref ref) {
  return HiveStorage();
}
