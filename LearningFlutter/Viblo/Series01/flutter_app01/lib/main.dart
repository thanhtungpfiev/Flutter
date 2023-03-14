import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      home: SafeArea(
          child: Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.pink,
      title: const Text('Cua nàng Flutter'),
    ),
    body: Column(
      // bố trí widget theo chiều dọc
      children: [
        // sử dụng children truyền vào 1 mảng widget
        const Text('Hi bạn, cho mình làm quen nhé!'),
        Row(
          // bố trí 3 button theo chiều ngang
          children: [
            // sử dụng children truyền vào 1 mảng 3 phần tử widget ElevatedButton
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red)),
              onPressed:
                  () {},
              child: const Text('red'), // tạm thời khi click vào button sẽ chưa có tác dụng gì
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.yellow)),
              onPressed: () {},
              child: const Text('yellow'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green)),
              onPressed: () {},
              child: const Text('green'),
            )
          ],
        )
      ],
    ),
  ))));
}
