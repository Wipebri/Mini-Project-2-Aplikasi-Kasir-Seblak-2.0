import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/topping.dart';

class ManajemenPage extends StatefulWidget {
  @override
  State<ManajemenPage> createState() => _ManajemenPageState();
}

class _ManajemenPageState extends State<ManajemenPage> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();
  final TextEditingController stokController = TextEditingController();

  final supabase = Supabase.instance.client;
  int? idEdit;

  String? errorNama;
  String? errorHarga;
  String? errorStok;

  String toTitleCase(String text) {
    if (text.isEmpty) return text;
    return text.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  Future<void> simpanData() async {
    setState(() {
      errorNama = null;
      errorHarga = null;
      errorStok = null;
    });

    String nama = toTitleCase(namaController.text.trim());
    int? harga = int.tryParse(hargaController.text);
    int? stok = int.tryParse(stokController.text);

    bool isInvalid = false;

    if (nama.isEmpty) {
      setState(() => errorNama = "Nama topping tidak boleh kosong");
      isInvalid = true;
    }
    
    if (harga == null || harga < 500) {
      setState(() => errorHarga = "Harga minimal Rp. 500");
      isInvalid = true;
    }
    
    if (stok == null || stok < 0) {
      setState(() => errorStok = "Stok tidak boleh negatif");
      isInvalid = true;
    }

    if (isInvalid) return;

    try {
      if (idEdit == null) {
        final existing = await supabase
            .from('topping')
            .select()
            .eq('nama', nama)
            .maybeSingle();

        if (existing != null) {
          setState(() => errorNama = "Topping '$nama' sudah terdaftar");
          return;
        }

        await supabase.from('topping').insert({
          'nama': nama,
          'harga': harga,
          'stok': stok,
        });
      } else {
        await supabase.from('topping').update({
          'nama': nama,
          'harga': harga,
          'stok': stok,
        }).match({'id': idEdit!});
        setState(() => idEdit = null); 
      }

      namaController.clear();
      hargaController.clear();
      stokController.clear();
      
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Terjadi kesalahan koneksi")),
      );
    }
  }

  void editData(Topping topping) {
    namaController.text = topping.nama;
    hargaController.text = topping.harga.toString();
    stokController.text = topping.stok.toString();

    setState(() {
      idEdit = topping.id;
      errorNama = null;
      errorHarga = null;
      errorStok = null;
    });
  }

  Future<void> hapusData(Topping topping) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Hapus Topping", textAlign: TextAlign.center, style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
        content: Text("Yakin ingin menghapus '${topping.nama}'?", textAlign: TextAlign.center),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal", style: TextStyle(color: Colors.grey))),
          TextButton(
            onPressed: () async {
              await supabase.from('topping').delete().match({'id': topping.id!});
              Navigator.pop(context);
            },
            child: const Text("Hapus", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void batalEdit() {
    setState(() {
      idEdit = null;
      errorNama = null;
      errorHarga = null;
      errorStok = null;
    });
    namaController.clear();
    hargaController.clear();
    stokController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Manajemen Topping", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (idEdit != null)
              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text("Mengedit Topping", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              ),

            TextField(
              controller: namaController,
              decoration: InputDecoration(
                labelText: "Nama Topping",
                errorText: errorNama,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: hargaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Harga",
                errorText: errorHarga,
                border: const OutlineInputBorder(),
                prefixText: "Rp. ",
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: stokController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Stok",
                errorText: errorStok,
                border: const OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: simpanData,
                    child: Text(idEdit == null ? "Tambah Topping" : "Simpan Perubahan"),
                  ),
                ),
                if (idEdit != null) ...[
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: batalEdit,
                      child: const Text("Batal"),
                    ),
                  ),
                ],
              ],
            ),

            const Divider(height: 40),

            Expanded(
              child: StreamBuilder<List<Map<String, dynamic>>>(
                stream: supabase.from('topping').stream(primaryKey: ['id']),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                  final daftarTopping = snapshot.data!.map((e) => Topping.fromJson(e)).toList();

                  return ListView.builder(
                    itemCount: daftarTopping.length,
                    itemBuilder: (context, index) {
                      final topping = daftarTopping[index];
                      return Card(
                        child: ListTile(
                          title: Text(topping.nama, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text("Rp. ${topping.harga} | Stok: ${topping.stok}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(icon: const Icon(Icons.edit, color: Colors.red), onPressed: () => editData(topping)),
                              IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () => hapusData(topping)),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}