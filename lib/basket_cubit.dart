import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

const snickersImage =
    'https://pngimg.com/uploads/snickers/small/snickers_PNG98764.png';
const appleImage = 'https://pngimg.com/uploads/apple/apple_PNG12509.png';

const List<String> foodImages = [snickersImage, appleImage];

class ItemData {
  final String label;
  final String image;

  ItemData(this.label, this.image);
}

class BasketCubit extends Cubit<List<ItemData>> {
  List<ItemData> storedItems = [];

  BasketCubit() : super(const []) {
    _loadItems();
  }

  Future<void> _loadItems() async {
    final list = List.generate(
        randomItemCount(),
        (index) => ItemData('Product #$index',
            foodImages[Random().nextInt(foodImages.length)]));
    storedItems.addAll(list);
    emit(list);
  }

  Future<void> deleteItem(int index) async {
    final newList = [...state];
    newList.removeAt(index);
    emit(newList);
  }

  Future<void> addItem() async {
    final list = [...state];
    list.insert(
        0, storedItems[randomItemCount(min: 0, max: storedItems.length - 1)]);
    emit(list);
  }

  static int randomItemCount({int min = 10000, int max = 100000}) =>
      min + Random().nextInt((max + 1) - min);
}
