import 'package:flutter/material.dart';
import '../../services/pemasukan_service.dart';
import '../../services/user_service.dart';
import 'package:intl/intl.dart';

class PemasukanContent extends StatefulWidget {
  const PemasukanContent({super.key});

  @override
  State<PemasukanContent> createState() =>
      _PemasukanContentState();
}

class _PemasukanContentState
    extends State<PemasukanContent> {
  
  final searchController = TextEditingController();

  List<dynamic> filteredPemasukan = [];

  final rupiah = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  List<dynamic> pemasukan = [];

  List<dynamic> users = [];

  int? selectedUserId;

  bool isLoading = true;

  final tanggalController = TextEditingController();
  final sumberController = TextEditingController();
  final jumlahController = TextEditingController();
  final keteranganController = TextEditingController();
  final idUsersController = TextEditingController();
  final inputByController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void filterData(String keyword) {

    setState(() {

      filteredPemasukan = pemasukan.where((item) {

        final nama =
            item["user"]?["nama"]
                ?.toString()
                .toLowerCase() ?? "";

        final sumber =
            item["sumber"]
                ?.toString()
                .toLowerCase() ?? "";

        return nama.contains(keyword.toLowerCase()) ||
              sumber.contains(keyword.toLowerCase());

      }).toList();

    });

  }

  Future<void> loadData() async {

    try {

      final data =
          await PemasukanService.getPemasukan();

      final userData =
          await UserService.getUsers();

      setState(() {

        pemasukan = data;

        filteredPemasukan = data;

        isLoading = false;

      });

    } catch (e) {

      debugPrint(e.toString());

      setState(() {

        isLoading = false;

      });

    }

  }

  @override
  Widget build(BuildContext context) {

    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(20),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Row(

            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

            children: [

              const Text(
                "Data Pemasukan",

                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              ElevatedButton.icon(

                onPressed: () {
                  showTambahDialog();
                },

                icon: const Icon(Icons.add),

                label: const Text(
                  "Tambah",
                ),

              )

            ],

          ),

          const SizedBox(height: 20),

          SizedBox(
            width: 350,
            child: TextField(

              controller: searchController,

              onChanged: filterData,

              decoration: const InputDecoration(

                hintText: "Cari Nama / Sumber...",

                prefixIcon: Icon(Icons.search),

                border: OutlineInputBorder(),

              ),

            ),
          ),


          Expanded(

            child: SingleChildScrollView(

              scrollDirection: Axis.horizontal,

              child: DataTable(

                headingRowColor:
                    WidgetStateProperty.all(
                  Colors.green.shade100,
                ),

                columns: const [

                  DataColumn(
                    label: Text("Nama"),
                  ),

                  DataColumn(
                    label: Text("Tanggal"),
                  ),

                  DataColumn(
                    label: Text("Sumber"),
                  ),

                  DataColumn(
                    label: Text("Jumlah"),
                  ),

                  DataColumn(
                    label: Text("Aksi"),
                  ),

                ],

                rows: filteredPemasukan.map((item) {

                  return DataRow(

                    cells: [

                      DataCell(
                        Text(
                          item["user"]?["nama"] ?? "-",
                        ),
                      ),

                      DataCell(
                        Text(
                          item["tanggal"],
                        ),
                      ),

                      DataCell(
                        Text(
                          item["sumber"],
                        ),
                      ),

                      DataCell(
                        Text(
                          rupiah.format(
                            double.parse(item["jumlah"].toString()),
                          ),
                        ),
                      ),

                      DataCell(
                        Row(
                          children: [

                            ElevatedButton(
                              onPressed: () {
                                showDetailDialog(item);
                              },
                              child: const Text("Detail"),
                            ),

                            const SizedBox(width: 8),

                            ElevatedButton(
                              onPressed: () {
                                showEditDialog(item);
                              },
                              child: const Text("Edit"),
                            ),

                            const SizedBox(width: 8),

                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () {
                                showDeleteDialog(item);
                              },
                              child: const Text("Hapus"),
                            ),

                          ],
                        ),
                      ),

                    ],

                  );

                }).toList(),

              ),

            ),

          ),

        ],

      ),

    );

  }

  void showDetailDialog(dynamic item) {

    showDialog(

      context: context,

      builder: (_) {

        return AlertDialog(

          title: const Text(
            "Detail Pemasukan",
          ),

          content: SingleChildScrollView(

            child: Column(

              mainAxisSize: MainAxisSize.min,

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  "Nama : ${item["user"]?["nama"] ?? "-"}",
                ),

                Text(
                  "Alamat : ${item["user"]?["alamat"] ?? "-"}",
                ),

                Text(
                  "No HP : ${item["user"]?["no_hp"] ?? "-"}",
                ),

                const SizedBox(height: 15),

                Text(
                  "Tanggal : ${item["tanggal"]}",
                ),

                Text(
                  "Sumber : ${item["sumber"]}",
                ),

                Text(
                  "Jumlah : ${rupiah.format(double.parse(item["jumlah"].toString()))}",
                ),

                Text(
                  "Keterangan : ${item["keterangan"]}",
                ),

              ],

            ),

          ),

          actions: [

            TextButton(

              onPressed: () {

                Navigator.pop(context);

              },

              child: const Text(
                "Tutup",
              ),

            ),

          ],

        );

      },

    );

  }
  void showTambahDialog() {

    tanggalController.clear();
    sumberController.clear();
    jumlahController.clear();
    keteranganController.clear();
    selectedUserId = null;
    inputByController.clear();

    showDialog(

      context: context,

      builder: (_) {

        return AlertDialog(

          title: const Text(
            "Tambah Pemasukan",
          ),

          content: SizedBox(

            width: 400,

            child: SingleChildScrollView(

              child: Column(

                mainAxisSize: MainAxisSize.min,

                children: [

                  TextField(
                    controller: tanggalController,
                    readOnly: true,

                    decoration: const InputDecoration(
                      labelText: "Tanggal",
                      suffixIcon: Icon(Icons.calendar_today),
                    ),

                    onTap: () async {

                      DateTime? picked =
                          await showDatePicker(

                        context: context,

                        initialDate: DateTime.now(),

                        firstDate: DateTime(2020),

                        lastDate: DateTime(2100),

                      );

                      if (picked != null) {

                        tanggalController.text =
                            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";

                      }

                    },

                  ),
                  const SizedBox(height: 10),

                  TextField(
                    controller: sumberController,
                    decoration: const InputDecoration(
                      labelText: "Sumber",
                    ),
                  ),

                  const SizedBox(height: 10),

                  TextField(
                    controller: jumlahController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Jumlah",
                    ),
                  ),

                  const SizedBox(height: 10),

                  TextField(
                    controller: keteranganController,
                    decoration: const InputDecoration(
                      labelText: "Keterangan",
                    ),
                  ),

                  const SizedBox(height: 10),

                  DropdownButtonFormField<int>(

                    value: selectedUserId,

                    decoration: const InputDecoration(
                      labelText: "Nama Warga",
                    ),

                    items: users.map((user) {

                      return DropdownMenuItem<int>(

                        value: user["id_users"],

                        child: Text(
                          user["nama"],
                        ),

                      );

                    }).toList(),

                    onChanged: (value) {

                      setState(() {

                        selectedUserId = value;

                      });

                    },

                  ),

                  const SizedBox(height: 10),

                  TextField(
                    controller: inputByController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Input By",
                    ),
                  ),

                ],

              ),

            ),

          ),

          actions: [

            TextButton(

              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text(
                "Batal",
              ),

            ),

            ElevatedButton(

              onPressed: () async {

                if (selectedUserId == null) {

                  ScaffoldMessenger.of(context).showSnackBar(

                    const SnackBar(
                      content: Text("Silakan pilih nama warga"),
                    ),

                  );

                  return;

                }

                bool berhasil =
                    await PemasukanService.tambahPemasukan(

                  tanggal: tanggalController.text,

                  sumber: sumberController.text,

                  jumlah: jumlahController.text,

                  keterangan: keteranganController.text,

                  idUsers: selectedUserId.toString(),

                  inputBy: inputByController.text,

                );

                if (berhasil) {

                  Navigator.pop(context);

                  await loadData();

                  if (mounted) {

                    ScaffoldMessenger.of(context).showSnackBar(

                      const SnackBar(

                        content: Text(
                          "Data berhasil ditambahkan",
                        ),

                      ),

                    );

                  }

                } else {

                  if (mounted) {

                    ScaffoldMessenger.of(context).showSnackBar(

                      const SnackBar(

                        content: Text(
                          "Gagal menambahkan data",
                        ),

                      ),

                    );

                  }

                }

              },

              child: const Text(
                "Simpan",
              ),

            ),

          ],

        );

      },

    );

  }
  void showEditDialog(dynamic item) {

    tanggalController.text = item["tanggal"];
    sumberController.text = item["sumber"];
    jumlahController.text = item["jumlah"].toString();
    keteranganController.text = item["keterangan"] ?? "";
    idUsersController.text = item["id_users"].toString();
    inputByController.text = item["input_by"].toString();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Edit Pemasukan"),

          content: SizedBox(
            width: 400,
            child: SingleChildScrollView(
              child: Column(
                children: [

                  TextField(
                    controller: tanggalController,
                    readOnly: true,

                    decoration: const InputDecoration(
                      labelText: "Tanggal",
                      suffixIcon: Icon(Icons.calendar_today),
                    ),

                    onTap: () async {

                      DateTime? picked = await showDatePicker(

                        context: context,

                        initialDate: DateTime.tryParse(
                                tanggalController.text) ??
                            DateTime.now(),

                        firstDate: DateTime(2020),

                        lastDate: DateTime(2100),

                      );

                      if (picked != null) {

                        tanggalController.text =
                            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";

                      }

                    },

                  ),

                  TextField(
                    controller: sumberController,
                    decoration: const InputDecoration(
                      labelText: "Sumber",
                    ),
                  ),

                  TextField(
                    controller: jumlahController,
                    decoration: const InputDecoration(
                      labelText: "Jumlah",
                    ),
                  ),

                  TextField(
                    controller: keteranganController,
                    decoration: const InputDecoration(
                      labelText: "Keterangan",
                    ),
                  ),

                ],
              ),
            ),
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Batal"),
            ),

            ElevatedButton(
              onPressed: () async {

                bool berhasil =
                    await PemasukanService.editPemasukan(

                  id: item["id_pemasukan"],

                  tanggal: tanggalController.text,

                  sumber: sumberController.text,

                  jumlah: jumlahController.text,

                  keterangan: keteranganController.text,

                  idUsers: idUsersController.text,

                  inputBy: inputByController.text,

                );

                if (berhasil) {

                  Navigator.pop(context);

                  loadData();

                }

              },
              child: const Text("Update"),
            ),

          ],

        );
      },
    );
  }
  void showDeleteDialog(dynamic item) {

    showDialog(

      context: context,

      builder: (_) {

        return AlertDialog(

          title: const Text("Konfirmasi"),

          content: const Text(
            "Yakin ingin menghapus data ini?",
          ),

          actions: [

            TextButton(

              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text("Batal"),

            ),

            ElevatedButton(

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),

              onPressed: () async {

                bool berhasil =
                    await PemasukanService.hapusPemasukan(
                  item["id_pemasukan"],
                );

                if (berhasil) {

                  Navigator.pop(context);

                  loadData();

                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Data berhasil dihapus",
                      ),
                    ),
                  );

                }

              },

              child: const Text("Hapus"),

            ),

          ],

        );

      },

    );

  }

  @override
  void dispose() {

    tanggalController.dispose();
    sumberController.dispose();
    jumlahController.dispose();
    keteranganController.dispose();
    idUsersController.dispose();
    inputByController.dispose();

    super.dispose();

  }

}