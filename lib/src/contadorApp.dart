import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {
  static const String _title = 'TAREA 2';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Contador(),
    );
  }
}

class Contador extends StatefulWidget {
  @override
  _ContadorState createState() => _ContadorState();
}

class _ContadorState extends State<Contador> with SingleTickerProviderStateMixin {
  int _contar = 0;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _rotationAnimation = Tween<double>(begin: 0.0, end: 2.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void incrementarContador() {
    setState(() {
      _contar = (_contar + 1) % 20;
    });
  }

  void restablecerContador() {
    setState(() {
      _contar = 0;
    });
  }

  void mostrarAlerta() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alerta'),
          content: Text('El Castillo Ambulante" es una película de animación del Studio Ghibli dirigida por Hayao Miyazaki.'),
          actions: [
            TextButton(
              child: Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TAREA 2 por José Araujo',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 33, 243, 226),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Studio Ghibli es un renombrado estudio de animación japonés fundado en 1985 por Hayao Miyazaki e Isao Takahata.',
              style: TextStyle(fontSize: 35.0, color: Colors.blue),
            ),
            SizedBox(height: 20.0),
            GestureDetector(
              onTap: mostrarAlerta,
              child: RotationTransition(
                turns: _rotationAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: CircleAvatar(
                    radius: 100.0,
                    backgroundImage: AssetImage('assets/gibli.jpg'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: incrementarContador,
          ),
          SizedBox(height: 10.0),
          FloatingActionButton(
            child: Icon(Icons.refresh),
            onPressed: restablecerContador,
          ),
          SizedBox(height: 10.0),
          FloatingActionButton(
            child: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          SizedBox(height: 10.0),
          FloatingActionButton(
            child: Icon(Icons.warning),
            onPressed: mostrarAlerta,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
