import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:smit_hive_database/hive_app_ui/db_helper/db_helper.dart';
import 'package:smit_hive_database/hive_app_ui/models/hive_model.dart';
import 'package:hive/hive.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(HiveModelAdapter());
  final get = await DbHelper();
  get.getData();
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LocalAppUi(),
    );
  }
}


class LocalAppUi extends StatefulWidget {
  const LocalAppUi({super.key});

  @override
  State<LocalAppUi> createState() => _LocalAppUiState();
}

class _LocalAppUiState extends State<LocalAppUi> {
  List<HiveModel> list = [];
  final db = DbHelper();
  final expenseController = TextEditingController();
  final dollarController = TextEditingController();
  final centController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  // add
  void _addData()async{
   db.addData(expenseController.text, dollarController.text, centController.text);
    _fetchData();
  }

  // delete
  void deleteData(int index){
    db.deleteData(index);
    _fetchData();
  }

  // update
  void _updateData(int index)async{
    db.updateData(index, expenseController.text, dollarController.text,centController.text);
    _fetchData();
  }

  void _fetchData()async{
    List<HiveModel> fetch = await db.fetchData();
    setState(() {
      list = fetch;
    });
  }

  // Total cost
  double _calculateTotalCost() {
    double total = 0.0;
    for (var i = 0; i < hiveBox.length; i++) {
      HiveDataModel data = hiveBox.getAt(i)!;
      total += data.price + (data.cents / 100);
    }
    return total;
  }

  // Show DialogBox
  Future<void> addRecord(BuildContext context){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title:Text('Add New Expense',style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w500),) ,
        content:Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: expenseController,
              decoration: InputDecoration(
                hintText: 'Enter your expense',
              ),
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Container(
                  width: 120,
                  child: TextFormField(
                    controller: dollarController,
                    decoration: InputDecoration(
                      hintText: '\$',
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  width: 120,
                  child: TextFormField(
                    controller: centController,
                    decoration: InputDecoration(
                      hintText: 'cents',
                    ),
                  ),
                )
              ],
            ),
          ],
        ) ,
        actions: [
          // Save
          GestureDetector(
            onTap: (){
              _addData();
              Navigator.pop(context);
              expenseController.clear();
              dollarController.clear();
              centController.clear();
            },
            child: Container(
              width: 60,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black
              ),
              child: Center(child: Text('Save',style: GoogleFonts.poppins(color: Colors.white),)),
            ),
          ),
          // Cancel
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
              width: 70,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black
              ),
              child: Center(child: Text('cancel',style: GoogleFonts.poppins(color: Colors.white),)),
            ),
          ),
        ],
      );
    });
  }

  // Update
  Future<void> updateRecordDialog(BuildContext context,int index,HiveModel existingData){
    expenseController.text = existingData.name;
    dollarController.text = existingData.price.toString();
    centController.text = existingData.cents.toString();
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title:Text('Update Expense',style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.w500),) ,
        content:Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: expenseController,
              decoration: InputDecoration(
                hintText: 'Enter your expense',
              ),
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Container(
                  width: 120,
                  child: TextFormField(
                    controller: dollarController,
                    decoration: InputDecoration(
                      hintText: '\$',
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  width: 120,
                  child: TextFormField(
                    controller: centController,
                    decoration: InputDecoration(
                      hintText: 'cents',
                    ),
                  ),
                )
              ],
            ),
          ],
        ) ,
        actions: [
          // Save
          GestureDetector(
            onTap: (){
              _updateData(index);
              Navigator.pop(context);
            },
            child: Container(
              width: 60,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black
              ),
              child: Center(child: Text('Save',style: GoogleFonts.poppins(color: Colors.white),)),
            ),
          ),
          // Cancel
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
              width: 70,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black
              ),
              child: Center(child: Text('cancel',style: GoogleFonts.poppins(color: Colors.white),)),
            ),
          ),
        ],
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Column(
          children: [
            Text('Total Cost: \$${_calculateTotalCost().toStringAsFixed(2)}',style: GoogleFonts.poppins(fontSize: 21,fontWeight: FontWeight.w600),),
            Image.asset('assets/images/local_hive_image.png',),
            Expanded(
              child: ListView.builder(
                itemCount: list.length,
                  itemBuilder: (context,index){
                return ListTile(
                  title: Text(list[index].name),
                  subtitle: Text('\$${list[index].price.toString()}.${list[index].cents.toString()}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap :(){
                  updateRecordDialog(context, index,list[index]);
                },
                          child: Icon(Icons.edit,color: Colors.teal,)),
                      SizedBox(width: 20,),
                      GestureDetector(
                          onTap:(){
                      deleteData(index);
                    },
                          child: Icon(Icons.delete,color: Colors.red,)),
                    ],
                  ),
                );
              }),
            )
          ],
        ),
      ),
     floatingActionButton: FloatingActionButton(
       backgroundColor:Colors.grey.shade500,
         onPressed: (){
           addRecord(context);
         },
       child: Icon(Icons.add,size: 35,),
     ),
    );
  }
}
