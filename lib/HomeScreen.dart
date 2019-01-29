import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cleanmate_customer_app/tabs/home.dart' as _firstTab;
import 'package:cleanmate_customer_app/tabs/dashboard.dart' as _secondTab;
import 'package:cleanmate_customer_app/tabs/settings.dart' as _thirdTab;
import 'package:cleanmate_customer_app/colorCode/HexColor.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class FromRightToLeft<T> extends MaterialPageRoute<T> {
  FromRightToLeft({ WidgetBuilder builder, RouteSettings settings })
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {

    if (settings.isInitialRoute)
      return child;

    return new SlideTransition(
      child: new Container(
        decoration: new BoxDecoration(
            boxShadow: [
              new BoxShadow(
                color: Colors.black26,
                blurRadius: 25.0,
              )
            ]
        ),
        child: child,
      ),
      position: new Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      )
          .animate(
          new CurvedAnimation(
            parent: animation,
            curve: Curves.fastOutSlowIn,
          )
      ),
    );
  }
  @override Duration get transitionDuration => const Duration(milliseconds: 400);
}
class _HomeScreenState extends State<HomeScreen> {
  Color cl_bar = HexColor("#18b4ed");
  PageController _tabController;

  var _title_app = null;
  int _tab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = new PageController();
    this._title_app = TabItems[0].title;
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      new Scaffold(

        //App Bar
          appBar: new AppBar(
            title: new Text(
              _title_app,
              style: new TextStyle(
                fontSize: Theme
                    .of(context)
                    .platform == TargetPlatform.iOS ? 17.0 : 20.0,
              ),
            ),
            backgroundColor: cl_bar,
            elevation: Theme
                .of(context)
                .platform == TargetPlatform.iOS ? 0.0 : 4.0,
          ),

          //Content of tabs
          body: new PageView(
            controller: _tabController,
            onPageChanged: onTabChanged,
            children: <Widget>[
              new _firstTab.Home(),
              new _secondTab.Dashboard(),
              new _thirdTab.Settings()
            ],
          ),

          //Tabs
          bottomNavigationBar: Theme
              .of(context)
              .platform == TargetPlatform.iOS ?
          new CupertinoTabBar(
            activeColor: Colors.blueGrey,
            currentIndex: _tab,
            onTap: onTap,
            items: TabItems.map((TabItem) {
              return new BottomNavigationBarItem(
                title: new Text(TabItem.title),
                icon: new Icon(TabItem.icon),
              );
            }).toList(),
          ) :
          new BottomNavigationBar(
            currentIndex: _tab,
            onTap: onTap,
            items: TabItems.map((TabItem) {
              return new BottomNavigationBarItem(
                title: new Text(TabItem.title),
                icon: new Icon(TabItem.icon),
              );
            }).toList(),
          ),

          //Drawer
          drawer: new Drawer(
              child: new ListView(
                children: <Widget>[
                  new Container(
                    height: 120.0,
                    child: new DrawerHeader(
                      padding: new EdgeInsets.all(0.0),
                      decoration: new BoxDecoration(
                        color: new Color(0xFFECEFF1),
                      ),
                      child: new Center(
                        child: new FlutterLogo(
                          colors: Colors.blueGrey,
                          size: 54.0,
                        ),
                      ),
                    ),
                  ),
                  new ListTile(
                      leading: new Icon(Icons.local_laundry_service),
                      title: new Text('Service'),
                      onTap: () {
                        Navigator.pop(context);
                        //Navigator.of(context).pushNamed('/ProductList');
                        Navigator.of(context).pushNamed('/Service');
                      }
                  ),
                  new ListTile(
                      leading: new Icon(Icons.history),
                      title: new Text('My Order'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.of(context).pushNamed('/Order');
                      }
                  ),
                  new Divider(),
                  new ListTile(
                      leading: new Icon(Icons.exit_to_app),
                      title: new Text('Sign Out'),
                      onTap: () {
                        _showDialog();
                      }
                  ),
                ],
              )
          )
      );

  void onTap(int tab) {
    _tabController.jumpToPage(tab);
  }

  void onTabChanged(int tab) {
    setState(() {
      this._tab = tab;
    });

    switch (tab) {
      case 0:
        this._title_app = TabItems[0].title;
        break;

      case 1:
        this._title_app = TabItems[1].title;
        break;

      case 2:
        this._title_app = TabItems[2].title;
        break;
    }
  }

  // user defined function
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert"),
          content: new Text("are you sure?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("NO"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            new FlatButton(
              child: new Text("YES"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/Login');
              },
            ),
          ],
        );
      },
    );
  }
}

class TabItem {
  const TabItem({ this.title, this.icon });
  final String title;
  final IconData icon;
}

const List<TabItem> TabItems = const <TabItem>[
  const TabItem(title: 'Store', icon: Icons.store),
  const TabItem(title: 'Favorite', icon: Icons.favorite),
  const TabItem(title: 'Profile', icon: Icons.person)
];

