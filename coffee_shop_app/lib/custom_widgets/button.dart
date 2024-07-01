import 'package:flutter/material.dart';

class ProductButton extends StatefulWidget {
  final int price;

  const ProductButton({Key? key, required this.price}) : super(key: key);

  @override
  _ProductButtonState createState() => _ProductButtonState();
}

class _ProductButtonState extends State<ProductButton> {
  int itemCount = 0; // Начальное количество товара в корзине

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          itemCount++; // Увеличиваем количество товара при нажатии на кнопку
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
        child: Container(
          width: 100,
          height: 24,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color.fromRGBO(205, 180, 219, 1),
          ),
          child: 
            Expanded(
              child: itemCount == 0
                  ? Text(
                    '      ${widget.price} ₽', 
                    style: 
                    const TextStyle(
                      color: Colors.white, 
                      fontSize:16, 
                      fontWeight: FontWeight.bold
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (itemCount > 0) itemCount--;
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
                        Text('$itemCount', style: const TextStyle(color: Colors.white, fontSize:16, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 8.0),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              itemCount++;
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
        ),
      ),
    );
  }
}