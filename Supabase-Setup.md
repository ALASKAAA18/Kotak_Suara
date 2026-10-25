# Menyiapkan penyimpanan surat dengan Supabase

Surat disimpan di database Supabase, jadi pengirim dan admin dapat mengaksesnya dari perangkat berbeda. Surat tidak dihapus otomatis; hanya admin yang dapat menghapusnya dari inbox, dan aplikasi meminta konfirmasi sebelum penghapusan permanen. Halaman ini tetap perlu di-host pada layanan web statis dan dibuka melalui alamat HTTPS; jangan hanya membuka berkas HTML langsung dari komputer.

## 1. Buat project dan tabel

1. Buat project di [Supabase](https://supabase.com/) dan tunggu sampai project siap.
2. Buka **SQL Editor**, pilih **New query**, lalu salin seluruh isi `supabase-schema.sql` dan jalankan.
3. Di **Project Settings → API**, salin **Project URL** dan **anon/public key** (atau publishable key). Jangan pernah menaruh `service_role` key di halaman web.
4. Isi kedua nilai tersebut di `supabase-config.js`, mengganti `https://YOUR_PROJECT_ID.supabase.co` dengan Project URL dan `YOUR_SUPABASE_PUBLISHABLE_KEY` dengan anon/public atau publishable key.

Kunci anon/publishable memang dipakai di browser. Keamanan isi surat tetap bergantung pada Row Level Security yang dibuat oleh SQL di atas: siapa pun dapat mengirim surat, tetapi hanya admin yang dapat membaca dan menghapusnya.

## 2. Buat akun admin

1. Di Supabase, buka **Authentication → Users → Add user**, lalu buat akun untuk `asadekaalaska@gmail.com` dan `fajarhidayat130310@gmail.com`, masing-masing dengan password Supabase sendiri.
2. Kebijakan di `supabase-schema.sql` memberi akses baca dan hapus hanya kepada dua alamat email tersebut. Setelah perubahan kebijakan dijalankan, logout lalu login kembali agar sesi diperbarui.
3. Username `EvBang` masuk ke akun email pertama (`asadekaalaska@gmail.com`). Email mana pun dari dua alamat tersebut juga bisa dipakai langsung sebagai ID login. Jangan simpan password di konfigurasi.

## 3. Host dan uji

Host file HTML, gambar, dan `supabase-config.js` pada layanan hosting statis yang sama (misalnya GitHub Pages atau Netlify), kemudian buka `Surat.html` dari alamat situs tersebut. Kirim surat, lalu login dari perangkat atau browser lain untuk melihatnya di `Admin.html`. Inbox memperbarui daftar otomatis tiap 30 detik; tombol **Muat ulang surat** juga tersedia.

Jika surat gagal dikirim atau inbox gagal dimuat, periksa URL/key, hasil SQL Editor, status jaringan, dan policy di **Database → Tables → letters**.
