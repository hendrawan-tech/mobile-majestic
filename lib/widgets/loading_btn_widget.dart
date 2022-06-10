import 'package:flutter/material.dart';

class LoadingBtnWidget extends StatelessWidget {
  const LoadingBtnWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15, right: 40, left: 40),
      decoration: BoxDecoration(
          color: const Color(0xFF73C993),
          borderRadius: BorderRadius.circular(10)),
      height: 48,
      width: double.infinity,
      child: TextButton(
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(
                  Colors.black,
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              'Loading',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
