import 'package:af_watches2/Constants/strings.dart';
import 'package:flutter/material.dart';

class WarningPopup {
  static showWarningDialog(
      BuildContext context, bool success, String errorMessage,{bool warning=false}) {
    final mediaQuery = MediaQuery.of(context);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:const RoundedRectangleBorder(
              borderRadius:  BorderRadius.all(Radius.circular(15.0))),
          backgroundColor: warning? gradient3 :success ? Colors.green : Colors.red,
          content: Container(
            width: mediaQuery.size.width * 0.7,
            height: mediaQuery.size.height * 0.45,
            child: Column(
              children: <Widget>[
                Container(
                  width: mediaQuery.size.height * 0.12,
                  height: mediaQuery.size.height * 0.12,
                  margin: EdgeInsets.only(
                      top: mediaQuery.size.height * 0.03,
                      bottom: mediaQuery.size.height * 0.03),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.white),
                  ),
                  child: Icon( warning?Icons.warning_amber_rounded:
                    success ? Icons.done : Icons.clear,
                    color:Colors.white,
                    size: 50,
                  ),
                ),
                Text(warning?'Warning!':
                  success ? "Success!" : "Error!",
                  style:  const TextStyle(
                    color:  Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(
                  height: mediaQuery.size.height * 0.05,
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    child: Text(
                      errorMessage,
                      textAlign: TextAlign.center,
                      style:  TextStyle(fontSize: 14, color:Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: mediaQuery.size.height * 0.01,
                ),
                Container(
                  width: mediaQuery.size.width * 0.5,
                  height: mediaQuery.size.height * 0.06,
                  margin: EdgeInsets.only(
                    top: mediaQuery.size.height * 0.01,
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.white,
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      success||warning ? "Continue" : "Try Again",
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}