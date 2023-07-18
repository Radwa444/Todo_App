import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/ui/database/model/task.dart';
import 'package:todo/ui/screen/list/List_screen.dart';
import 'package:todo/ui/screen/Settings/setting_screen.dart';
import 'package:todo/ui/component/addTask.dart';
import 'package:todo/ui/database/MyDatabase.dart';
import 'package:todo/ui/component/dialog.dart';
import '../../component/MYdateUtils.dart';
import '../../provider/AuthProvider.dart';
class Home_screen extends StatefulWidget {
  static const String routeName = 'home';

  @override
  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
  int selected = 0;
  DateTime selectDate=DateTime.now();
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              showDragHandle: true,
              shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white, width: 4),
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              context: context,
              builder: (BuildContext context) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Add new Task',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: [
                          TextField(
                            controller: controller,
                            decoration: const InputDecoration(
                                hintText: 'enter your task'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          'Select Time',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        showMyDatePicker();
                      },
                      child:  Text(Mydate.formatTaskDate(selectDate),
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black12),
                          textAlign: TextAlign.center),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        AddTask();
                      },
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                        child: const Icon(
                          Icons.done,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30,)
                  ],
                );
              }
              );

          const SizedBox(
            height: 50,
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * .2,
        title: const Text(
          'To Do list',
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        color: Colors.transparent,
        shape: const CircularNotchedRectangle(),
        child: BottomNavigationBar(
          currentIndex: selected,
          onTap: (index) {
            selected = index;
            setState(() {});
          },
          items: const [
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("assets/images/icon_list.png")),
                label: 'list'),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("assets/images/icon_settings.png")),
                label: 'settings')
          ],
        ),
      ),
      body: tab[selected],
    );
  }

  List<Widget> tab = [List_screen(), Settings_screen()];
  void  AddTask()  {
    tasks Task=tasks(title: controller.text,done: false,selectTime: selectDate, );

    dialog.hidedialog(context);
    dialog.showMassage(context, 'Do you want to add the task?',positiveAction: 'ok',postive: () async {
      var authProvider=Provider.of<AuthProvider>(context,listen: false);
      await MyDatabase.addtask(authProvider.AccountUser?.id??"", Task);
    });

  }

 void showMyDatePicker()  async {
   selectDate= await showDatePicker(
        context: context,
        initialDate: selectDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)))??selectDate;

   setState(() {

   });
  }
}
