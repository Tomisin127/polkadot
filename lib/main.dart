import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:polkadot_app/screens/wrapper.dart';
import 'package:polkadot_app/item.dart';
import 'package:polkadot_app/services/auth.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.pink[300],
      statusBarColor: Colors.pink[300],
      systemNavigationBarDividerColor: Colors.pink[300],
      systemNavigationBarIconBrightness: Brightness.light));
  runApp(PolkadotApp());
}

class PolkadotApp extends StatefulWidget {
  @override
  _PolkadotAppState createState() => _PolkadotAppState();
}

class _PolkadotAppState extends State<PolkadotApp>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    //SystemChrome.setEnabledSystemUIOverlays(systemNavigationBarColor: Colors.pinkAccent);

    super.initState();
    _tabController = TabController(vsync: this, length: 5);
  }

  @override
  void dispose() {
    _tabController.dispose();
    //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    super.dispose();
  }

  void _nextPage(int delta) {
    final int newIndex = _tabController.index + delta;
    if (newIndex < 0 || newIndex >= _tabController.length) return;
    _tabController.animateTo(newIndex);
  }

  var selectedUser;

  Widget first_page() {
    List<Item> users = <Item>[
      const Item(
          name: 'Android', icon: Icon(Icons.android, color: Colors.green)),
      const Item(
          name: 'Flutter', icon: Icon(Icons.flag, color: Colors.lightBlue)),
      const Item(
          name: 'ReactNative',
          icon: Icon(Icons.format_indent_decrease, color: Colors.blue)),
      const Item(
          name: 'iOS',
          icon: Icon(Icons.mobile_screen_share, color: Colors.black))
    ];
    // Figma Flutter Generator Landing_pageWidget - COMPONENT
    return // Figma Flutter Generator Landing_pageWidget - COMPONENT
        Container(
            width: 360,
            height: 640,
            child: Stack(children: <Widget>[
              Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                      width: 360,
                      height: 640,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                      child: Stack(children: <Widget>[
                        Positioned(
                            top: 27,
                            left: 287,
                            child: IconButton(
                              icon: Icon(Icons.menu),
                              onPressed: () {},
                            )),
                        Positioned(
                            top: 25,
                            left: 20,
                            child: Container(
                                width: 158.87423706054688,
                                height: 36,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/logo-polkadot.png'),
                                      fit: BoxFit.fitWidth),
                                ))),
                        Positioned(
                            top: 193,
                            left: 41,
                            child: Container(
                                width: 283.33331298828125,
                                height: 82,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/Polkadot_Live_Cover.png'),
                                      fit: BoxFit.fitWidth),
                                ))),
                        Positioned(
                            top: 290,
                            left: 7,
                            child: Text(
                              'Polkadot development is on track to deliver the most\n robust platform for security, scalability and innovation.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromRGBO(83, 75, 75, 1),
                                  fontFamily: 'Roboto',
                                  fontSize: 14,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1.5 /*PERCENT not supported*/
                                  ),
                            )),
                        Positioned(
                            top: 382,
                            left: 100,
                            child: Container(
                                width: 165,
                                height: 61,
                                child: Stack(children: <Widget>[
                                  Positioned(
                                      top: 0,
                                      left: 0,
                                      child: FlatButton(
                                        onPressed: () {
                                          int highest =
                                              _tabController.length + 1;
                                          for (int i = 0; i <= highest; i++) {
                                            _nextPage(i);
                                          }
                                        },
                                        child: Container(
                                            width: 165,
                                            height: 61,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(50),
                                                topRight: Radius.circular(50),
                                                bottomLeft: Radius.circular(50),
                                                bottomRight:
                                                    Radius.circular(50),
                                              ),
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 1),
                                              border: Border.all(
                                                color: Color.fromRGBO(
                                                    230, 0, 122, 1),
                                                width: 0.5,
                                              ),
                                            )),
                                      )),
                                  Positioned(
                                      top: 19,
                                      left: 30,
                                      child: Text(
                                        'See Roadmap',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(230, 0, 122, 1),
                                            fontFamily: 'Roboto',
                                            fontSize: 16,
                                            letterSpacing:
                                                0 /*percentages not used in flutter. defaulting to zero*/,
                                            fontWeight: FontWeight.normal,
                                            height:
                                                1.5 /*PERCENT not supported*/
                                            ),
                                      )),

                                  //list of items
                                ]))),
                      ]))),
              Positioned(
                top: 45,
                left: 30,
                child: DropdownButton<Item>(
                  hint: Text('select item'),
                  value: selectedUser,
                  onChanged: (Item value) {
                    setState(() {
                      selectedUser = value;
                    });
                  },
                  items: users.map((Item user) {
                    return DropdownMenuItem<Item>(
                        value: user,
                        child: Row(
                          children: <Widget>[
                            user.icon,
                            SizedBox(width: 10),
                            Text(
                              user.name,
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ));
                  }).toList(),
                ),
              )
            ]));
  }

  Widget second_page() {
    return // Figma Flutter Generator SecondWidget - FRAME
        Container(
            width: 360,
            height: 640,
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 1),
            ),
            child: Stack(children: <Widget>[
              Positioned(
                  top: 446,
                  left: 22,
                  child: Container(
                      width: 311,
                      height: 165,
                      child: Stack(children: <Widget>[
                        Positioned(
                            top: 0,
                            left: 140,
                            child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage('assets/home-icon1.png'),
                                      fit: BoxFit.fitWidth),
                                ))),
                        Positioned(
                            top: 53,
                            left: 0,
                            child: Text(
                              'Easy blockchain innovation',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontFamily: 'Roboto',
                                  fontSize: 24,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1.5 /*PERCENT not supported*/
                                  ),
                            )),
                        Positioned(
                            top: 93,
                            left: 5,
                            child: Text(
                              'Create a custom blockchain in minutes using \n the Substrate framework.\n Connect your chain to Polkadot and get interoperability \n and security from day one. \n',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromRGBO(83, 75, 75, 1),
                                  fontFamily: 'Roboto',
                                  fontSize: 12,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1.5 /*PERCENT not supported*/
                                  ),
                            )),
                      ]))),
              Positioned(
                  top: 225,
                  left: -3,
                  child: Container(
                      width: 361,
                      height: 188,
                      child: Stack(children: <Widget>[
                        Positioned(
                            top: 0,
                            left: 164,
                            child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage('assets/home-icon2.png'),
                                      fit: BoxFit.fitWidth),
                                ))),
                        Positioned(
                            top: 54,
                            left: 31,
                            child: Text(
                              'Economic & transactional \n scalability',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontFamily: 'Roboto',
                                  fontSize: 24,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1.5 /*PERCENT not supported*/
                                  ),
                            )),
                        Positioned(
                            top: 124,
                            left: 0,
                            child: Text(
                              '           Polkadot provides unprecedented economic scalability \n by enabling a common set of validators to secure \n multiple blockchains.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromRGBO(83, 75, 75, 1),
                                  fontFamily: 'Roboto',
                                  fontSize: 12,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1.5 /*PERCENT not supported*/
                                  ),
                            )),
                      ]))),
              Positioned(
                  top: 36,
                  left: -3,
                  child: Container(
                      width: 361,
                      height: 157,
                      child: Stack(children: <Widget>[
                        Positioned(
                            top: 0,
                            left: 164,
                            child: Container(
                                width: 40.875911712646484,
                                height: 40,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage('assets/home-icon3.png'),
                                      fit: BoxFit.fitWidth),
                                ))),
                        Positioned(
                            top: 53,
                            left: 63,
                            child: Text(
                              'True interoperability',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontFamily: 'Roboto',
                                  fontSize: 24,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1.5 /*PERCENT not supported*/
                                  ),
                            )),
                        Positioned(
                            top: 93,
                            left: 0,
                            child: Text(
                              '   Polkadot enables cross-blockchain transfers of any type of data \n or asset, not just tokens. Connecting to Polkadot gives you \n the ability to interoperate with a wide variety of blockchains.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromRGBO(83, 75, 75, 1),
                                  fontFamily: 'Roboto',
                                  fontSize: 12,
                                  letterSpacing:
                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                  fontWeight: FontWeight.normal,
                                  height: 1.5 /*PERCENT not supported*/
                                  ),
                            )),
                      ]))),
            ]));
  }

  Widget third_page() {
    return Container(
        width: 360,
        height: 640,
        decoration: BoxDecoration(
          color: Color.fromRGBO(36, 34, 34, 1),
        ),
        child: Stack(children: <Widget>[
          Positioned(
              top: 41,
              left: 13,
              child: Text(
                'Powering the Polkadot network',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontFamily: 'Roboto',
                    fontSize: 34,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1.5 /*PERCENT not supported*/
                    ),
              )),
          Positioned(
              top: 151,
              left: 28,
              child: Text(
                'The DOT token serves three distinct purposes:\n governance over the network, staking and bonding.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontFamily: 'Roboto',
                    fontSize: 13,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1.5 /*PERCENT not supported*/
                    ),
              )),
          Positioned(
              top: 381,
              left: 16,
              child: Text(
                'Polkadot token holders have complete control \n over the protocol.\n All privileges, which on other platforms are exclusive \n to miners, will be given to the Relay Chain participants \n (DOT holders).\n ',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontFamily: 'Roboto',
                    fontSize: 13,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1.5 /*PERCENT not supported*/
                    ),
              )),
          Positioned(
              top: 338,
              left: 113,
              child: Text(
                'Governance',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontFamily: 'Roboto',
                    fontSize: 24,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1.5 /*PERCENT not supported*/
                    ),
              )),
          Positioned(
              top: 198,
              left: 111,
              child: Container(
                  width: 135.95257568359375,
                  height: 141,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/home-icon-token-1.png'),
                        fit: BoxFit.fitWidth),
                  ))),
          Positioned(
              top: 488,
              left: 116,
              child: Container(
                  width: 131.8798828125,
                  height: 141,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/home-icon-token-2.png'),
                        fit: BoxFit.fitWidth),
                  ))),
        ]));
  }

  Widget fourth_page() {
    return // Figma Flutter Generator FourthWidget - FRAME
        Container(
            width: 360,
            height: 640,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment(70.123234262925839e-17, 1),
                  end: Alignment(-4, 6.123234262925839e-17),
                  colors: [
                    Color.fromRGBO(230, 0, 122, 1),
                    Color.fromRGBO(158, 9, 171, 0.940625011920929),
                    Color.fromRGBO(145, 77, 77, 0)
                  ]),
            ),
            child: Stack(children: <Widget>[
              Positioned(
                  top: 58,
                  left: 13,
                  child: Text(
                    'An open-source protocol \nbuilt for everyone',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontFamily: 'Roboto',
                        fontSize: 30,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1.5 /*PERCENT not supported*/
                        ),
                  )),
              Positioned(
                  top: 520,
                  left: 135,
                  child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/logo-circle-polkadot-js-white.png'),
                            fit: BoxFit.fitWidth),
                      ))),
              Positioned(
                  top: 170,
                  left: 11,
                  child: Text(
                    'Polkadot is an open-source project founded by\nthe Web3 Foundation.',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        letterSpacing: 0,
                        fontWeight: FontWeight.normal,
                        height: 1.5 /*PERCENT not supported*/
                        ),
                  )),
              Positioned(
                  top: 240,
                  left: 11,
                  child: Text(
                    'Web3 Foundation has commissioned five teams \nand over 100 developers to build Polkadot.',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        letterSpacing: 0,
                        fontWeight: FontWeight.normal,
                        height: 1.5 /*PERCENT not supported*/
                        ),
                  )),
              Positioned(
                  top: 425,
                  left: 235,
                  child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/logo-circle-soramitsu-white.png'),
                            fit: BoxFit.fitWidth),
                      ))),
              Positioned(
                  top: 333,
                  left: 135,
                  child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/logo-circle-parity-white.png'),
                            fit: BoxFit.fitWidth),
                      ))),
              Positioned(
                  top: 433,
                  left: 31,
                  child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/logo-circle-chainsafe-white.png'),
                            fit: BoxFit.fitWidth),
                      ))),
            ]));
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: TabBarView(
              controller: _tabController,
              children: [
                first_page(),
                second_page(),
                third_page(),
                fourth_page(),
                Wrapper()
              ].toList()),
        ),
      ),
    );
  }
}
