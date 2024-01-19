// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

class PagePdf extends StatelessWidget {
  const PagePdf({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Service Check PDF',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePdf(),
    );
  }
}

class MyHomePdf extends StatefulWidget {
  const MyHomePdf({super.key});

  @override
  _MyHomePdfState createState() => _MyHomePdfState();
}

class _MyHomePdfState extends State<MyHomePdf> {
  int currentStep = 0;
  List<TextEditingController> textControllers =
      List.generate(7, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Check PDF'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Coloca aquí el código para manejar la acción de retroceder
            Get.back();
          },
        ),
      ),
      body: Stepper(
        currentStep: currentStep,
        onStepContinue: () => _nextStep(),
        onStepCancel: () => _previousStep(),
        steps: [
          Step(
            content: _buildFormStep1(),
            title: const Text('DADOS DO CLIENTE'),
            isActive: currentStep == 0,
          ),
          Step(
            content: _buildFormStep2(),
            title: const Text('DADOS DO INSTRUMENTO'),
            isActive: currentStep == 1,
          ),
          Step(
            content: _buildFormStep3(),
            title: const Text('AFERICÃO/CALIBRACÃO'),
            isActive: currentStep == 2,
          ),
          Step(
            content: _buildFormStep4(),
            title: const Text('PATRÕES UTILIZADOS'),
            isActive: currentStep == 3,
          ),
          Step(
            content: _buildFormStep5(),
            title: const Text('CONVERTER (Final)'),
            isActive: currentStep == 4,
          ),
        ],
        type: StepperType.vertical,
      ),
    );
  }

  Widget _buildFormStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTextField('Empresa'), //branchName
        _buildTextField('Cidade/Estado'), //cityState
        _buildTextField('Contato'), //contact
      ],
    );
  }

  Widget _buildFormStep2() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField('No Relatório'), //numberRelatorie
              _buildTextField('Tag'), //tag
              _buildTextField('Descricão'), //direction
              _buildTextField('Fabricante'), //fabricante
              _buildTextField('Funcão no Proceso'), //functionProceso
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField('Faixa de Calibracão'), //faixa
              _buildTextField('Variável Medida'), //medida
              _buildTextField('F.R.E'), //fre
              _buildTextField('Data Calibracão'), //dataCalibration
              _buildTextField('Data Prox. Calibracão'), //dataNextCalibration
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFormStep3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTextField('aplicada25'), //aplicada25
        _buildTextField('aplicada50'), //aplicada50
        _buildTextField('aplicada75'), //aplicada75
        _buildTextField('aplicada100'), //aplicada100
      ],
    );
  }

  Widget _buildFormStep4() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField('Instrumento Patrão'), //instrument_padrao
              _buildTextField('Certificado'), //certificado
              _buildTextField('Servicos Executados'), //service_execute
              _buildTextField('ART'), //art
              _buildTextField('Técnico'), //tecnico
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField('Modelo'), //model
              _buildTextField('Data afericão'), //date_aferica
              _buildTextField('Enegenheiro'), //ingenier
              _buildTextField('Data'), //data
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFormStep5() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Add your fields for Step 4 here
        ElevatedButton(
          onPressed: () => _generatePdf(),
          child: Text('Gerar PDF'),
        ),
        ElevatedButton(
          onPressed: () => _generatePdf(),
          child: Text('Salvar no banco de dados'),
        ),
      ],
    );
  }

  Widget _buildTextField(String labelText) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        //controller: textControllers[currentStep],
        decoration: InputDecoration(
          labelText: labelText,
        ),
      ),
    );
  }

  void _nextStep() {
    if (currentStep < 4) {
      setState(() {
        currentStep++;
      });
    }
  }

  void _previousStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    }
  }

  void _generatePdf() {
    //llamra aqui el controlador que llama la api
    // Implement PDF generation logic here
  }

  void _cancel() {
    // Implement cancel logic here
  }
}
