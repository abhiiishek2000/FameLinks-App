import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class Filecache {
  static const key = 'customCacheKey';
  static CacheManager instance = CacheManager(
    Config(
      key,
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 100,
      repo: JsonCacheInfoRepository(databaseName: key),
      // fileSystem: IOFileSystem(key),
      fileService: HttpFileService(),
    ),
  );
  savecache(String url) async {
    var file = await instance.downloadFile(url);
    print("filesave ${file.file.path}");
  }

  Future<String> getcache(String url) async {
    var file = await instance.getSingleFile(url);
    print(file.path);
    return file.path.toString();
  }
}
