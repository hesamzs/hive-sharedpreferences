import 'package:flutter/material.dart';
import 'package:hive_sharedpref_gnav_tabbar/core/hive/box.dart';
import 'package:hive_sharedpref_gnav_tabbar/core/hive/person.dart';
import 'package:hive_sharedpref_gnav_tabbar/widgets/custom_btn.dart';
import 'package:hive_sharedpref_gnav_tabbar/widgets/custom_textfield.dart';

import '../widgets/custom_textstyle.dart';

class HivePage extends StatefulWidget {
  const HivePage({Key? key}) : super(key: key);

  @override
  State<HivePage> createState() => _HivePageState();
}

class _HivePageState extends State<HivePage> with TickerProviderStateMixin {
  late TabController _tabController;

  TextEditingController Name_Controller = TextEditingController();
  TextEditingController lastName_Controller = TextEditingController();
  TextEditingController Age_Controller = TextEditingController();
  TextEditingController PhoneNumber_Controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
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
            "Hive Flutter CRUD",
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
              child: Text("Create"),
            ),
            Tab(
              child: Text("Read / Update"),
            ),
            Tab(
              child: Text("Delete"),
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              HiveCreate(),
              HiveRead(),
              HiveDelete(),
            ],
          ),
        ),
      ],
    );
  }

  Widget HiveCreate() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          InputItems("Name", Name_Controller),
          InputItems("Last Name", lastName_Controller),
          InputItems("Age", Age_Controller),
          InputItems("Phone Number", PhoneNumber_Controller),
          CustomBtn().CBTN1("Save", () {
            if (Name_Controller.text != "" && lastName_Controller.text != "" && Age_Controller.text != "" && PhoneNumber_Controller.text != "") {
              boxPersons
                  .add(
                    Person(
                      Name: Name_Controller.text,
                      lastName: lastName_Controller.text,
                      Age: Age_Controller.text,
                      PhoneNumber: PhoneNumber_Controller.text,
                      CreatedAt: DateTime.now(),
                      UpdatedAt: DateTime.now(),
                    ),
                  )
                  .then((value) {});
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Saved !'),
                  duration: Duration(seconds: 1),
                ),
              );
            }
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Fill All !'),
                duration: Duration(seconds: 1),
              ),
            );
            Name_Controller.text = "";
            lastName_Controller.text = "";
            Age_Controller.text = "";
            PhoneNumber_Controller.text = "";

            setState(() {});
          }),
        ],
      ),
    );
  }

  Widget HiveRead() {
    Future<void> _showMyDialog(
      int index,
      Person person,
    ) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          Name_Controller.text = person.Name;
          lastName_Controller.text = person.lastName;
          Age_Controller.text = person.Age;
          PhoneNumber_Controller.text = person.PhoneNumber;
          return StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) setState) {
              return AlertDialog(
                title: const Text('Edit'),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      InputItemsEdit("Name", Name_Controller),
                      InputItemsEdit("Last Name", lastName_Controller),
                      InputItemsEdit("Age", Age_Controller),
                      InputItemsEdit("Phone Number", PhoneNumber_Controller),
                    ],
                  ),
                ),
                actions: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        child: const Text('Close'),
                        onPressed: () {
                          Name_Controller.text = "";
                          lastName_Controller.text = "";
                          Age_Controller.text = "";
                          PhoneNumber_Controller.text = "";
                          setState(() {});
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Save'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Edit Saved !'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                          setState(
                            () {
                              boxPersons.putAt(
                                index,
                                Person(
                                  Name: Name_Controller.text,
                                  lastName: lastName_Controller.text,
                                  Age: Age_Controller.text,
                                  PhoneNumber: PhoneNumber_Controller.text,
                                  CreatedAt: person.CreatedAt,
                                  UpdatedAt: DateTime.now(),
                                ),
                              );
                              Name_Controller.text = "";
                              lastName_Controller.text = "";
                              Age_Controller.text = "";
                              PhoneNumber_Controller.text = "";
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      );
    }

    return boxPersons.length == 0 ? Center(child: Text("Nothing to Show !",style: CustomTextStyle().style1(),),):ListView.builder(
      itemCount: boxPersons.length,
      itemBuilder: (BuildContext context, int index) {
        Person person = boxPersons.getAt(index);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 25,
                  right: 20,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        boxPersons.deleteAt(index);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Deleted !'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.delete_outline_rounded,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
                Positioned(
                  top: 70,
                  right: 20,
                  child: GestureDetector(
                    onTap: () {
                      _showMyDialog(
                        index,
                        person,
                      ).then((value) => setState((){}));
                    },
                    child: const Icon(
                      Icons.edit,
                      color: Colors.blue,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 2,
                    ),
                    TextItems("Name", person.Name),
                    TextItems("Last Name", person.lastName),
                    TextItems("Phone Number", person.PhoneNumber),
                    TextItems("Age", person.Age),
                    TextItems(
                      "Created At ",
                      "${person.CreatedAt.year}/${person.CreatedAt.month}/${person.CreatedAt.day} - ${person.CreatedAt.hour}:${person.CreatedAt.minute}:${person.CreatedAt.second}",
                    ),
                    TextItems(
                      "Updated At",
                      "${person.UpdatedAt.year}/${person.UpdatedAt.month}/${person.UpdatedAt.day} - ${person.UpdatedAt.hour}:${person.UpdatedAt.minute}:${person.UpdatedAt.second}",
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget HiveDelete() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: CustomBtn().CBTN1(
          "Clear Hive",
          () {
            setState(
              () {
                boxPersons.clear();
              },
            );
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Cleared !'),
                duration: Duration(seconds: 1),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget TextItems(String text, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0, left: 8, bottom: 2),
      child: Text(
        "$text : $value",
        style: CustomTextStyle().style4(),
      ),
    );
  }

  Widget InputItems(String text, TextEditingController _controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "$text : ",
              style: CustomTextStyle().style3(),
            ),
          ),
          CustomTextField().CTField1(text, _controller),
        ],
      ),
    );
  }

  Widget InputItemsEdit(String text, TextEditingController _controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "$text : ",
              style: CustomTextStyle().style5(),
            ),
          ),
          CustomTextField().CTField2(text, _controller),
        ],
      ),
    );
  }
}
