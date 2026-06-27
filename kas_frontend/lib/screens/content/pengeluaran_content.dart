import 'package:flutter/material.dart';
import '../../services/pengeluaran_service.dart';
import '../../services/user_service.dart';
import 'package:intl/intl.dart';

class PengeluaranContent extends StatefulWidget {
  const PengeluaranContent({super.key});

  @override
  State<PengeluaranContent> createState() =>
      _PengeluaranContentState();
}

class _PengeluaranContentState
    extends State<PengeluaranContent> {

  final rupiah = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  List<dynamic> pengeluaran = [];

  List<dynamic> users = [];

  int? selectedUserId;

  bool isLoading = true;

  final tanggalController = TextEditingController();

  final keperluanController = TextEditingController();

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

    final pengeluaranData =
      await PengeluaranService.getPengeluaran();

    final userData =
      await UserService.getUsers();

    setState(() {

      pengeluaran = pengeluaranData;

      users = userData;

      isLoading = false;

    });

    } catch (e) {

      print(e);

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              const Text(
                "Data Pengeluaran",
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
                label: const Text("Tambah"),
              ),

            ],
          ),

          const SizedBox(height: 20),

          Expanded(
            child: SingleChildScrollView(
              child: DataTable(
                columns: const [

                  DataColumn(
                    label: Text("Nama"),
                  ),

                  DataColumn(
                    label: Text("Tanggal"),
                  ),

                  DataColumn(
                    label: Text("Keperluan"),
                  ),

                  DataColumn(
                    label: Text("Jumlah"),
                  ),

                  DataColumn(
                    label: Text("Aksi"),
                  ),

                ],

                rows: pengeluaran.map((item) {

                  return DataRow(
                    cells: [

                      DataCell(
                        Text(
                          item["user"]?["nama"] ?? "-",
                        ),
                      ),

                      DataCell(
                        Text(item["tanggal"]),
                      ),

                      DataCell(
                        Text(item["keperluan"]),
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
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: const Text("Detail Pengeluaran"),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                          "Keperluan : ${item["keperluan"]}",
                                        ),

                                        Text(
                                          rupiah.format(
                                            double.parse(item["jumlah"].toString())
                                          )
                                        ),

                                        Text(
                                          "Keterangan : ${item["keterangan"]}",
                                        ),
                                      ],
                                    ),

                                    actions: [

                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Tutup"),
                                      ),

                                    ],
                                  );
                                },
                              );
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
                                                await PengeluaranService
                                                    .hapusPengeluaran(
                                              item["id_pengeluaran"],
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
  void showTambahDialog() {

    showDialog(

      context: context,

      builder: (_) {

        return AlertDialog(

          title: const Text("Tambah Pengeluaran"),

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

                  TextField(
                    controller: keperluanController,
                    decoration: const InputDecoration(
                      labelText: "Keperluan",
                    ),
                  ),

                  TextField(
                    controller: jumlahController,
                    keyboardType: TextInputType.number,
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

                  DropdownButtonFormField<int>(

                     value: selectedUserId,

                    decoration: const InputDecoration(
                      labelText: "Nama Warga",
                    ),

                    items: users.map((user) {

                      return DropdownMenuItem<int>(

                        value: user["id_users"],

                        child: Text(user["nama"]),

                      );

                    }).toList(),

                    onChanged: (value) {

                      setState(() {

                        selectedUserId = value;

                      });

                    },

                  ),

                  TextField(
                    controller: inputByController,
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

              child: const Text("Batal"),

            ),

            ElevatedButton(

              onPressed: () async {

                bool berhasil =
                    await PengeluaranService.tambahPengeluaran(

                  tanggal: tanggalController.text,

                  keperluan: keperluanController.text,

                  jumlah: jumlahController.text,

                  keterangan: keteranganController.text,

                  idUsers:
                    selectedUserId.toString(),

                  inputBy: inputByController.text,

                );

                if (berhasil) {

                  Navigator.pop(context);

                  loadData();

                }

              },

              child: const Text("Simpan"),

            ),

          ],

        );

      },

    );

  }
  void showEditDialog(dynamic item) {

    tanggalController.text = item["tanggal"];
    keperluanController.text = item["keperluan"];
    jumlahController.text = item["jumlah"].toString();
    keteranganController.text = item["keterangan"] ?? "";
    idUsersController.text = item["id_users"].toString();
    inputByController.text = item["input_by"].toString();

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Edit Pengeluaran"),

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
                    controller: keperluanController,
                    decoration: const InputDecoration(
                      labelText: "Keperluan",
                    ),
                  ),

                  TextField(
                    controller: jumlahController,
                    keyboardType: TextInputType.number,
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
                    await PengeluaranService.editPengeluaran(

                  id: item["id_pengeluaran"],

                  tanggal: tanggalController.text,

                  keperluan: keperluanController.text,

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
}