import 'package:flutter/material.dart';
import '../../services/pemasukan_service.dart';

class PemasukanContent extends StatefulWidget {
  const PemasukanContent({super.key});

  @override
  State<PemasukanContent> createState() =>
      _PemasukanContentState();
}

class _PemasukanContentState
    extends State<PemasukanContent> {

  List<dynamic> pemasukan = [];

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

  Future<void> loadData() async {

    try {

      final data =
          await PemasukanService.getPemasukan();

      setState(() {
        pemasukan = data;
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

                rows: pemasukan.map((item) {

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
                          "Rp ${item["jumlah"]}",
                        ),
                      ),

                      DataCell(

                        ElevatedButton(

                          onPressed: () {

                            showDetailDialog(item);

                          },

                          child: const Text(
                            "Detail",
                          ),

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
                  "Jumlah : Rp ${item["jumlah"]}",
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
    idUsersController.clear();
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
                    decoration: const InputDecoration(
                      labelText: "Tanggal",
                      hintText: "YYYY-MM-DD",
                    ),
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

                  TextField(
                    controller: idUsersController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "ID Users",
                    ),
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

                bool berhasil =
                    await PemasukanService.tambahPemasukan(

                  tanggal: tanggalController.text,

                  sumber: sumberController.text,

                  jumlah: jumlahController.text,

                  keterangan: keteranganController.text,

                  idUsers: idUsersController.text,

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