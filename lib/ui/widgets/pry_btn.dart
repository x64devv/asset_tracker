import 'package:flutter/material.dart';

import '../constants/theme_data.dart';
import '../utilities/size_config.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton({Key? key, required this.label, required this.onPressed, required this.icon}) : super(key: key);

  final String label;
  final Function onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    double? defaultSize = SizeConfig.defaultSize!;
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(bluishClr),
              textStyle: MaterialStateProperty.all(
                  TextStyle(
                      fontSize: defaultSize * 1.8,
                      fontWeight: FontWeight.normal,
                      color: textColor
                  )
              ),
              elevation: MaterialStateProperty.all(0),
              maximumSize: MaterialStateProperty.all(
                  Size(
                      defaultSize * 30,
                      defaultSize * 5
                  )
              ),
              shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                  )
              )
          ),
          onPressed: (){
            onPressed();
          },
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                ),
                SizedBox(width: defaultSize * 2,),
                Icon(
                    icon
                )
              ],
            ),
          )
      ),
    );
  }
}
