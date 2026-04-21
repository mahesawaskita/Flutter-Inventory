/// Path aset — harus mengarah ke file nyata di folder [assets/image/].
abstract final class AppAssets {
  static const _root = 'assets/image';

  // Auth & splash
  static const splash = '$_root/splash_logo.png';
  static const login = '$_root/login_logo.png';
  static const registrasi = '$_root/reg_logo.png';
  static const lupaPassword = '$_root/lupa_password_logo.png';
  static const buatPasswordBaru = '$_root/buat_password_logo.png';

  // Dashboard (path datar — stabil di Web)
  static const dashShoppingCart = '$_root/dash_shopping_cart.png';
  static const dashStatusBarang = '$_root/dash_status_barang.png';
  static const dashWishlist = '$_root/dash_wishlist.png';

  // Penambahan Barang — aset di [assets/image/PenambahanBarang/]
  static const _pen = '$_root/PenambahanBarang';
  static const penJudul = '$_pen/Judul.png';
  static const penBarangBaruHariIni = '$_pen/Barangbaruhariini.png';
  static const penMonitor = '$_pen/monitor.png';
  static const penMouse = '$_pen/Mouse.png';
  static const penPerbaikan = '$_pen/perbaikan.png';
  static const penPrinter = '$_pen/printer.png';
  static const penRestok = '$_pen/Restok.png';
  static const penServer = '$_pen/server.png';
  static const penTambahFoto = '$_pen/tambahfotobarang.png';
  static const penTotalTersedia = '$_pen/TotalBarangTersedia.png';

  // Status barang (path datar — stabil di Web)
  static const stJudul = '$_root/st_judul.png';
  static const stMonitor = '$_root/st_monitor.png';
  static const stMouse = '$_root/st_mouse.png';
  static const stPrinter = '$_root/st_printer.png';
  static const stLaptop = '$_root/st_laptop.png';
  static const stTelat = '$_root/st_telat_dikembalikan.png';
  static const stTotalRusak = '$_root/st_total_barang_rusak.png';
  static const stTotalKembali =
      '$_root/st_total_barang_dikembalikan.png';
  static const stBarangPinjam = '$_root/st_barang_dipinjam.png';

  // Daftar barang (path datar — stabil di Web)
  static const dfJudul = '$_root/df_judul.png';
  static const dfBarangHabis = '$_root/df_barang_habis.png';
  static const dfHampirHabis = '$_root/df_barang_hampir_habis.png';
  static const dfLaptop = '$_root/df_laptop.png';
  static const dfMonitor = '$_root/df_monitor.png';
  static const dfMouse = '$_root/df_mouse.png';
  static const dfPrinter = '$_root/df_printer.png';
  static const dfServer = '$_root/df_server.png';
  static const dfTotal = '$_root/df_total_barang.png';

  // Profil (path datar — stabil di Web)
  static const pfDataPassword = '$_root/pf_datapassword.png';
  static const pfDataPribadi = '$_root/pf_datapribadi.png';
  static const pfLogout = '$_root/pf_logout.png';
  static const pfRiwayat = '$_root/pf_riwayat.png';

  // Detail penambahan barang (form; path datar — stabil di Web)
  static const dpbDeskripsi = '$_root/dpb_deskripsi.png';
  static const dpbElektronik = '$_root/dpb_elektronik.png';
  static const dpbFotoBarang = '$_root/dpb_foto_barang.png';
  static const dpbJudul = '$_root/dpb_judul.png';
  static const dpbKategori = '$_root/dpb_kategori.png';
  static const dpbStok = '$_root/dpb_masukan_stok.png';
  static const dpbNama = '$_root/dpb_nama_barang.png';
  static const dpbTambahFoto = '$_root/dpb_tambah_foto.png';
  static const dpbTambahKategori = '$_root/dpb_tambah_kategori.png';
  static const dpbTersedia = '$_root/dpb_tersedia.png';

  // Detail barang (path datar — stabil di Web)
  static const dbDeskripsi = '$_root/db_deskripsi.png';
  static const dbDetailPeminjaman =
      '$_root/db_detalpeminjaman.png';
  static const dbFotoKembali = '$_root/db_fotokembalian.png';
  static const dbJudul = '$_root/db_judul.png';
  static const dbLaptopRusak = '$_root/db_laptoprusak.png';
  static const dbMonitorRusak = '$_root/db_laptoprusak2.png';
  static const dbPeminjaman = '$_root/db_peminjam.png';
  static const dbRangeTanggal =
      '$_root/db_rangetanggal_peminjaman.png';
  static const dbStatus = '$_root/db_status.png';
  static const dbnTanggalPinjam =
      '$_root/db_tanggaldipinjam.png';
  static const dbnTanggalKembali =
      '$_root/db_tanggalkembali.png';
  static const dbnTongSampah = '$_root/db_tongsampah.png';
  static const dbnTongSampah2 = '$_root/db_tongsampah2.png';
  static const dbnUser = '$_root/avatar_user.png';

  // Edit barang — aset di [assets/image/editbarang/] (lihat juga file di root eb_*)
  static const _eb = '$_root/editbarang';
  static const ebDeskripsi = '$_eb/deskripsi.png';
  /// Nama file di folder: eletronik.png (tanpa "k" kedua).
  static const ebElektronik = '$_eb/eletronik.png';
  static const ebJudul = '$_eb/judul.png';
  static const ebKategori = '$_eb/kategori.png';
  static const ebLaptop = '$_eb/laptop.png';
  static const ebNama = '$_eb/namabarang.png';
  static const ebStok = '$_eb/stok.png';
  /// Tidak ada harga.png di subfolder — tetap pakai root.
  static const ebHarga = '$_root/eb_harga.png';
  static const ebTambahFoto = '$_eb/tambahfoto.png';
  static const ebTambahKategori = '$_eb/tambahkategori.png';
  static const ebTersedia = '$_eb/tersedia.png';
  static const ebTongSampah = '$_eb/tongsampah.png';
}
