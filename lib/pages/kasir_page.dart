import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/topping.dart';
import 'manajemen_page.dart';
import 'auth_page.dart';

class KasirPage extends StatefulWidget {
  @override
  State<KasirPage> createState() => _KasirPageState();
}

class _KasirPageState extends State<KasirPage> {
  List<ItemKeranjang> keranjang = [];
  final supabase = Supabase.instance.client;

  void tambahKeKeranjang(Topping topping) {
    int indexInCart = keranjang.indexWhere((item) => item.topping.id == topping.id);
    int qtyDiKeranjang = (indexInCart != -1) ? keranjang[indexInCart].qty : 0;

    if (qtyDiKeranjang >= topping.stok) return;

    setState(() {
      if (indexInCart != -1) {
        keranjang[indexInCart].qty++;
      } else {
        keranjang.add(ItemKeranjang(topping: topping, qty: 1));
      }
    });
  }

  void kurangiItem(int index) {
    setState(() {
      keranjang[index].qty--;
      if (keranjang[index].qty <= 0) {
        keranjang.removeAt(index);
      }
    });
  }

  Future<void> prosesPembayaran() async {
    if (keranjang.isEmpty) return;

    try {
      for (var item in keranjang) {
        int stokBaru = item.topping.stok - item.qty;
        await supabase
            .from('topping')
            .update({'stok': stokBaru})
            .match({'id': item.topping.id!});
      }

      setState(() => keranjang.clear());
      
    } catch (e) {
      print("Gagal memproses pembayaran: $e");
    }
  }

  int getTotal() {
    int total = 0;
    for (var item in keranjang) {
      total += item.topping.harga * item.qty;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "SEBLUCKIN",
          style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isDark ? Icons.dark_mode : Icons.light_mode,
              color: Colors.white,
            ),
            onPressed: () {
              Get.changeThemeMode(isDark ? ThemeMode.light : ThemeMode.dark);
            },
          ),
          IconButton(
            icon: const Icon(Icons.inventory, color: Colors.white),
            onPressed: () => Get.to(() => ManajemenPage()),
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Logout",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                  content: const Text("Apakah Anda yakin ingin keluar?", textAlign: TextAlign.center),
                  actionsAlignment: MainAxisAlignment.spaceEvenly,
                  actions: [
                    TextButton(onPressed: () => Get.back(), child: const Text("Batal", style: TextStyle(color: Colors.grey))),
                    TextButton(
                      onPressed: () async {
                        await supabase.auth.signOut();
                        Get.offAll(() => AuthPage());
                      },
                      child: const Text("Keluar", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),

      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: supabase
                  .from('topping')
                  .stream(primaryKey: ['id'])
                  .order('nama', ascending: true),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

                final daftarTopping = snapshot.data!.map((e) => Topping.fromJson(e)).toList();

                return GridView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: daftarTopping.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                  ),
                  itemBuilder: (context, index) {
                    final topping = daftarTopping[index];

                    int idx = keranjang.indexWhere((item) => item.topping.id == topping.id);
                    int sisaStok = topping.stok - (idx != -1 ? keranjang[idx].qty : 0);

                    return Card(
                      child: InkWell(
                        onTap: sisaStok <= 0 ? null : () => tambahKeKeranjang(topping),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              topping.nama,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                            ),
                            Text("Rp. ${topping.harga}"),
                            Text(
                              sisaStok <= 0 ? "HABIS" : "Stok: $sisaStok",
                              style: TextStyle(
                                color: sisaStok <= 0 
                                    ? Colors.red 
                                    : (isDark ? Colors.white70 : Colors.black54),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          const Divider(height: 1),
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: keranjang.length,
              itemBuilder: (context, index) {
                final item = keranjang[index];
                return ListTile(
                  title: Text(
                    "${item.topping.nama} x${item.qty}",
                    style: TextStyle(color: isDark ? Colors.white : Colors.black),
                  ),
                  subtitle: Text("Total: Rp ${item.topping.harga * item.qty}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () => kurangiItem(index),
                  ),
                );
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: isDark ? Colors.black54 : Colors.black12, 
                  blurRadius: 4, 
                  offset: const Offset(0, -2)
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total: Rp. ${getTotal()}",
                  style: TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  ),
                  onPressed: keranjang.isEmpty ? null : prosesPembayaran,
                  child: const Text(
                    "Bayar", 
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ItemKeranjang {
  final Topping topping;
  int qty;
  ItemKeranjang({required this.topping, required this.qty});
}