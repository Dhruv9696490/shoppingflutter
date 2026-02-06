import 'package:flutter/material.dart';
import 'package:shoppingflutter/widgets/Store_data.dart';
import 'package:shoppingflutter/widgets/icon_box_button.dart';
import 'package:shoppingflutter/widgets/top_search_bar.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen2> {
  final TextEditingController _controller = TextEditingController();
  final List<String> items = const [
    'All',
    'Electronics',
    'Clothing',
    'Jewelery',
  ];
  int idx = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
        child: Column(
          children: [
            TopSearchBar(controller: _controller, onSendClick: (title) {}),
            const SizedBox(height: 8),
            SizedBox(
              height: 60,
              child: IconBoxButton(
                items: items,
                idx: idx,
                onBoxValueChange: (id) {
                  setState(() {
                    idx = id;
                  });
                },
              ),
            ),
            Expanded(
              child: StoreDataItems(
                idx: idx,
                items: items,
                searchTitle: _controller.text.trim().toLowerCase(),
                controller: _controller,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
