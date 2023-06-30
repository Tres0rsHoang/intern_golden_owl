
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gshoes/bloc/home_bloc/home_event.dart';

import '../bloc/home_bloc/home_bloc.dart';
import '../bloc/home_bloc/home_state.dart';


class Home extends StatelessWidget {
  const Home({super.key, required this.items});
  final List items;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (items.isNotEmpty) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFF777777),
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: width/8,),
                Expanded(child: Container(
                    height: 600,
                    margin: const EdgeInsets.only(left:0, right: 0),
                    decoration: const BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container( width: 60, height: 60, child: Image.asset('lib/assets/images/nike.png')),
                          Text("Our Product", style: TextStyle(fontSize: 30),),
                          Expanded(
                            child: ListView.builder(
                              itemCount: items.length,
                              itemBuilder: (context, position){
                                return Column(
                                  children: [
                                    Container(
                                      width: 300,
                                      height: 300,
                                      decoration: BoxDecoration(
                                          color: HexColor.fromHex(items[position]["color"]),
                                          borderRadius: const BorderRadius.all(Radius.circular(20))
                                      ),
                                      child: Image.network(items[position]["image"]),
                                    ),
                                    SizedBox(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(items[position]["name"], softWrap: true, maxLines: 10, style: const TextStyle(fontSize: 20),),
                                          Text(items[position]["description"], softWrap: true, maxLines: 10,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("\$" + items[position]["price"].toString()),
                                              BlocBuilder<HomeBloc,HomeStates>(
                                                  builder: (context, states){
                                                    List<int> ids = BlocProvider.of<HomeBloc>(context).state.id;
                                                    for (int i =0; i<ids.length;i++) {
                                                      if (ids[i] == position) {
                                                        return ElevatedButton(onPressed: () {
                                                          BlocProvider.of<HomeBloc>(context).add(AddToCart(position));
                                                          }, child: Container(width: 20, height: 20, child:Image.asset('lib/assets/images/check.png')));
                                                      }
                                                    }
                                                    return ElevatedButton(onPressed: () {
                                                      BlocProvider.of<HomeBloc>(context).add(AddToCart(position));
                                                    }, child: Text("Add to cart"));
                                                  }
                                                ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                ),),
                SizedBox(width: width/8,),
                Expanded(child: Container(
                    height: 600,
                    margin: const EdgeInsets.only(right: 0, left: 0),
                    decoration: const BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container( width: 60, height: 60, child: Image.asset('lib/assets/images/nike.png')),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Your cart", style: TextStyle(fontSize: 30),),
                              BlocBuilder<HomeBloc, HomeStates>(
                                  builder: (context, states){
                                    double total = 0.00;
                                    for (int i = 0; i < states.id.length;i++){
                                      total += items[states.id[i]]["price"] * states.amount[i];
                                    }
                                    return Text("\$" + total.toStringAsFixed(2), style: TextStyle(fontSize: 20));
                                  }),
                            ],
                          ),
                          Expanded(
                            child: BlocBuilder<HomeBloc, HomeStates>(
                              builder: (context, states){
                                List<int> ids = BlocProvider.of<HomeBloc>(context).state.id;
                                List<int> amount = BlocProvider.of<HomeBloc>(context).state.amount;
                                return ListView.builder(
                                  itemCount: ids.length,
                                  itemBuilder: (context, position){
                                    return Column(
                                      children: [
                                        Container(
                                          width: 300,
                                          height: 300,
                                          decoration: BoxDecoration(
                                              color: HexColor.fromHex(items[ids[position]]["color"]),
                                              borderRadius: const BorderRadius.all(Radius.circular(20))
                                          ),
                                          child: Image.network(items[ids[position]]["image"]),
                                        ),
                                        SizedBox(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(items[ids[position]]["name"], softWrap: true, maxLines: 10, style: const TextStyle(fontSize: 20),),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("\$" + items[ids[position]]["price"].toString()),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        BlocProvider.of<HomeBloc>(context).add(Add(position));
                                                      },
                                                      child: Container(width: 10, height: 10, child: Image.asset('lib/assets/images/plus.png'))),
                                                  Text(amount[position].toString()),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        BlocProvider.of<HomeBloc>(context).add(Minus(position));
                                                      },
                                                      child: Container(width: 10, height: 10, child: Image.asset('lib/assets/images/minus.png'))),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        BlocProvider.of<HomeBloc>(context).add(Remove(position));
                                                      },
                                                      child: Container(width: 30, height: 30, child: Image.asset('lib/assets/images/trash.png'))),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                ),),
                SizedBox(width: width/8,),
              ],
            )
          ),
        ),
      );
    }
    else {
      return const Center(child: Text("Reading data"),);
    }
  }
}
extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}