import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConfirmPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm', style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("asset/image/thumb.png", width: 100),
            const SizedBox(height: 20,),
            Text("Successfully Booked!", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF53B1FD), fontSize: 28),),
            Text("visit our office at your booking time", style: TextStyle()),
            const SizedBox(height: 40,),
            Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF53B1FD),
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CupertinoButton(
                    onPressed: () {
                      context.go("/balance");
                    },
                    child: const Center(
                        child: Text('Confirm', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20))
                    )
                )
            )
          ],
        )
      ),
    );
  }

}