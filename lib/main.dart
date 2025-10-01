import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingflutter/store_view_model.dart';
import 'package:shoppingflutter/widgets/Store_data.dart';
import 'package:shoppingflutter/widgets/icon_box_button.dart';
import 'package:shoppingflutter/widgets/top_search_bar.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_){
        return StoreViewModel();
      })
    ],
      child: MyApp(),)
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(
            158, 183, 250, 1.0),
        primary: Color.fromRGBO(160, 203, 241, 1.0)),
        fontFamily: 'Lato'
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
   const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final TextEditingController _controller = TextEditingController();
  final List<String> items = ['All','Electronics','Clothing','Jewelery'];
  int idx = 0;

  @override
  void initState() {
        super.initState();
        Future.microtask((){
          return context.read<StoreViewModel>().getAllData();
        });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
          child: Column(
            children: [
              TopSearchBar(controller: _controller,onSendClick: (title){
                    setState(() {
                    });
              },),
              SizedBox(height: 8,),
              SizedBox(
                height: 70,
                child: IconBoxButton(items: items,idx: idx,onBoxValueChange: (id){
                  setState((){
                    idx = id;
                  });
                },),
              ),
              Expanded(
                child: StoreDataItems(idx: idx, items: items,searchTitle: _controller.text.trim().toLowerCase(),controller: _controller,)
              ),
        ],
          ),
        ),
      ),
    );
  }
}

// Color.fromRGBO(244, 226, 166, 1.0)






