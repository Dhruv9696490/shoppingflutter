import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../store_view_model.dart';

class StoreDataItems extends StatelessWidget {
  final String searchTitle;
  final int idx;
  final List<String> items;
  final TextEditingController controller;
  const StoreDataItems({super.key, required this.idx, required this.items, required this.searchTitle, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Consumer<StoreViewModel>(builder: (context,vm,_){
      if(vm.loading){
        return Center(child: CircularProgressIndicator());
      }else if(vm.error.isNotEmpty){
        return Center(child: Text(vm.error),);
      }else if(vm.list.isEmpty){
        return Center(child: Text("Empty"),);
      }else{
        final vmData = ( idx==0 && searchTitle.isEmpty)
            ? vm.list
            : (idx==2)
            ? vm.list.where((id){
              return id.category=="women's clothing";
        }).toList()
            : (searchTitle.isNotEmpty)
            ? vm.list.where((id){
              return id.title?.split(' ')[0].toLowerCase()==searchTitle;
        }).toList()
            : vm.list.where((id){
          return id.category?.toLowerCase()==items[idx].toLowerCase();
        }).toList();
        if(searchTitle.isNotEmpty){
          controller.clear();
        }
        return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8
        ),
            itemCount: vmData.length,
            itemBuilder: (context,index){
              final item = vmData[index];
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                color: Theme.of(context).primaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(child: Image.network(item.image ?? "",fit: BoxFit.contain,)),
                      Text(item.title?.split(' ').reversed.take(3).toList().reversed.join(' ') ?? "" ,style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                        textAlign: TextAlign.center,),
                    ],
                  ),
                ),
              );
            });
      }
    });
  }
}
