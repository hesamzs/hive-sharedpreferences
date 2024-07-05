import 'package:flutter/material.dart';
import 'package:hive_sharedpref_gnav_tabbar/widgets/custom_textfield.dart';
import 'package:numberpicker/numberpicker.dart';

import '../core/sharedpref/sharedpref_core.dart';
import '../widgets/custom_btn.dart';
import '../widgets/custom_textstyle.dart';

class SharedPref extends StatefulWidget {
  const SharedPref({Key? key}) : super(key: key);

  @override
  State<SharedPref> createState() => _SharedPrefState();
}

class _SharedPrefState extends State<SharedPref> with TickerProviderStateMixin {
  late TabController _tabController;

  int _currentIntValue = 10;
  final TextEditingController _controller = TextEditingController();
  bool? isChecked = true;

  String ReadInt = "Null";
  String ReadBool = "Null";
  String ReadString = "Null";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "SharedPreferences Flutter CRUD",
            style: CustomTextStyle().style1(),
          ),
        ),
        TabBar(
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.blueAccent,
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.blueAccent,
          labelPadding: const EdgeInsets.symmetric(horizontal: 20),
          tabs: const [
            Tab(
              child: Text("Save / Update"),
            ),
            Tab(
              child: Text("Read"),
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              SharedPref_Save(),
              SharedPref_Read(),
            ],
          ),
        ),
      ],
    );
  }

  Widget SharedPref_Save() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Save Int",
                        style: CustomTextStyle().style3(),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: NumberPicker(
                          value: _currentIntValue,
                          axis: Axis.horizontal,
                          itemWidth: 50,
                          minValue: 0,
                          maxValue: 20,
                          step: 1,
                          haptics: true,
                          onChanged: (value) => setState(() => _currentIntValue = value),
                        ),
                      ),
                    ),
                  ],
                ),
                CustomBtn().CBTN1(
                  "Save Int",
                  () {
                    SharedPrefCore().saveToInt(_currentIntValue).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Saved !'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    });
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Save Boolean",
                        style: CustomTextStyle().style3(),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Checkbox(
                          tristate: false,
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                CustomBtn().CBTN1(
                  "Save Boolean",
                  () {
                    SharedPrefCore().saveToBool(isChecked).then((value) {
                      SharedPrefCore().saveToInt(_currentIntValue).then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Saved !'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      });
                    });
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Save String",
                        style: CustomTextStyle().style3(),
                      ),
                    ),
                    CustomTextField().CTField1("String", _controller)
                  ],
                ),
                CustomBtn().CBTN1(
                  "Save String",
                  () {
                    SharedPrefCore().saveToString(_controller.text).then((value) {
                      SharedPrefCore().saveToInt(_currentIntValue).then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Saved !'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      });
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget SharedPref_Read() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Read Int",
                        style: CustomTextStyle().style3(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(ReadInt),
                    ),
                  ],
                ),
                CustomBtn().CBTN1(
                  "Read Int",
                  () {
                    SharedPrefCore.getInt().then(
                      (value) => setState(
                        () {
                          ReadInt = value.toString();
                        },
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Loaded !'),
                        duration: Duration(seconds: 1),
                      ),
                    );

                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Read Boolean",
                        style: CustomTextStyle().style3(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(ReadBool),
                    ),
                  ],
                ),
                CustomBtn().CBTN1(
                  "Read Boolean",
                  () {
                    SharedPrefCore.getBool().then(
                      (value) => setState(
                        () {
                          ReadBool = value.toString();
                        },
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Loaded !'),
                        duration: Duration(seconds: 1),
                      ),
                    );

                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Read String",
                        style: CustomTextStyle().style3(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(ReadString),
                    ),
                  ],
                ),
                CustomBtn().CBTN1(
                  "Read String",
                  () {
                    SharedPrefCore.getString().then(
                      (value) => setState(
                        () {
                          ReadString = value;
                        },
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Loaded !'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
