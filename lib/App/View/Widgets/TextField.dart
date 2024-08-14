import 'package:flutter/material.dart';

class MyTextfield extends StatefulWidget {
  MyTextfield({
    super.key,
    required this.namecontroller,
    required this.title,
    required this.suptitle,
    required this.ispassword,
  });

  final TextEditingController namecontroller;
  final String title;
  final String suptitle;
  final bool ispassword;
  @override
  State<MyTextfield> createState() => _MyTextfieldState();
}

class _MyTextfieldState extends State<MyTextfield> {
  bool issee = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 48,
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: widget.namecontroller,
                      obscureText: widget.ispassword == false ? false : !issee,
                      decoration: InputDecoration(
                          hintText: widget.suptitle, border: InputBorder.none),
                    ),
                  ),
                ),
                if (widget.ispassword)
                  IconButton(
                      onPressed: () {
                        setState(() {
                          issee = !issee;
                        });
                      },
                      icon: Image.asset(
                        issee
                            ? 'assets/icons/invisible.png'
                            : 'assets/icons/visible.png',
                        height: 20,
                      )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
