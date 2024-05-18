import 'package:flutter/material.dart';
import 'package:app/main.dart';
import 'package:app/pages/generar_page.dart';
import 'package:app/pages/visualizar_page.dart';
import 'package:app/pages/validar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/pages/settings.dart';
import 'package:app/pages/profile.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User? user;
  String result = '';
  int _selectedTab = 1;

  @override
  void initState() {
    super.initState();
    user = supabase.auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 20,
        shadowColor: Colors.black,
        title: Image.asset(
          'lib/images/virtu.png',
          width: 120,
          fit: BoxFit.cover,
        ),
      ),
      body: 
      Container(
        padding: const EdgeInsets.all(30.0),
        child: ListView(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GenerarVisita()),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 0, 81, 121),
                ),
                padding: const EdgeInsets.all(20.0),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 50,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Generar visita",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                print(user!.id);
                if (user?.id != null) {
                  final data = await supabase
                      .from('visitas_registro')
                      .select()
                      .eq('usuario', user!.id);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VisualizarPage(data: data)),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Usuario no autenticado',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 0, 81, 121),
                ),
                padding: const EdgeInsets.all(20.0),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.view_list,
                      size: 50,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Visualizar elementos",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                // Navegar a la pantalla de inicio
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Home()));
                var res = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QRViewExample(),
                    ));
                setState(() {
                  if (res is String) {
                    result = res;
                  }
                });
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 0, 81, 121),
                ),
                padding: const EdgeInsets.all(20.0),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check,
                      size: 50,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Validar datos",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
          left: 16,
          right: 16,
        ),
        child: BottomAppBar(
          elevation: 0.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              height: 80,
              color: const Color.fromARGB(255, 0, 81, 121),
              child: Row(
                children: [
                  navItem(
                    Icons.settings,
                    _selectedTab == 0,
                    onTap: () => _onNavItemTapped(0),
                  ),
                  
                  navItem(
                    Icons.person,
                    _selectedTab == 1,
                    onTap: () => {
                      _onNavItemTapped(1)
                      },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget navItem(IconData icon, bool selected, {Function()? onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Icon(
          icon,
          color: selected ? Colors.white : Colors.white.withOpacity(0.4),
        ),
      ),
    );
  }

  void _onNavItemTapped(int index) {
    if (index != _selectedTab) {
      setState(() {
        _selectedTab = index;
      });
    } else {
      // If the user taps on the same tab, you can implement additional logic here
      print('Same tab pressed');
    }
    switch (index) {
    case 0:
      // Navigation to the Home Page
      Navigator.push(context, MaterialPageRoute(builder: (context) => settings()));
      break;
    case 1:
      // Navigation to the Notifications Page
      Navigator.push(context, MaterialPageRoute(builder: (context) => profile()));
      break;
  }
  }
}