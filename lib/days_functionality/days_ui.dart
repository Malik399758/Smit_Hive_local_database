import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DaysUi extends StatefulWidget {
  const DaysUi({super.key});

  @override
  State<DaysUi> createState() => _DaysUiState();
}

class _DaysUiState extends State<DaysUi> {
  List<bool> isActive = [false,false,false,false,false,false,false];

  void changeColor(int index){
    setState(() {
      for (int i = 0; i < isActive.length; i++) {
        isActive[i] = false;
      }
      isActive[index] = true;
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Days of the week',style: GoogleFonts.poppins(color: Colors.white),),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    changeColor(0);
                  },
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: isActive[0] ? Colors.amber : Colors.black
                    ),
                    child: Center(child: Text('Monday',style: GoogleFonts.poppins(color: Colors.white),)),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    changeColor(1);
                  },
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: isActive[1] ? Colors.amber : Colors.black
                    ),
                    child: Center(child: Text('Tuesday',style: GoogleFonts.poppins(color: Colors.white),)),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    changeColor(2);
                  },
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: isActive[2] ? Colors.amber : Colors.black
                    ),
                    child: Center(child: Text('Wednesday',style: GoogleFonts.poppins(color: Colors.white),)),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                      changeColor(3);
                  },
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: isActive[3] ? Colors.amber : Colors.black
                    ),
                    child: Center(child: Text('Thursday',style: GoogleFonts.poppins(color: Colors.white),)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){
                    changeColor(4);
                  },
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: isActive[4] ? Colors.amber : Colors.black
                    ),
                    child: Center(child: Text('Friday',style: GoogleFonts.poppins(color: Colors.white),)),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    changeColor(5);
                  },
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: isActive[5] ? Colors.amber : Colors.black
                    ),
                    child: Center(child: Text('Saturday',style: GoogleFonts.poppins(color: Colors.white),)),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    changeColor(6);
                  },
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: isActive[6] ? Colors.amber : Colors.black
                    ),
                    child: Center(child: Text('Sunday',style: GoogleFonts.poppins(color: Colors.white),)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

