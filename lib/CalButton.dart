import 'package:flutter/material.dart';

class CalButton extends StatelessWidget {
  final color; //버튼 색깔
  final textColor; //텍스트 색깔
  final String? buttonText; //버튼 텍스트
  final buttonAction; //버튼 액션

  const CalButton(
      {this.color, this.textColor, this.buttonText, this.buttonAction});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: buttonAction,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                buttonText!,
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: textColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
