import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qalbu/common/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

enum TasbihNumber { number33, number99 }

class TasbihPage extends StatefulWidget {
  static const routeName = '/tasbih_page';

  const TasbihPage({Key? key}) : super(key: key);

  @override
  State<TasbihPage> createState() => _TasbihPageState();
}

class _TasbihPageState extends State<TasbihPage> {
  int _counter = 0;
  TasbihNumber? _number = TasbihNumber.number33;
  static const String counterNumberPrefs = 'counterNumber';

  @override
  void initState() {
    super.initState();
    _loadNumber();
  }

  void _incrementCounter() {
    if(_number == TasbihNumber.number33) {
      if(_counter == 32) {
        Vibration.vibrate(duration: 800);
        setState(() {
          _counter++;
          _saveNumber();
        });
      }else if(_counter == 33) {
        HapticFeedback.lightImpact();
        _resetNumber();
      }else {
        setState(() {
          HapticFeedback.lightImpact();
          _counter++;
          _saveNumber();
        });
      }
    }
    if(_number == TasbihNumber.number99) {
      if(_counter == 98) {
        Vibration.vibrate(duration: 800);
        setState(() {
          _counter++;
          _saveNumber();
        });
      }else if(_counter == 99) {
        HapticFeedback.lightImpact();
        _resetNumber();
      }else {
        setState(() {
          HapticFeedback.lightImpact();
          _counter++;
          _saveNumber();
        });
      }
    }
  }

  void _decrementCounter() {
    setState(() {
      HapticFeedback.lightImpact();
      _counter<=0 ? _counter=0 : _counter--;
      _saveNumber();
    });
  }

  void _saveNumber() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(counterNumberPrefs, _counter);
  }

  void _loadNumber() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt(counterNumberPrefs) ?? 0;
    });
  }

  void _resetNumber() async {
    HapticFeedback.lightImpact();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(counterNumberPrefs);
    _loadNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tasbih',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: FittedBox(
                      child: FloatingActionButton(
                        heroTag: 'btnDecrement',
                        backgroundColor: Colors.white,
                        onPressed: _decrementCounter,
                        child: const Icon(
                          Icons.remove,
                          size: 32,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  Text(
                    '$_counter',
                    style: GoogleFonts.poppins(
                      fontSize: 42,
                      fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 30),
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: FittedBox(
                      child: FloatingActionButton(
                        heroTag: 'btnIncrement',
                        backgroundColor: Colors.white,
                        onPressed: _incrementCounter,
                        child: const Icon(
                          Icons.add,
                          size: 32,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: Material(
                elevation: 5,
                shape: const CircleBorder(
                  side: BorderSide(
                    width: 0.5,
                    color: Colors.black12),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: InkWell(
                  onTap: _incrementCounter,
                  child: Image.asset(
                    'assets/icons/tap.png',
                    width: 300,
                  ),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    '33',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  leading: Radio<TasbihNumber>(
                    value: TasbihNumber.number33,
                    groupValue: _number,
                    fillColor: MaterialStateColor.resolveWith((states) => kPrimary),
                    onChanged: (TasbihNumber? value) {
                      setState(() {
                        _number = value;
                        _resetNumber();
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text(
                    '99',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  leading: Radio<TasbihNumber>(
                    value: TasbihNumber.number99,
                    groupValue: _number,
                    fillColor: MaterialStateColor.resolveWith((states) => kPrimary),
                    onChanged: (TasbihNumber? value) {
                      setState(() {
                        _number = value;
                        _resetNumber();
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'btnReset',
        backgroundColor: Colors.white,
        onPressed: _resetNumber,
        child: const Icon(
          Icons.replay,
          size: 32,
          color: Colors.grey,
        ),
      ),
    );
  }
}
