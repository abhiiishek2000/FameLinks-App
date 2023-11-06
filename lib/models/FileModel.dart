import 'dart:io';

class FileModel {
  int position;
  File file;

  FileModel(this.position, this.file);

  int get id => position;

  File get nickname => file;

  @override
  bool operator == (Object other) {
    // TODO: implement ==
    if(other is FileModel){
      return other.id == id;
    }else{
      return false;
    }
  }
}
