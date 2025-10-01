import 'package:flutter/material.dart';

class IconBoxButton extends StatelessWidget {
  final List<String> items;
  final int idx;
  final ValueChanged<int> onBoxValueChange;
  const IconBoxButton({super.key, required this.items, required this.idx, required this.onBoxValueChange});

  @override
  Widget build(BuildContext context){
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 9),
            child: GestureDetector(
              onTap: (){
                onBoxValueChange(index);
              },
              child: Chip(
                backgroundColor: index!=idx ? Color.fromRGBO(245, 247, 249, 1) : Theme.of(context).primaryColor,
                label: Text(items[index],style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),),shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)
              ),padding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),),
            ),
          );
        });
  }
}