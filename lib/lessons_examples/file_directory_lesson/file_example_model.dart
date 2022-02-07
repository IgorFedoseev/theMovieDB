import 'package:flutter/material.dart';
import 'dart:io'; //File, socket, HTTP, and other I/O support for non-web applications.
import 'package:path_provider/path_provider.dart' as pathProvider;

class FileExampleModel extends ChangeNotifier {
  void readFile() async {
    final directory = await pathProvider.getApplicationDocumentsDirectory();
    final filePath = directory.path + '/my_file.txt'; // или my_file.txt (без разницы)
    final file = File(filePath); // получаем сам файл для работы с ним
    await file.writeAsString('Привет мир!'); // создаём текстовый файл
    // final fileSink = file.openWrite(); // создаётся стрим на запись файла
    // fileSink.close(); // обязательно потом надо закрыть этот стрим
    final isExist = await file.exists(); // проверяем наличие файла
    if (!isExist){
      await file.create(); // создать новый пустой файл
    }
    // final result = await file.readAsString(); читаем файл (если он текстовый)
    // final result = await file.readAsBytes(); - читаем любой файл в байтах
    //Image.file(file); - так можем получить файл изображения
    // file.rename('Новое имя файла'); - переименовать
    final result = await file.stat(); // собрать инфо о файле:
    // result.type - тип
    // result.size - размер
    print(isExist);
    print(result.modeString()); // строковое представления разрешения файла (чтение, запись, выполнение..)

    // Инфо по методам pathProvider (см выше импорт):
    //pathProvider.getApplicationDocumentsDirectory();
        // обе, папка для хранения созданных юзером файлов
    //pathProvider.getApplicationSupportDirectory();
        // обе, папка для хранения вспомогательных для приложения файлов
    //pathProvider.getTemporaryDirectory();
        // обе, папка для хранения кэша
    //pathProvider.getLibraryDirectory();
        // iOS, для хранения технических документов необходимых приложению
    //pathProvider.getDownloadsDirectory();
        // Android, для загружаемых файлов
    // pathProvider.getExternalCacheDirectories();
    // pathProvider.getExternalStorageDirectories();
    // pathProvider.getExternalStorageDirectory();
       // все 3 Android, доп кэш или хранилище
  }
}

class FileExampleModelProvider extends InheritedNotifier {
  final FileExampleModel model;
  const FileExampleModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, notifier: model, child: child);

  static FileExampleModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<FileExampleModelProvider>();
  }

  static FileExampleModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<FileExampleModelProvider>()
        ?.widget;
    return widget is FileExampleModelProvider ? widget : null;
  }
}
