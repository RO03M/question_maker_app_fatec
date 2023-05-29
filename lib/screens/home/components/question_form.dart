import 'package:flutter/material.dart';
import 'package:question_maker_app/screens/home/services/question_service.dart';

class QuestionForm extends StatefulWidget {
  const QuestionForm({super.key});

  @override
  State<QuestionForm> createState() => _QuestionFormState();
}

class _QuestionFormState extends State<QuestionForm> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _questionController  = TextEditingController();
  String question = "";

  void onSubmit({bool anonymous = false}) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      QuestionService(context).insertQuestion(question, anonymous);
      setState(() => question = "");
      _questionController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _questionController,
              maxLines: 8,
              maxLength: 1000,
              onSaved: (value) => setState(() => question = value ?? ""),
              validator: (value) {
                if (value == null) return "Insira uma pergunta válida";
                else if (value.isEmpty) return "Insira uma pergunta";
              },
              decoration: const InputDecoration(
                hintText: "Faça sua pergunta",
                labelText: "Faça sua pergunta",
                border: InputBorder.none
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => onSubmit(anonymous: true),
                  child: const Text(
                    "Enviar como anônimo",
                    style: TextStyle(
                      color: Colors.grey
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: onSubmit,
                  child: const Text("Enviar"),
                )
              ],
            )
          ].map((widget) => Padding(padding: EdgeInsets.all(8), child: widget)).toList(),
        )
      ),
    );
  }
}