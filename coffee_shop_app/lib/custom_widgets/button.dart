import 'package:flutter/material.dart';

class ProductButton extends StatefulWidget {
  final int price;

  ProductButton({Key? key, required this.price}) : super(key: key);

  @override
  _ProductButtonState createState() => _ProductButtonState();
}

class _ProductButtonState extends State<ProductButton> {
  int totalItemsInCart = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (totalItemsInCart < 10) {
            totalItemsInCart++;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Максимальное количество товаров в корзине - 10'),
              ),
            );
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(205, 180, 219, 1),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 100.0,
              height: 25,
              child: totalItemsInCart == 0
                  ? Text(
                      '       ${widget.price} ₽     ',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (totalItemsInCart > 0) totalItemsInCart--;
                            });
                          },
                          child: Container(
                            width: 24.0,
                            height: 24.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                            ),
                            child: const Icon(Icons.remove, color: Color.fromRGBO(205, 180, 219, 1)),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Text('$totalItemsInCart', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 8.0),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (totalItemsInCart < 10) {
                                totalItemsInCart++;
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Максимальное количество товаров в корзине - 10'),
                                  ),
                                );
                              }
                            });
                          },
                          child: Container(
                            width: 24.0,
                            height: 24.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Icon(Icons.add, color: Color.fromRGBO(205, 180, 219, 1)),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}