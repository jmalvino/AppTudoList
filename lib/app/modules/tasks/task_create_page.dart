import 'package:app_tudo_list/app/modules/tasks/task_create_controller.dart';
import 'package:app_tudo_list/app/modules/tasks/widgets/calendar_button.dart';
import 'package:app_tudo_list/widgets/customSnackBar.dart';
import 'package:app_tudo_list/widgets/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

class TaskCreatePage extends StatelessWidget {
  final TaskCreateController _controller;
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  TaskCreatePage({Key? key, required TaskCreateController controller})
      : _controller = controller,
        super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close, color: Colors.black),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green[800],
        onPressed: () {
          var formValid = _formKey.currentState?.validate() ?? false;
          if(formValid){
            _controller.save(_descriptionController.text);
            _descriptionController.text = '';
            CustomSnackBar(color: Colors.green[600]!, error: 'Cadastrado com sucesso!').show(context);
          }
        },
        label: const Text('Salvar Task'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Criar Nota',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CustomTextField(
                  controller: _descriptionController,
                  validator: Validatorless.required('Descrição Obrigatória!'),
                  obscureText: false,
                  isObscureText: false,
                  colorPrincipal: Colors.grey[400]!,
                  textFieldColor: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
               Align(
                alignment: Alignment.centerLeft,
                child: CalendarButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
