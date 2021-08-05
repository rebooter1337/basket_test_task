import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'basket_cubit.dart';
import 'item_view.dart';

void main() {
  runApp(Basket());
}

class Basket extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Basket Demo',
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen();

  @override
  Widget build(BuildContext context) => BlocProvider(
      create: (context) => BasketCubit(), child: const MainScreenView());
}

class MainScreenView extends StatelessWidget {
  const MainScreenView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BasketCubit, List<ItemData>>(builder: (context, state) {
      final _basketCubit = BlocProvider.of<BasketCubit>(context);
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff050505),
          title: Text('Меню'),
          actions: [
            Row(
              children: [
                GestureDetector(
                    onTap: _basketCubit.addItem,
                    child: Container(
                        height: 32,
                        width: 32,
                        color: Color(0xff2F54EB),
                        child: Icon(
                          Icons.add,
                          size: 18,
                        ))),
              ],
            )
          ],
        ),
        body: Container(
            color: Color(0xff050505),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 1 / 1,
                ),
                itemCount: state.length,
                itemBuilder: (BuildContext ctx, index) {
                  return ItemView(
                    itemViewArgs: ItemViewArgs(
                        onDelete: () => _basketCubit.deleteItem(index),
                        image: state[index].image,
                        name: state[index].label),
                  );
                })),
      );
    });
  }
}
