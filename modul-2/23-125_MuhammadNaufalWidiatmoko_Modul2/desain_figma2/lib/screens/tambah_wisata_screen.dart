import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TambahWisataScreen extends StatefulWidget {
  const TambahWisataScreen({super.key});

  @override
  State<TambahWisataScreen> createState() => _TambahWisataScreenState();
}

class _TambahWisataScreenState extends State<TambahWisataScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();

  String? _jenisWisata;
  File? _selectedImage;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      print("==== DATA WISATA ====");
      print("Nama: ${_namaController.text}");
      print("Lokasi: ${_lokasiController.text}");
      print("Jenis: $_jenisWisata");
      print("Harga: ${_hargaController.text}");
      print("Deskripsi: ${_deskripsiController.text}");
      print("=====================");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data wisata berhasil disimpan')),
      );
    }
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    _namaController.clear();
    _lokasiController.clear();
    _hargaController.clear();
    _deskripsiController.clear();
    setState(() {
      _jenisWisata = null;
      _selectedImage = null;
    });
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Tambah Wisata",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _selectedImage != null
                    ? Image.file(_selectedImage!, fit: BoxFit.cover)
                    : const Icon(Icons.add_photo_alternate, size: 50, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _pickImage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2C2C7E),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Upload Image"),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                color: Colors.grey[300],
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Nama Wisata :", style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _namaController,
                      decoration: _inputDecoration("Masukkan Nama Wisata Disini"),
                      validator: (value) => value!.isEmpty ? "Tidak boleh kosong!" : null,
                    ),
                    const SizedBox(height: 16),

                    const Text("Lokasi Wisata :", style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _lokasiController,
                      decoration: _inputDecoration("Masukkan Lokasi Wisata Disini"),
                      validator: (value) => value!.isEmpty ? "Tidak boleh kosong!" : null,
                    ),
                    const SizedBox(height: 16),

                    const Text("Jenis Wisata :", style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<String>(
                      value: _jenisWisata,
                      items: const [
                        DropdownMenuItem(value: "Wisata Alam", child: Text("Wisata Alam")),
                        DropdownMenuItem(value: "Wisata Kota", child: Text("Wisata Kota")),
                        DropdownMenuItem(value: "Wisata Budaya", child: Text("Wisata Budaya")),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _jenisWisata = value;
                        });
                      },
                      decoration: _inputDecoration("Pilih Jenis Wisata"),
                      validator: (value) => value == null ? "Pilih salah satu!" : null,
                    ),
                    const SizedBox(height: 16),

                    const Text("Harga Tiket :", style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    TextFormField(
                        controller: _hargaController,
                        keyboardType: TextInputType.number,
                        decoration: _inputDecoration("Masukkan Harga Tiket Disini"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Tidak boleh kosong!";
                          }
                          if (!RegExp(r'^\d+$').hasMatch(value)) {
                            return "Hanya boleh memasukkan angka!";
                          }
                          return null;
                        },
                      ),

                    const SizedBox(height: 16),

                    const Text("Deskripsi :", style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _deskripsiController,
                      maxLines: 3,
                      decoration: _inputDecoration("Masukkan Deskripsi Disini"),
                      validator: (value) => value!.isEmpty ? "Tidak boleh kosong!" : null,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2C2C7E),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Simpan"),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: TextButton(
                  onPressed: _resetForm,
                  child: const Text(
                    "Reset",
                    style: TextStyle(color: Color(0xFF2C2C7E)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
