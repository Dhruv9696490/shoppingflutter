import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingflutter/description_screen.dart';
import '../store_view_model.dart';

class StoreDataItems extends StatelessWidget {
  final String searchTitle;
  final int idx;
  final List<String> items;
  final TextEditingController controller;
  const StoreDataItems({
    super.key,
    required this.idx,
    required this.items,
    required this.searchTitle,
    required this.controller,
  });

  @override
  Widget build(BuildContext context){
    return Consumer<StoreViewModel>(
      builder: (context, vm, _) {
        if (vm.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (vm.error.isNotEmpty) {
          return Center(child: Text(vm.error));
        } else if (vm.list.isEmpty) {
          return Center(child: Text("Empty"));
        } else {
          final vmData = (idx == 0 && searchTitle.isEmpty)
              ? vm.list
              : (idx == 2)
              ? vm.list.where((id) {
                  return id.category == "women's clothing";
                }).toList()
              : (searchTitle.isNotEmpty)
              ? vm.list.where((id) {
                  return id.title?.split(' ')[0].toLowerCase() == searchTitle;
                }).toList()
              : vm.list.where((id) {
                  return id.category?.toLowerCase() == items[idx].toLowerCase();
                }).toList();
          if (searchTitle.isNotEmpty) {
            controller.clear();
          }
          return ListView.builder(
            itemCount: vmData.length,
            itemBuilder: (context, index) {
              final item = vmData[index];
              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 8, 8),
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) {
                              return DescriptionScreen(data: item);
                            },
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        color: Theme.of(context).primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Align(
                                  alignment: AlignmentGeometry.centerLeft,
                                  child: Text(
                                    item.title
                                            ?.split(' ')
                                            .reversed
                                            .take(3)
                                            .toList()
                                            .reversed
                                            .join(' ') ??
                                        "",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Align(
                                  alignment: AlignmentGeometry.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      '\$${item.price}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              Image.network(
                                item.image ?? "",
                                fit: BoxFit.contain,
                                height: 200,
                                width: 300,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20,
                      top: 10,
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Color.fromRGBO(255, 198, 0, 1.0),
                            size: 40,
                          ),
                          Text(
                            item.rating!.rate.toString(),
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 20,
                      top: 50,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: item.isFavorite != true
                              ? Colors.red
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(90),
                          radius: 5.99,
                          onTap: () {
                            context.read<StoreViewModel>().toggleFavorite(item);
                          },
                          child: Icon(
                            Icons.favorite_outlined,
                            color: item.isFavorite == true
                                ? Colors.red
                                : Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
