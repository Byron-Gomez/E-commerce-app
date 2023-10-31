import 'package:e_commerce/config/services/auth_service.dart';
import 'package:e_commerce/config/utils.dart';
import 'package:e_commerce/navigations/Tabbar.dart';
import 'package:e_commerce/screens/signUp/Screen_Sign_Up.dart';
import 'package:flutter/material.dart';

class ScreenLogin extends StatefulWidget {

  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  Utils utils = Utils();
  AuthService service = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool passToggle = true;
  FocusNode fieldUsername = FocusNode();
  FocusNode fieldPassword = FocusNode();
  FocusNode buttonFocus = FocusNode();
  final TextEditingController _emailfieldController = TextEditingController();
  final TextEditingController _passwordfieldController =
      TextEditingController();

  void _submit() async{
    if (_formKey.currentState!.validate()) {
       final reponse = await service.loginHandlerEmail( context,
          _emailfieldController.text, _passwordfieldController.text);                    
      if (reponse) {        
        _passwordfieldController.clear();
        _emailfieldController.clear();
        _formKey.currentState!.deactivate();

          showDialog(
      context: context,
      builder: (_) => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
          ),
        ),
      ),
    );
    // Esperar a que la pantalla de carga se cierre
    await Future.delayed(const Duration(seconds: 2));

    // Cerrar la pantalla de carga
    Navigator.pop(context);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const Tabbar()));
      }
    }
  }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.person,
                size: 50,
                color: Color.fromARGB(255, 225, 190, 231),
              ),
              onPressed: () {},
            ),
            title: const Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Log in",
                style: TextStyle(color: Color.fromARGB(255, 225, 190, 231)),
              ),
            ),
            backgroundColor: const Color.fromARGB(216, 107, 45, 117),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back,
                  color: Color.fromARGB(216, 107, 45, 117), size: 40),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
          body: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 250.0, bottom: 0.0, right: 50.0, left: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      textForm(
                          "Ingrese Email",
                          const Color.fromARGB(255, 148, 131, 131),
                          16.0,
                          "Ingrese su Email",
                          Colors.grey,
                          context,
                          icon: const Icon(Icons.person,
                              color: Color.fromARGB(216, 107, 45, 117)),
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8.0),
                          filled: true,
                          colorsFill: const Color.fromARGB(255, 248, 237, 250),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "No puede dejar este campo vacio";
                            }
                            return utils.validateEmail(value);
                          },
                          focusNode: fieldUsername,
                          onfieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(fieldPassword);
                          },
                          textEditingController: _emailfieldController),
                      const SizedBox(
                        height: 16.0,
                      ),
                      textForm(
                          "Ingrese Contraseña",
                          const Color.fromARGB(255, 148, 131, 131),
                          16.0,
                          "Ingrese su Password",
                          Colors.grey,
                          context,
                          icon: const Icon(Icons.lock,
                              color: Color.fromARGB(216, 107, 45, 117)),
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8.0),
                          filled: true,
                          colorsFill: const Color.fromARGB(255, 248, 237, 250),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "No puede dejar este campo vacio";
                            }
                            return utils.validatePassword(value);
                          },
                          suffixInkwell: InkWell(
                            onTap: () {
                              setState(() {
                                passToggle = !passToggle;
                              });
                            },
                            child: Icon(passToggle
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          isPassword: passToggle,
                          focusNode: fieldPassword,
                          onfieldSubmitted: (value) {
                            _submit();
                          },
                          textEditingController: _passwordfieldController),
                      const SizedBox(height: 40.0),
                      ElevatedButton.icon(
                          icon: const Icon(Icons.login),
                          focusNode: buttonFocus,
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(280.0, 50.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0))),
                          onPressed: () {
                            _submit();
                          },
                          label: const Text("Log In")),
                      const SizedBox(
                        height: 16.0,
                      ),
                      ElevatedButton.icon(
                          icon: Image.asset('assets/images/google-icon.png',
                              width: 20),
                          focusNode: buttonFocus,
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(280.0, 50.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0))),
                          onPressed: () async {
                            await service.signInHandler();
                            if (mounted) {
                                showDialog(
                            context: context,
                            builder: (_) => const Scaffold(
                              body: Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
                                  ),),
                                  ),
                                  );
                                  // Esperar a que la pantalla de carga se cierre
                                  await Future.delayed(const Duration(seconds: 2));
                                     // Cerrar la pantalla de carga
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                    context, MaterialPageRoute(builder: (_) => const Tabbar()));  
                            }
                          },
                          label: const Text("Sign In With Google")),
                      const SizedBox(
                        height: 16.0,
                      ),
                      const Text(" You do not have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ScreenSignUp()));
                        },
                        child: const Text("Sign Up"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ));
    }
  }

  TextFormField textForm(
    String labelText,
    Color colorsLabel,
    double fontSize,
    String hint,
    Color colorsHint,
    BuildContext context, {
    Icon? icon,
    FontStyle fontStyle = FontStyle.normal,
    BorderSide borderSide = const BorderSide(color: Colors.black),
    BorderRadius borderRadius = BorderRadius.zero,
    bool filled = false,
    Color colorsFill = Colors.white,
    bool isPassword = false,
    TextInputType textInputType = TextInputType.text,
    String? Function(String?)? validator,
    void Function(String)? onfieldSubmitted,
    TextInputAction? textAction,
    InkWell? suffixInkwell,
    FocusNode? focusNode,
    TextEditingController? textEditingController,
  }) {
    return TextFormField(
      obscureText: isPassword,
      validator: validator,
      keyboardType: textInputType,
      focusNode: focusNode,
      controller: textEditingController,
      textInputAction: textAction,
      onFieldSubmitted: onfieldSubmitted,
      decoration: InputDecoration(
        suffix: suffixInkwell,
        prefixIcon: icon,
        labelText: labelText,
        labelStyle: TextStyle(
          color: colorsLabel,
          fontSize: fontSize,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: borderSide,
          borderRadius: borderRadius,
        ),
        filled: filled,
        fillColor: colorsFill,
      ),
    );
  }

