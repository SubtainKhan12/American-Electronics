import 'package:flutter/material.dart';
import '../../../Utilities/Colors/colors.dart';
import '../../../Utilities/Loader/loader.dart';

class AddUserUI extends StatefulWidget {
  const AddUserUI({super.key});

  @override
  State<AddUserUI> createState() => _AddUserUIState();
}

class _AddUserUIState extends State<AddUserUI> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _loginIdController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  String? status, type = 'Installer';
  bool _obscureText = true;

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  String? validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid mobile number';
    }
    if (!RegExp(r'^03[0-9]{2}[0-9]{7}$').hasMatch(value)) {
      return 'Invalid mobile number format';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid email';
    }
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value)) {
      return 'Invalid email format';
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add User',
          style: TextStyle(color: ColorsUtils.whiteColor),
        ),
        backgroundColor: ColorsUtils.appcolor,
        iconTheme: IconThemeData(color: ColorsUtils.whiteColor),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Opacity(
              opacity: 0.2,
              child: Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.25),
                child: Image.asset('assets/AELogo.png'),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Form(
                key: _formKey,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Text('Fill out the form bellow to create a \nnew user',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
                      Container(
                        width: MediaQuery.of(context).size.width / 0.3,
                        height: MediaQuery.of(context).size.height / 16,
                        child: TextField(
                          controller: _loginIdController,
                          decoration: InputDecoration(
                            labelText: "Login Id",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5,),
                      Container(
                        width: MediaQuery.of(context).size.width / 0.3,
                        height: MediaQuery.of(context).size.height / 16,
                        child: TextField(
                          controller: _loginIdController,
                          decoration: InputDecoration(
                            labelText: "Employee Code",
                            hintText: '##-##-###',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 0.3,
                        height: MediaQuery.of(context).size.height / 16,
                        child: TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: "Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints.tightFor(width: MediaQuery.of(context).size.width / 0.3,
                          height: MediaQuery.of(context).size.height / 14,),
                        child: TextFormField(
                          controller: _mobileController,
                          keyboardType: TextInputType.number,
                          maxLength: 11,
                          decoration: InputDecoration(
                            labelText: "Mobile No",
                            counterText: '',
                            suffixIcon: Icon(Icons.phone_android),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          validator: validateMobile,
                        ),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints.tightFor(width: MediaQuery.of(context).size.width / 0.3,
                          height: MediaQuery.of(context).size.height / 14,),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: "Email",
                            suffixIcon: Icon(Icons.mail_outline),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          validator: validateEmail,
                        ),
                      ),
                      // SizedBox(height: 5,),

                      Container(
                        width: MediaQuery.of(context).size.width / 0.3,
                        height: MediaQuery.of(context).size.height / 16,
                        child: TextField(
                          controller: _passwordController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            suffix: IconButton(
                              onPressed: _toggleObscureText,
                              icon: Icon(_obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                            labelText: "Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 0.3,
                        height: MediaQuery.of(context).size.height / 16,
                        child: DropdownButtonFormField<String>(
                          value: type,
                          onChanged: (newValue) {
                            setState(() {
                              type = newValue;
                            });
                          },
                          items: <String>['Admin', 'Installer']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            labelText: "Type",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(3),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      // DropdownButtonFormField<String>(
                      //   value: status,
                      //   onChanged: (newValue) {
                      //     setState(() {
                      //       status = newValue;
                      //     });
                      //   },
                      //   items: <String>['Yes', 'No']
                      //       .map<DropdownMenuItem<String>>((String value) {
                      //     return DropdownMenuItem<String>(
                      //       value: value,
                      //       child: Text(value),
                      //     );
                      //   }).toList(),
                      //   decoration: InputDecoration(
                      //     labelText: "Status",
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10),
                      //       borderSide: const BorderSide(
                      //         color: Colors.black,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 15,
                      // ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 0.3,
                        height: MediaQuery.of(context).size.height / 16, // Set the height
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              CircularIndicator.showLoader(context);
                            }
                          },
                          child: const Text(
                            'Submit',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
