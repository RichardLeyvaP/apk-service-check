import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stepper App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentStep = 0;
  List<TextEditingController> textControllers =
      List.generate(6, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stepper App'),
      ),
      body: Stepper(
        steps: [
          Step(
            content: _buildFormStep1(),
            title: const Text('Form 1'),
          ),
          Step(
            content: _buildFormStep2(),
            title: const Text('Form 2'),
          ),
          Step(
            content: _buildFormStep3(),
            title: const Text('Form 3'),
          ),
          Step(
            content: _buildFormStep4(),
            title: const Text('Form 4'),
          ),
        ],
      ),
    );
  }

  Widget _buildFormStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTextField('Field 1'),
        _buildTextField('Field 2'),
        _buildTextField('Field 3'),
        _buildTextField('Field 4'),
        _buildTextField('Field 5'),
        _buildTextField('Field 6'),
        ElevatedButton(
          onPressed: () => _nextStep(),
          child: Text('Siguiente'),
        ),
      ],
    );
  }

  Widget _buildFormStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Add your fields for Step 2 here
        ElevatedButton(
          onPressed: () => _nextStep(),
          child: Text('Siguiente'),
        ),
      ],
    );
  }

  Widget _buildFormStep3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Add your fields for Step 3 here
        ElevatedButton(
          onPressed: () => _nextStep(),
          child: Text('Siguiente'),
        ),
      ],
    );
  }

  Widget _buildFormStep4() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Add your fields for Step 4 here
        ElevatedButton(
          onPressed: () => _generatePdf(),
          child: Text('Generar PDF'),
        ),
        TextButton(
          onPressed: () => _cancel(),
          child: Text('Cancelar'),
        ),
      ],
    );
  }

  Widget _buildTextField(String labelText) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: textControllers[currentStep],
        decoration: InputDecoration(
          labelText: labelText,
        ),
      ),
    );
  }

  void _nextStep() {
    if (currentStep < 3) {
      setState(() {
        currentStep++;
      });
    }
  }

  void _generatePdf() {
    // Implement PDF generation logic here
  }

  void _cancel() {
    // Implement cancel logic here
  }
}
