import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';


import 'cubit_states.dart';

class BlocCubit extends Cubit<AllStates> {
  BlocCubit() : super(InitialState());

  static BlocCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;


  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavIndex());
  }

  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];
  Database database;

  Future createDatabase() {
    openDatabase('ToDo.db', version: 1, onCreate: (database, version) {
      print("database created");
      database
          .execute(
              "CREATE TABLE TASKS (ID INTEGER PRIMARY KEY, TITLE TEXT, DATE TEXT, TIME TEXT, STATUS TEXT)")
          .then((value) {
        print("table created");
      }).catchError((error) {
        print("Error when creating table :$error");
      });
    }, onOpen: (database) {
      getFromDatabase(database);
      print("database opened");
    }).then((value) {
      database = value;
      emit(AppCreateDatabase());
    });
  }

  Future insertInDatabase(title, date, time) async {
    return await database.transaction((txn) {
      txn.rawInsert('INSERT INTO TASKS(TITLE, DATE, TIME, STATUS) VALUES("$title","$date","$time","new" )').then((value) {
        emit(AppInsertInDatabase());
        getFromDatabase(database);
        print("$value inserted successfully");
      }).catchError((error) {
        print("$error when inserting in table");
      });
      return null;
    });
  }

  void getFromDatabase(database){
     newTasks = [];
    doneTasks = [];
    archiveTasks = [];
    emit(AppGetFromDatabaseLoading());
     database.rawQuery('SELECT * FROM TASKS').then((value) {
       value.forEach((element){
         if(element['STATUS']== 'new'){
           newTasks.add(element);
         }
         else if(element['STATUS'] =='done'){
           doneTasks.add(element);
         }
         else{
           archiveTasks.add(element);
         }
       });

       emit(AppGetFromDatabase());
     });
  }

  bool isBottomSheet = false;
  Icon fabIcon = Icon(Icons.edit);

  void changeFabIcon(value, icon) {
    isBottomSheet = value;
    fabIcon = icon;
    emit(AppChangeFabIcon());
  }

 updateData({@required String status, @required int id})  {
     database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', id]
    ).then((value) {
       getFromDatabase(database);
      emit(AppUpdateDatabase());

     }).catchError((error){
       print(error);
     });
  }
  deleteData({ @required int id})  {
    database.rawUpdate(
        'DELETE FROM tasks WHERE id = ?',
        [id]
    ).then((value) {
      getFromDatabase(database);
      emit(AppDeleteDatabase());

    }).catchError((error){
      print(error);
    });
  }
}
