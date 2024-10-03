import 'package:app_tudo_list/app/modules/tasks/task_create_controller.dart';
import 'package:app_tudo_list/app/modules/tasks/widgets/calendar_button.dart';
import 'package:app_tudo_list/widgets/customSnackBar.dart';
import 'package:app_tudo_list/widgets/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:validatorless/validatorless.dart';

class TaskCreatePage extends StatefulWidget {
  final TaskCreateController _controller;

  TaskCreatePage({Key? key, required TaskCreateController controller})
      : _controller = controller,
        super(key: key);

  @override
  State<TaskCreatePage> createState() => _TaskCreatePageState();
}

class _TaskCreatePageState extends State<TaskCreatePage> {
  final TextEditingController _descriptionController = TextEditingController();
  bool _isChecked = false;
  final TextEditingController _dividoEmController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dividoEmController.text = '1';
  }

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
          if (formValid) {
            widget._controller.save(_descriptionController.text, _dividoEmController.text);
            _descriptionController.text = '';
            CustomSnackBar(color: Colors.green[600]!, error: 'Cadastrado com sucesso!').show(context);
            _dividoEmController.text = '1';
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
                alignment: Alignment.centerLeft,
                child: Text(
                  'Task',
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
              Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CalendarButton(),
                  ),
                  Checkbox(
                    activeColor: _isChecked ? Colors.green[600] : Colors.grey,
                    value: _isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value ?? false;
                      });
                    },
                  ),
                  const Expanded(child: Text('Divisão?', overflow: TextOverflow.ellipsis),),
                ],
              ),
              const SizedBox(height: 10),
              Visibility(
                visible: _isChecked,
                child: Row(
                  children: [
                    const Text(
                    'Quant.\ndivisão ',
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(width:10 ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: MediaQuery.of(context).size.width * .25,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: CustomTextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          controller: _dividoEmController,
                          validator: Validatorless.required('Insira um valor'),
                          obscureText: false,
                          isObscureText: false,
                          colorPrincipal: Colors.grey[400]!,
                          textFieldColor: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
