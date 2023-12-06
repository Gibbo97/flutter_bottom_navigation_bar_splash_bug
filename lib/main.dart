import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  Widget? current;

  late final Records? records;
  late final Tasks? tasks;
  late final SettingsScreen? settings;
  late final AccountScreen? account;

  @override
  void initState() {
    super.initState();

    records = Records();
    tasks = Tasks();
    settings = SettingsScreen();
    account = AccountScreen();
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<BottomNavigationBarItem> navItems = <BottomNavigationBarItem>[];

    const BottomNavigationBarItem recordsItem = BottomNavigationBarItem(
      icon: Icon(Icons.info_outline, color: Colors.black),
      label: "records",
      //key: ValueKey(label),
    );
    const BottomNavigationBarItem tasksItem = BottomNavigationBarItem(
      icon: Icon(Icons.calendar_today, color: Colors.black),
      label: "tasks",
      //key: ValueKey(label),
    );
    const BottomNavigationBarItem settingsItem = BottomNavigationBarItem(
      icon: Icon(Icons.settings, color: Colors.black),
      label: "settings",
      //key: ValueKey(label),
    );
    const BottomNavigationBarItem accountItem = BottomNavigationBarItem(
      icon: Icon(Icons.person, color: Colors.black),
      label: "account",
      //key: ValueKey(label),
    );

    bool showTasks(Widget? page) {
      if (page == records) {
        return true;
      } else if (page == tasks) {
        return true;
      } else if (page == account) {
        return false;
      } else if (page == settings) {
        return false;
      }

      return true;
    }

    navItems.addAll([recordsItem, if (showTasks(current)) tasksItem, settingsItem, accountItem]);

    int getCurrentPageIndex(List<BottomNavigationBarItem> navItems, Widget? page) {
      if (page == records) {
        return navItems.indexOf(recordsItem);
      } else if (page == tasks) {
        return navItems.indexOf(tasksItem);
      } else if (page == account) {
        return navItems.indexOf(accountItem);
      } else if (page == settings) {
        return navItems.indexOf(settingsItem);
      }

      return 0;
    }

    int currentIndex = getCurrentPageIndex(navItems, current);

    Widget getWidgetByNavBarItem(BottomNavigationBarItem item) {
      if (item == recordsItem) {
        return records!;
      } else if (item == tasksItem) {
        return tasks!;
      } else if (item == settingsItem) {
        return settings!;
      } else if (item == accountItem) {
        return account!;
      }

      return Text("Error: unknown page");
    }

    void show(Widget? current) {
      if (current != null) {
        setState(() {
          this.current = current;
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        surfaceTintColor: Colors.transparent,
        notchMargin: 2,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          items: navItems,
          currentIndex: currentIndex,
          onTap: (int index) {
            final BottomNavigationBarItem navItem = navItems[index];
            final Widget widget = getWidgetByNavBarItem(navItem);

            show(widget);
          },
        ),
      ),
    );
  }
}

class Records extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("records");
  }
}

class Tasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("tasks");
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("settings");
  }
}

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("account");
  }
}
