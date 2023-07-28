import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {


  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  intialDb() async {
    // مسار تخزين الداتا بيز
    String dbPath = await getDatabasesPath();
    // اختيار اسم الداتابيز فهضيف المسار مع اسم الداتابيز
    // لما اكون عاوز طبعا انشئ الداتابيز
    String path = await join(dbPath, 'ahmed.db');

    var mydb = await openDatabase(
      path,
      onCreate: _onCreate ,
      version: 1,
      onUpgrade:_onUpgrade ,
      
    );
    return mydb;
  }

 // بيتم استدعائها لما نغير الفيرجن
  _onUpgrade( Database db, int oldVersion,int newVersion){

  }

// بيتم استدعائها مرة واحدة فقط عند انشاء الداتابيز
  _onCreate(Database db , int version)async{
     await
            // انشاء جدول
            // الجدول اسمه notes
            // جواه عمودين كولمن يعنى اللى هما الاى دى والاسم
            db.execute('''
        
        CREATE TABLE "notes" 
        (
        "id" INTEGER NOT NULL  PRIMARY KEY AUTOINCREMENT,
        "note" TEXT NOT NULL, value INTEGER, num REAL)
 ''');
  }

  // select
 Future<List<Map>> readData(String sql)async{
  Database? mydb = await db;
  List<Map> response = await mydb!.rawQuery(sql);
  return response;
  }


   // insert
 Future<int> insertData(String sql)async{
  Database? mydb = await db;
  int response = await mydb!.rawInsert(sql);
  return response;
  }


    // update
 Future<int> updatetData(String sql)async{
  Database? mydb = await db;
  int response = await mydb!.rawUpdate(sql);
  return response;
  }


    // delete
 Future<int> deletetData(String sql)async{
  Database? mydb = await db;
  int response = await mydb!.rawDelete(sql);
  return response;
  }
}
