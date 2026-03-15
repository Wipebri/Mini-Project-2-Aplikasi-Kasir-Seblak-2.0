# Mini-Project-2-Aplikasi-Kasir-Seblak-2.0
| DWI PEBRIYANTO PRADANA | 2409116012 | SISTEM INFORMASI A 2024 |

## SEBLUCKIN - Sistem Kasir Seblak
SEBLUCKIN adalah aplikasi manajemen kasir berbasis mobile yang dirancang khusus untuk bisnis kuliner Seblak. Aplikasi ini membantu pemilik usaha dalam mengelola inventaris topping secara real-time dan memproses transaksi penjualan dengan antarmuka yang modern dan responsif.

## 📝 Deskripsi Aplikasi
Aplikasi ini dibangun menggunakan framework Flutter dengan integrasi Supabase sebagai backend untuk autentikasi dan database real-time. SEBLUCKIN memungkinkan pengguna untuk memantau stok topping, melakukan transaksi (hitung otomatis), serta mengelola data menu (CRUD) dalam satu genggaman. Dengan dukungan Dark Mode dan Light Mode, aplikasi ini memberikan kenyamanan visual bagi penggunanya di berbagai kondisi pencahayaan.

---

## Fitur Aplikasi

### 1. Kasir
<img width="380" height="570" alt="image" src="https://github.com/user-attachments/assets/ee379a8f-2754-4ee2-b77d-b063a135784a" />

Aplikasi ini memiliki fitur utama berupa tampilan daftar topping interaktif yang memudahkan kasir dalam memilih menu dengan cepat. Setiap topping menampilkan informasi nama, harga, dan stok yang tersedia, sehingga pengguna dapat langsung mengetahui ketersediaan bahan secara real-time. Pengguna dapat menambahkan, menghapus, atau memperbarui topping dengan masuk ke menu manajemen topping, yaitu dengan menekan tombol gergi di pojk kanan atas.

<img width="380" height="570" alt="image" src="https://github.com/user-attachments/assets/6ec7dbc2-f1cb-470e-944e-13a7707a69b8" />

Aplikasi ini juga memiliki sistem keranjang belanja yang secara otomatis menampung topping yang dipilih. Ketika sebuah topping ditekan, item tersebut akan masuk ke dalam keranjang dan stok akan berkurang secara otomatis. Pengguna juga dapat mengurangi jumlah topping atau menghapusnya dari keranjang dengan menekan tombol "-" pada toping yang ingin dikurangi dari keranjang, dan sistem akan menyesuaikan kembali jumlah stok yang tersedia. Total harga transaksi dihitung secara otomatis berdasarkan jumlah dan harga masing-masing topping, sehingga meminimalkan kesalahan perhitungan manual.

<img width="380" height="570" alt="image" src="https://github.com/user-attachments/assets/fa07cd97-a7c7-4368-bc7a-d25a02a43f98" />

Ketika menekan tombol bayar maka topping dikeranjang akan hilang yang mengartikan transaksi sudah dilakukan dan stok sesuai saat dilakukan pembayaran.

---

### 2. Manajemen Toppoing
<img width="380" height="570" alt="image" src="https://github.com/user-attachments/assets/9e0d2b7a-5d23-4659-846c-8c0d556eb243" />

Aplikasi ini juga menyediakan fitur manajemen topping yang memungkinkan pengguna untuk menambahkan, mengubah, dan menghapus data topping. Fitur ini memberikan fleksibilitas kepada pemilik usaha dalam mengatur harga, memperbarui stok, maupun menyesuaikan menu sesuai kebutuhan.

#### Menambahkan Topping
<img width="380" height="570" alt="image" src="https://github.com/user-attachments/assets/f9535cec-5c9a-4901-b608-af7d1aa637fe" />

Menambahkan topping dapat dilakukan dengan mengisi kolom nama topping, harga, dan stok. setelah itu pengguna tinggal menekan tambah topping maka toping akan ditambahkan ke dalam aplikasi.

#### Menghapus Topping
<img width="380" height="570" alt="image" src="https://github.com/user-attachments/assets/4abd0afe-6af3-45c0-b4ee-5d4e2d786f63" />

Menghapus topping dapat dilakukan dengan menekan icon keranjang sampah pada topping yang ingin di hapus, setelah ditekan topping otomatis aka hilang.

#### Memperbarui Topping
<img width="380" height="570" alt="image" src="https://github.com/user-attachments/assets/971db30f-f2d4-4ee5-bbde-5f1d8a2c9328" />

Memperbarui toping dapat dilakukan dengan menekan icon pensil pada toping yang ingin di ubah, akan muncul tulisan perbarui data dan kolom nama topping, harga, dan stok akan terisi otomatos dengan topping yang ingin di ubah. pengguna bisa langsung memngubah sesuai dengan yang ia inginkan. jika ingin menyimpan perubahan maka tinggal menekan perbarui topping, jika tidak maka tekan batal.

---

## Penggunaan Widget
### 1. Scaffold
<img width="300" height="293" alt="image" src="https://github.com/user-attachments/assets/06fca2b6-b8bb-4897-a915-f34ba7fe7fcb" />

Sebagai kerangka Utama yang menyediakan dasar seperti AppBar dan body, sehingga halaman memiliki layout standar aplikasi Flutter.

---

### 2. AppBar
<img width="300" height="260" alt="image" src="https://github.com/user-attachments/assets/e5bbcdff-938e-4cd8-b180-08fe5d068e01" />
<img width="300" height="308" alt="image" src="https://github.com/user-attachments/assets/afa42c1b-9648-43b6-a5df-af9fe377dac6" />

Bagian paling atas aplikasi yang berisi SEBLUCKIN, Manajemen Topping, icon setting dan kembali.

---

### 3. Column
<img width="300" height="208" alt="image" src="https://github.com/user-attachments/assets/ba3b8af6-61eb-4f3d-87d7-19b049601f95" />

<img width="300" height="586" alt="image" src="https://github.com/user-attachments/assets/2f3b65af-6270-4f7e-90e9-35ff67fb467e" />

Menyusun widget secara vertikal dari atas ke bawah, seperti grid topping, keranjang, dan bagian total pembayaran.

---

### 4. Row
<img width="300" height="288" alt="image" src="https://github.com/user-attachments/assets/df858959-c370-4cbe-ae0e-66b76d8e759b" />
<img width="300" height="110" alt="image" src="https://github.com/user-attachments/assets/979d08c0-0697-472f-a68d-18f833603ede" />

Menyusun widget secara horizontal, misalnya untuk menampilkan tombol Tambah/Update dan Batal secara berdampingan.

---

### 5. Expanded
<img width="300" height="173" alt="image" src="https://github.com/user-attachments/assets/7a7162bc-279b-4bf0-ad93-9c9af33d9443" />

Mengatur pembagian ruang dalam Column atau Row agar proporsional. Pada halaman kasir, Expanded digunakan untuk membagi area grid topping dan keranjang.

---

### 6. Container
<img width="300" height="147" alt="image" src="https://github.com/user-attachments/assets/1d0d0e42-7a89-4866-9241-84d3f53b6da7" />

Digunakan untuk membungkus widget lain sekaligus mengatur warna latar, padding, atau ukuran, seperti pada bagian total pembayaran.

---

### 7. GridView.builder
<img width="300" height="287" alt="image" src="https://github.com/user-attachments/assets/d9447c46-9f85-4924-a9bf-ab70e8998efc" />

<img width="300" height="641" alt="image" src="https://github.com/user-attachments/assets/415d6b8e-9df9-4cac-976a-59ad159c8c39" />

Menampilkan daftar topping dalam bentuk grid secara dinamis sesuai jumlah data. Cocok untuk tampilan menu berbentuk katalog.

---

### 8. ListView.builder
<img width="300" height="208" alt="image" src="https://github.com/user-attachments/assets/72aeab99-714e-40a4-aa61-779f5d392d0d" />

<img width="300" height="326" alt="Cuplikan layar 2026-02-26 194521" src="https://github.com/user-attachments/assets/ebec4655-a3d1-4817-93dc-927a82c15ac9" />

Menampilkan daftar item dalam keranjang secara dinamis berdasarkan jumlah item yang dipilih.

---

### 9. Card
<img width="300" height="228" alt="image" src="https://github.com/user-attachments/assets/129ad96a-44c6-4860-83eb-106368511161" />

<img width="300" height="641" alt="image" src="https://github.com/user-attachments/assets/415d6b8e-9df9-4cac-976a-59ad159c8c39" />
Memberikan tampilan kotak dengan bayangan untuk setiap item topping atau data topping agar terlihat rapi dan terpisah.

---

### 10. TextField
<img width="300" height="168" alt="image" src="https://github.com/user-attachments/assets/4413693d-9b54-48ea-b001-36f0a9b14d31" />

<img width="300" height="332" alt="image" src="https://github.com/user-attachments/assets/93489b27-7614-4217-ae7f-0f1db13d446d" />

Digunakan untuk input data seperti nama topping, harga, dan stok pada halaman manajemen.

---

### 11. ElevatedButton
<img width="300" height="226" alt="image" src="https://github.com/user-attachments/assets/41da9622-a526-497b-bae2-916e61e4f3cb" />

<img width="300" height="147" alt="image" src="https://github.com/user-attachments/assets/5a4fb2b9-3982-479a-8b37-6c85870250a0" />

Digunakan untuk tombol utama seperti Tambah Topping, Update Topping, dan Bayar. Biasanya memiliki warna latar solid.

---

### 12. OutlinedButton
<img width="300" height="215" alt="image" src="https://github.com/user-attachments/assets/6d22496a-1cd2-494a-83e2-a89f75fb6732" />

<img width="300" height="121" alt="image" src="https://github.com/user-attachments/assets/9a87eea7-370e-48bb-a88b-6f93240bab54" />

Digunakan untuk tombol sekunder seperti Batal, dengan tampilan outline

---

### 13. IconButton
<img width="300" height="212" alt="image" src="https://github.com/user-attachments/assets/f1a2ac75-1586-4cec-bbb5-6b8bb14aaf23" />

<img width="300" height="198" alt="image" src="https://github.com/user-attachments/assets/4b07fec9-f64d-43ad-b781-7decf218a3a6" />

Digunakan untuk tombol berbentuk ikon, seperti tombol edit, hapus, dan settings.

---

### 14. InkWell
<img width="300" height="228" alt="image" src="https://github.com/user-attachments/assets/52058d63-1141-4ed6-8f29-f99900289b7b" />

<img width="300" height="641" alt="image" src="https://github.com/user-attachments/assets/415d6b8e-9df9-4cac-976a-59ad159c8c39" />

Memberikan efek sentuhan (ripple effect) pada Card saat ditekan, sehingga topping bisa dipilih.

---

### 15. Text
<img width="300" height="292" alt="image" src="https://github.com/user-attachments/assets/d52e44f8-7c0e-44c8-81f9-c6a7e189b8df" />

<img width="300" height="221" alt="image" src="https://github.com/user-attachments/assets/19078eb2-a804-4fc8-a3f8-9d7fb723748e" />

Menampilkan teks seperti nama topping, harga, stok, dan total pembayaran.

---

### 16. GoogleFonts

<img width="300" height="178" alt="image" src="https://github.com/user-attachments/assets/da656730-c8a7-4c92-9f64-21b300dbee43" />

Digunakan untuk mengatur jenis font agar tampilan lebih modern dan konsisten.

--- 

## 🚀 Teknologi yang Digunakan
- **Framework:** Flutter
- **State Management:** GetX
- **Backend:** Supabase (Auth & Database)
- **Font:** Google Fonts
- **Environment:** Flutter Dotenv

---

**Note:** Pastikan untuk mengonfigurasi file .env yang berisi SUPABASE_URL dan SUPABASE_ANON_KEY sebelum menjalankan aplikasi ini.
