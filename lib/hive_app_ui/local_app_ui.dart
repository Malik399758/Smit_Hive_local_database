import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LocalAppUi extends StatefulWidget {
  const LocalAppUi({super.key});

  @override
  State<LocalAppUi> createState() => _LocalAppUiState();
}

class _LocalAppUiState extends State<LocalAppUi> {
  final expenseController = TextEditingController();
  final dollarController = TextEditingController();
  final centController = TextEditingController();

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
            onTap: (){},
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
            Text('Week Total Budget 38.50\$',style: GoogleFonts.poppins(fontSize: 21,fontWeight: FontWeight.w600),),
            Image.asset('assets/images/local_hive_image.png',)
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
