import 'package:doafric/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final String text,text1;
  final Function()? press,press1;
  const Button({Key? key, required this.text,required this.text1, required this.press,required this.press1}) : super(key: key);
  @override
  _ButtonState createState() => _ButtonState();
}
class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
          return Row(
            children: [
              Expanded(
                flex: 2,
                child: MaterialButton(
                  height: 45,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color:colorPrimaryDark),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onPressed:widget.press,
                  child: Text(
                    widget.text,
                    style: const TextStyle(
                        fontSize:14,
                        color:colorPrimaryDark,
                        fontWeight: FontWeight.w500,
                        letterSpacing:0.4
                    ),
                  ),
                  color:colorWhite,
                ),
              ),
              const SizedBox(width: 10,),
              Expanded(
                flex: 2,
                child: MaterialButton(
                  height:45,
                  shape: RoundedRectangleBorder(
                      borderRadius:BorderRadius.circular(12)),
                  onPressed:widget.press1,
                  child: Text(
                    widget.text1,
                    style: const TextStyle(
                        fontSize: 14,
                        color:colorWhite,
                        fontWeight: FontWeight.w500,
                        letterSpacing:0.4
                    ),
                  ),
                  color: colorPrimaryDark,
                ),
              ),
            ],
          );

  }
}
