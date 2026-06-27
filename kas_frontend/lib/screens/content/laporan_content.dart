import 'package:flutter/material.dart';
import '../../services/laporan_service.dart';
import '../../services/pdf_service.dart';
import 'package:intl/intl.dart';

class LaporanContent extends StatefulWidget {
  const LaporanContent({super.key});

  @override
  State<LaporanContent> createState() =>
      _LaporanContentState();
}

class _LaporanContentState
    extends State<LaporanContent> {

  final rupiah = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );
  
  List<dynamic> laporan = [];

  bool isLoading = true;

  String bulan = "12";
  String tahun = "2025";

  final idUsersController =
      TextEditingController(text: "1");

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {

    final data =
        await LaporanService.getLaporan();

    setState(() {
      laporan = data;
      isLoading = false;
    });

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

          const Text(
            "Laporan Kas",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Row(

            children: [

              DropdownButton<String>(

                value: bulan,

                items: List.generate(

                  12,

                  (index) {

                    String value =
                        "${index + 1}";

                    return DropdownMenuItem(

                      value: value,

                      child: Text(
                        value,
                      ),

                    );

                  },

                ),

                onChanged: (value) {

                  setState(() {

                    bulan = value!;

                  });

                },

              ),

              const SizedBox(width: 20),

              DropdownButton<String>(

                value: tahun,

                items: [

                  "2024",

                  "2025",

                  "2026",

                ].map((e) {

                  return DropdownMenuItem(

                    value: e,

                    child: Text(e),

                  );

                }).toList(),

                onChanged: (value) {

                  setState(() {

                    tahun = value!;

                  });

                },

              ),

              const SizedBox(width: 20),

              ElevatedButton(

                onPressed: () async {

                  bool berhasil =
                      await LaporanService
                          .generateLaporan(

                    bulan: bulan,

                    tahun: tahun,

                    idUsers:
                        idUsersController.text,

                  );

                  if (berhasil) {

                    await loadData();

                    if (mounted) {

                      ScaffoldMessenger.of(
                              context)
                          .showSnackBar(

                        const SnackBar(

                          content: Text(
                              "Laporan berhasil dibuat"),

                        ),

                      );

                    }

                  }

                },

                child: const Text(
                  "Generate",
                ),

              ),

            ],

          ),

          const SizedBox(height: 20),

          Expanded(

            child: SingleChildScrollView(

              scrollDirection:
                  Axis.horizontal,

              child: DataTable(

                headingRowColor:
                    WidgetStateProperty.all(
                  Colors.green.shade100,
                ),

                columns: const [

                  DataColumn(
                    label: Text("Periode"),
                  ),

                  DataColumn(
                    label:
                        Text("Pemasukan"),
                  ),

                  DataColumn(
                    label:
                        Text("Pengeluaran"),
                  ),

                  DataColumn(
                    label:
                        Text("Saldo"),
                  ),

                  DataColumn(
                    label: Text("Aksi"),
                  ),

                ],

                rows:
                    laporan.map((item) {

                  return DataRow(

                    cells: [

                      DataCell(
                        Text(
                          item["periode"],
                        ),
                      ),

                      DataCell(
                        Text(
                          rupiah.format(
                            double.parse(item["total_pemasukan"].toString()),
                          ),
                        ),
                      ),

                      DataCell(
                        Text(
                          rupiah.format(
                            double.parse(item["total_pengeluaran"].toString()),
                          ),
                        ),
                      ),

                      DataCell(
                        Text(
                          rupiah.format(
                            double.parse(item["saldo_akhir"].toString()),
                          ),
                        ),
                      ),

                      DataCell(

                        Row(

                          children: [

                            IconButton(

                              tooltip: "Generate",

                              onPressed: () async {

                                bool berhasil =
                                    await LaporanService.generateLaporan(

                                  bulan: bulan,

                                  tahun: tahun,

                                  idUsers: idUsersController.text,

                                );

                                if (berhasil) {

                                  await loadData();

                                }

                              },

                              icon: const Icon(Icons.refresh),

                            ),

                            IconButton(

                              tooltip: "PDF",

                              onPressed: () async {

                                await PdfService.generateLaporan(

                                  periode: item["periode"],

                                  pemasukan: rupiah.format(
                                    double.parse(item["total_pemasukan"].toString()),
                                  ),

                                  pengeluaran: rupiah.format(
                                    double.parse(item["total_pengeluaran"].toString()),
                                  ),

                                  saldo: rupiah.format(
                                    double.parse(item["saldo_akhir"].toString()),
                                  ),

                                );

                              },

                              icon: const Icon(
                                Icons.picture_as_pdf,
                                color: Colors.red,
                              ),

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

}