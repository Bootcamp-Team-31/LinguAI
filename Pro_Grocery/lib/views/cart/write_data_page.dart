import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WriteDataPage extends StatefulWidget {
  const WriteDataPage({super.key});

  @override
  State<WriteDataPage> createState() => _WriteDataPageState();
}

class _WriteDataPageState extends State<WriteDataPage> {
  late TextEditingController _nameController;
  late TextEditingController _surnameController;
  late TextEditingController _userNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _ageController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _surnameController = TextEditingController();
    _userNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _ageController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mainWidget(),
    );
  }

  Widget mainWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildTextField('Name', _nameController),
          buildTextField('Surname', _surnameController),
          buildTextField('User Name', _userNameController),
          buildTextField('Email', _emailController),
          buildTextField('Password', _passwordController),
          buildTextField('Age', _ageController),
          const SizedBox(height: 20),
          buildButton('Save Data', Colors.green, saveDataFunction),
          const SizedBox(height: 20),
          buildButton('Update Data', Colors.yellow, updateDataFunction),
          const SizedBox(height: 20),
          buildButton('Delete Data', Colors.red, deleteDataFunction)
        ],
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget buildButton(String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: color,
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  saveDataFunction() async {
    // Kullanıcı verilerini eklemek için yeni bir belge ekle
    Map<String, dynamic> saveData = {
      'name': _nameController.text,
      'surname': _surnameController.text,
      'userName': _userNameController.text,
      'email': _emailController.text,
      'password': _passwordController.text,
      'age': int.parse(_ageController.text),
      'follow': 0, // Initialize follow count to 0
      'follower': 0, // Initialize follower count to 0
      'puan': 0, // Initialize puan to 0
    };
    await FirebaseFirestore.instance
        .collection('User')
        .add(saveData); // Yeni belge ekle
  }

  updateDataFunction() async {
    // Güncellenen ID'yi almak için bir TextField ekleyebilir veya bir kullanıcı seçme yöntemi kullanabilirsiniz.
    // Burada örnek olarak 1 ID'li kullanıcıyı güncelliyoruz.
    String documentId = 'ID_TO_UPDATE';

    Map<String, dynamic> updateData = {
      'name': _nameController.text,
      'surname': _surnameController.text,
      'userName': _userNameController.text,
      'email': _emailController.text,
      'password': _passwordController.text,
      'age': int.parse(_ageController.text),
      // Güncelleme sırasında follow, follower ve puan alanlarını ihmal edebilirsiniz
    };

    await FirebaseFirestore.instance
        .collection('User')
        .doc(documentId) // Güncellenecek belgeyi seç
        .update(updateData);
  }

  deleteDataFunction() async {
    // Silinecek ID'yi almak için bir TextField ekleyebilir veya bir kullanıcı seçme yöntemi kullanabilirsiniz.
    // Burada örnek olarak 1 ID'li kullanıcıyı siliyoruz.
    String documentId = 'ID_TO_DELETE';

    await FirebaseFirestore.instance
        .collection('User')
        .doc(documentId) // Silinecek belgeyi seç
        .delete();
  }

  getDataFunction() async {
    await FirebaseFirestore.instance
        .collection('User')
        .get()
        .then((value) {

    });
  }
}
