import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemViewArgs {
  final String image;
  final String name;
  final VoidCallback onDelete;

  const ItemViewArgs(
      {required this.image, required this.name, required this.onDelete});
}

class ItemView extends StatelessWidget {
  final ItemViewArgs itemViewArgs;

  const ItemView({required this.itemViewArgs});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              child: Image.network(
                itemViewArgs.image,
                fit: BoxFit.fill,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                height: 150,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 8),
              child: Text(
                itemViewArgs.name,
                style: GoogleFonts.roboto(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
            )
          ],
        ),
        Positioned(
          right: 7,
          top: 8,
          child: GestureDetector(
            onTap: itemViewArgs.onDelete,
            child: Container(
              height: 32,
              width: 32,
              color: Color(0xff2F54EB),
              child: Align(
                child: Icon(
                  Icons.delete_outline,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
