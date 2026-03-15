import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';
import 'kasir_page.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLogin = true;
  bool _isLoading = false;
  bool _obscurePassword = true;

  String? _errorNama;
  String? _errorEmail;
  String? _errorPhone;
  String? _errorPassword;
  String? _errorPesanTunggal;

  bool _validasiInput() {
    setState(() {
      _errorNama = null;
      _errorEmail = null;
      _errorPhone = null;
      _errorPassword = null;
      _errorPesanTunggal = null;
    });

    if (_isLogin) {
      if (_emailController.text.trim().isEmpty || _passwordController.text.trim().isEmpty) {
        setState(() => _errorPesanTunggal = "Email dan Password wajib diisi");
        return false;
      }
      if (!GetUtils.isEmail(_emailController.text.trim())) {
        setState(() => _errorPesanTunggal = "Email atau Password tidak sesuai");
        return false;
      }
      return true;
    } else {
      bool isValid = true;
      if (_namaController.text.trim().length < 3) {
        setState(() => _errorNama = "Nama minimal 3 karakter");
        isValid = false;
      }
      if (!GetUtils.isEmail(_emailController.text.trim())) {
        setState(() => _errorEmail = "Format email tidak valid");
        isValid = false;
      }
      if (!GetUtils.isPhoneNumber(_phoneController.text.trim()) || _phoneController.text.length < 10) {
        setState(() => _errorPhone = "Nomor telepon tidak valid");
        isValid = false;
      }
      if (_passwordController.text.trim().length < 6) {
        setState(() => _errorPassword = "Password minimal 6 karakter");
        isValid = false;
      }
      return isValid;
    }
  }

  Future<void> _handleAuth() async {
    if (!_validasiInput()) return;

    setState(() => _isLoading = true);
    try {
      if (_isLogin) {
        await Supabase.instance.client.auth.signInWithPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      } else {
        await Supabase.instance.client.auth.signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          data: {
            'display_name': _namaController.text.trim(),
            'phone': _phoneController.text.trim(),
          },
        );
      }
      Get.offAll(() => KasirPage());
    } catch (e) {
      setState(() {
        _errorPesanTunggal = _isLogin 
            ? "Email atau Password tidak sesuai" 
            : "Pendaftaran gagal, silakan coba lagi";
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              isDark ? Icons.dark_mode : Icons.light_mode, 
              color: Colors.red
            ),
            onPressed: () {
              Get.changeThemeMode(isDark ? ThemeMode.light : ThemeMode.dark);
            },
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "SEBLUCKIN", 
                style: GoogleFonts.poppins(
                  fontSize: 36, 
                  fontWeight: FontWeight.bold, 
                  color: Colors.red
                )
              ),
              Text(
                "Sistem Kasir Seblak", 
                style: GoogleFonts.poppins(

                  color: Theme.of(context).textTheme.bodyLarge?.color, 
                  fontWeight: FontWeight.w600
                )
              ),
              const SizedBox(height: 30),

              if (!_isLogin) ...[
                TextField(
                  controller: _namaController,
                  decoration: InputDecoration(
                    labelText: "Nama Lengkap",
                    border: OutlineInputBorder(),
                    errorText: _errorNama,
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                SizedBox(height: 15),
              ],

              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                onChanged: (val) => setState(() => _errorPesanTunggal = null),
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                  errorText: _isLogin ? null : _errorEmail,
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 15),

              if (!_isLogin) ...[
                TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Nomor Telepon",
                    border: OutlineInputBorder(),
                    errorText: _errorPhone,
                    prefixIcon: Icon(Icons.phone),
                  ),
                ),
                SizedBox(height: 15),
              ],

              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                onChanged: (val) => setState(() => _errorPesanTunggal = null),
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  errorText: _isLogin ? null : _errorPassword,
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
              ),
              
              if (_errorPesanTunggal != null) ...[
                SizedBox(height: 20),
                Text(
                  _errorPesanTunggal!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(color: Colors.red, fontSize: 13, fontWeight: FontWeight.bold),
                ),
              ],

              SizedBox(height: 25),

              _isLoading 
                ? CircularProgressIndicator(color: Colors.red) 
                : ElevatedButton(
                    onPressed: _handleAuth,
                    child: Text(_isLogin ? "Login" : "Register"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, 
                      foregroundColor: Colors.white, 
                      minimumSize: Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
              
              TextButton(
                onPressed: () {
                  setState(() {
                    _isLogin = !_isLogin;
                    _errorNama = _errorEmail = _errorPhone = _errorPassword = _errorPesanTunggal = null;
                    _namaController.clear();
                    _emailController.clear();
                    _phoneController.clear();
                    _passwordController.clear();
                  });
                },
                child: Text(
                  _isLogin ? "Belum punya akun? Daftar di sini" : "Sudah punya akun? Login",
                  style: GoogleFonts.poppins(color: Colors.blueAccent),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}