import 'package:flutter/material.dart';

class TopSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSendClick;
  const TopSearchBar({super.key, required this.controller, required this.onSendClick});
  @override
  Widget build(BuildContext context){
    final imd = OutlineInputBorder(
      borderRadius: BorderRadius.horizontal(left: Radius.circular(200)),
      borderSide: BorderSide(
          width: 1,
          color: Colors.black
      ),
    );
    return Row(crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Store\nCollection",style: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.bold,
        ),),
        SizedBox(width: 8,),
        Expanded(
          child: TextField(
            controller: controller,
            onSubmitted: onSendClick,
            decoration: InputDecoration(
                focusColor: Colors.black,
                hoverColor: Colors.black,
                prefixIcon: Icon(Icons.search,color: Colors.grey),
                hintText: "Search",
                hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey
                ),
                border: imd,
                enabledBorder: imd,
                focusedBorder: imd
            ),
          ),
        )
      ],
    );
  }
}