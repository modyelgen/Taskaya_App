import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FileCacheHelper {

    Future<String> saveFile(String filename, List<int> bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/$filename';
    final file = File(path);
    await file.writeAsBytes(bytes);
    return file.path;
  }
  Future<List<Map>> getData({required Database database,required tableName})async{
      List<Map>dataList=[];
      dataList = await database.rawQuery('SELECT * FROM $tableName');
      return (dataList);
  }


  Future<bool> checkOfExistOfDb({required String path})async{
        bool exist=false;
       await getDatabasesPath().then((value) async {
            String dbPath = join(value, path);
            exist=await databaseExists(dbPath);
        });
       return exist;

    }

  // Future<File?> getFile(String filename) async {
  //   final files = await _databaseHelper.getFiles();
  //   for (var file in files) {
  //     if (file['filename'] == filename) {
  //       return File(file['path']);
  //     }
  //   }
  //   return null;
  // }

  // Future<void> deleteFile(String filename) async {
  //   final files = await _databaseHelper.getFiles();
  //   for (var file in files) {
  //     if (file['filename'] == filename) {
  //       final path = file['path'];
  //       final fileToDelete = File(path);
  //       if (await fileToDelete.exists()) {
  //         await fileToDelete.delete();
  //       }
  //       await _databaseHelper.deleteFile(file['id']);
  //     }
  //   }
  // }
}
