import 'package:flutter/material.dart';
import 'contact_list_class.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  final List<Contact> _contacts = [];
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _numberTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: const Center(
          child: Text(
            'Contact List',
            style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(35),
              topLeft: Radius.circular(35))
        ),
        backgroundColor:Color(0xff455764),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameTEController,
                decoration: const InputDecoration(labelText: 'Enter Name'),
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value){
                  if(value?.trim().isEmpty ?? true){
                    return 'Enter your name';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 10,),

              TextFormField(
                controller: _numberTEController,
                decoration: const InputDecoration(labelText: 'Enter Number'),
                keyboardType: TextInputType.phone,
                //autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value){
                  if(value?.trim().isEmpty ?? true){
                    return 'Enter your number';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: double.maxFinite,
                child:  _buildElevatedButton(),
              ),

              const SizedBox(height: 40,),
              Expanded(
                child: _buildListView(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton _buildElevatedButton() {
    return ElevatedButton(
                onPressed: () {
                  if(_formKey.currentState!.validate()){
                    final name = _nameTEController.text;
                    final number = _numberTEController.text;
                    if (name.isNotEmpty && number.isNotEmpty) {
                      _addContact(name, number);
                      _nameTEController.clear();
                      _numberTEController.clear();
                    }
                  }
                },
                child: const Text('Add'),
              );
  }

  ListView _buildListView() {
    return ListView.separated(
              itemCount: _contacts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () => _showDeleteDialog(index),
                  child: Container(
                    //color: Colors.black,
                    color: Color(0xffe1dbdb),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ListTile(
                        title: Text(_contacts[index].name, style: const TextStyle(color: Color(
                            0xfff52515), fontWeight: FontWeight.bold),),
                        leading: const Icon(Icons.person, color: Color(0xff9b5555),size: 38,),
                        subtitle: Text(_contacts[index].number),
                        trailing: const Icon(Icons.call, color: Colors.blue, size: 30,),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  thickness: 3,
                );
              },
    );
  }

  void _addContact(String name, String number) {
    setState(() {
      _contacts.add(Contact(name, number));
    });
  }

  void _deleteContact(int index) {
    setState(() {
      _contacts.removeAt(index);
    });
  }

  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
        ),
        title: Text('Confirmation'),
        content: Text('Are you sure for Delete?'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.cancel,color: Colors.blue,),
          ),
          IconButton(
              onPressed: () {
                _deleteContact(index);
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.delete_outline, color: Colors.blue,)
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameTEController.dispose();
    _numberTEController.dispose();
    super.dispose();
  }
}

