import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//giao diện cập nhật thông tin người dùng
class UpdateInfoView extends StatelessWidget {
  const UpdateInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Information'),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        child: InputForm(),
      ),
    );
  }
}

class InputForm extends StatefulWidget {
  const InputForm({super.key});

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController doBController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController sexController = TextEditingController();
  List<String> bloodItems = ['A', 'B', 'AB', 'O'];
  String? selectedBlood = 'A';
  List<String> sexItems = ['Male', 'Female', 'Other'];
  String? selectedSex = 'Male';
  DateTime? dateTime;
  String? formatDate;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: buildName(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: buildDoB(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: buildHeightAndWeight(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: buildBloodAndSex(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: buildButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildName() {
    return TextFormField(
      controller: nameController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Type your name here",
        labelText: 'Name',
      ),
      validator: (value) {
        return (value!.isEmpty) ? 'Name is required' : null;
      },
    );
  }

  Widget buildDoB() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(25),
          ),
          child: TextButton(
              onPressed: () {
                _showDatePicker();
              },
              child: const Text(
                'Choose your date of birth',
                style: TextStyle(fontSize: 15, color: Colors.black),
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            'Your choose: ${formatDate ?? ' '}',
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }

  //bảng chọn lịch
  void _showDatePicker() {
    showDatePicker(
            context: context,
            firstDate: DateTime(1930),
            lastDate: DateTime.now())
        .then((value) {
      setState(() {
        dateTime = value!;
        formatDate = DateFormat('dd/MM/yyyy').format(dateTime!);
      });
    });
  }

  Widget buildHeightAndWeight() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: TextFormField(
                  controller: weightController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Weight',
                      labelText: 'Weight'),
                  keyboardType: TextInputType.number),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 4.0),
              child: Text('(kg)', style: TextStyle(fontSize: 20)),
            )
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: TextFormField(
                controller: heightController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Height',
                    labelText: 'Height'),
                keyboardType: TextInputType.number,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 4.0),
              child: Text('(cm)', style: TextStyle(fontSize: 20)),
            )
          ],
        )
      ],
    );
  }

  Widget buildBloodAndSex() {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                labelText: 'Blood type',
              ),
              value: selectedBlood,
              items: bloodItems
                  .map((item) =>
                      DropdownMenuItem<String>(value: item, child: Text(item)))
                  .toList(),
              onChanged: (item) => setState(() => selectedBlood = item)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 100.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.25,
            child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    labelText: 'Sex'),
                value: selectedSex,
                items: sexItems
                    .map((item) => DropdownMenuItem<String>(
                        value: item, child: Text(item)))
                    .toList(),
                onChanged: (item) => setState(() => selectedSex = item)),
          ),
        )
      ],
    );
  }

  //xây dựng nút hủy cập nhật và nút lưu
  Widget buildButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.35,
          height: 55,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(25),
          ),
          child: TextButton(
              onPressed: () {},
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 20, color: Colors.redAccent),
              )),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.35,
          height: 55,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.lightBlueAccent),
              borderRadius: BorderRadius.circular(25),
              color: Colors.lightBlueAccent),
          child: TextButton(
              onPressed: () {
                String name = nameController.text;
                String doB = dateTime.toString();
                String height = heightController.text;
                String weight = weightController.text;
                String sex = sexController.text;
              },
              child: const Text(
                'Save',
                style: TextStyle(fontSize: 20, color: Colors.white),
              )),
        )
      ],
    );
  }
}
