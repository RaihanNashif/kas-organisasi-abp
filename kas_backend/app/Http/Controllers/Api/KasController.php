<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Pemasukan;
use App\Models\Pengeluaran;
use App\Models\Laporan;
use Illuminate\Http\Request;

class KasController extends Controller
{
    public function dashboard()
    {
        $totalPemasukan = Pemasukan::sum('jumlah');
        $totalPengeluaran = Pengeluaran::sum('jumlah');

        return response()->json([
            'total_pemasukan' => $totalPemasukan,
            'total_pengeluaran' => $totalPengeluaran,
            'saldo' => $totalPemasukan - $totalPengeluaran,
            'jumlah_laporan' => Laporan::count()
        ]);
    }

    // GET semua data
    public function index()
    {
        return response()->json([
            'pemasukan' => Pemasukan::all(),
            'pengeluaran' => Pengeluaran::all()
        ]);
    }

    // POST pemasukan
    public function storePemasukan(Request $request)
    {
        $request->validate([
            'tanggal' => 'required|date',
            'sumber' => 'required|string|max:100',
            'jumlah' => 'required|numeric|min:0',
            'keterangan' => 'nullable|string|max:255',
            'id_users' => 'nullable|exists:users,id_users',
            'input_by' => 'required|exists:users,id_users'
        ]);

        $data = Pemasukan::create($request->all());

        return response()->json([
            'status' => 'success',
            'data' => $data
        ]);
    }
    // PUT pengeluaran
    public function updatePengeluaran(Request $request, $id)
    {
        $request->validate([
            'tanggal' => 'required|date',
            'keperluan' => 'required|string|max:100',
            'jumlah' => 'required|numeric|min:0',
            'keterangan' => 'nullable|string|max:255',
            'id_users' => 'nullable|exists:users,id_users',
            'input_by' => 'required|exists:users,id_users'
        ]);

        $pengeluaran = Pengeluaran::find($id);

        if (!$pengeluaran) {
            return response()->json([
                'status' => 'error',
                'message' => 'Data pengeluaran tidak ditemukan'
            ], 404);
        }

        $pengeluaran->update($request->all());

        return response()->json([
            'status' => 'success',
            'message' => 'Data pengeluaran berhasil diubah',
            'data' => $pengeluaran
        ]);
    }

    // DELETE pengeluaran
    public function deletePengeluaran($id)
    {
        $pengeluaran = Pengeluaran::find($id);

        if (!$pengeluaran) {
            return response()->json([
                'status' => 'error',
                'message' => 'Data pengeluaran tidak ditemukan'
            ], 404);
        }

        $pengeluaran->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'Data pengeluaran berhasil dihapus'
        ]);
    }

    // POST pengeluaran
    public function storePengeluaran(Request $request)
    {
        $request->validate([
            'tanggal' => 'required|date',
            'keperluan' => 'required',
            'jumlah' => 'required|numeric',
            'input_by' => 'required'
        ]);

        $data = Pengeluaran::create($request->all());

        return response()->json([
            'status' => 'success',
            'data' => $data
        ]);
    }

    // GET saldo otomatis
    public function saldo()
    {
        $totalPemasukan = Pemasukan::sum('jumlah');
        $totalPengeluaran = Pengeluaran::sum('jumlah');

        return response()->json([
            'total_pemasukan' => $totalPemasukan,
            'total_pengeluaran' => $totalPengeluaran,
            'saldo' => $totalPemasukan - $totalPengeluaran
        ]);
    }

    public function generateLaporan(Request $request)
    {
        $request->validate([
            'bulan' => 'required|integer',
            'tahun' => 'required|integer',
            'id_users' => 'required'
        ]);

        $bulan = $request->bulan; // contoh: 4
        $tahun = $request->tahun; // contoh: 2026

        $totalPemasukan = Pemasukan::whereMonth('tanggal', $bulan)
            ->whereYear('tanggal', $tahun)
            ->sum('jumlah');

        $totalPengeluaran = Pengeluaran::whereMonth('tanggal', $bulan)
            ->whereYear('tanggal', $tahun)
            ->sum('jumlah');


        $laporan = Laporan::create([
            'total_pemasukan' => $totalPemasukan,
            'total_pengeluaran' => $totalPengeluaran,
            'saldo_akhir' => $totalPemasukan - $totalPengeluaran,
            'periode' => $tahun . '-' . str_pad($bulan, 2, '0', STR_PAD_LEFT),
            'id_users' => $request->id_users
        ]);
        return response()->json([
            'status' => 'success',
            'data' => $laporan
        ]);
    }

    public function getLaporan()
    {
        return response()->json(Laporan::all());
    }

    public function getPemasukan()
    {
        return response()->json(
            Pemasukan::with('user')->get()
        );
    }

    public function getPengeluaran()
    {
        return response()->json(
            Pengeluaran::with('user')->get()
        );
    }

    public function updatePemasukan(Request $request, $id)
    {
        $request->validate([
            'tanggal' => 'required|date',
            'sumber' => 'required|string|max:100',
            'jumlah' => 'required|numeric|min:0',
            'keterangan' => 'nullable|string|max:255',
            'id_users' => 'nullable|exists:users,id_users',
            'input_by' => 'required|exists:users,id_users'
        ]);

        $pemasukan = Pemasukan::find($id);

        if (!$pemasukan) {
            return response()->json([
                'status' => 'error',
                'message' => 'Data pemasukan tidak ditemukan'
            ], 404);
        }

        $pemasukan->update($request->all());

        return response()->json([
            'status' => 'success',
            'message' => 'Data pemasukan berhasil diubah',
            'data' => $pemasukan
        ]);
    }

    public function deletePemasukan($id)
    {
        $pemasukan = Pemasukan::find($id);

        if (!$pemasukan) {
            return response()->json([
                'status' => 'error',
                'message' => 'Data pemasukan tidak ditemukan'
            ], 404);
        }

        $pemasukan->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'Data pemasukan berhasil dihapus'
        ]);
    }
    public function aiAnalisis()
    {
        $totalPemasukan = Pemasukan::sum('jumlah');
        $totalPengeluaran = Pengeluaran::sum('jumlah');

        $saldo = $totalPemasukan - $totalPengeluaran;

        $score = 100;
        $status = "Sangat Sehat";

        $analisis = [];
        $rekomendasi = [];

        // Rasio Pengeluaran
        $rasio = 0;
        if ($totalPemasukan > 0) {
            $rasio = ($totalPengeluaran / $totalPemasukan) * 100;
        }

        // Rule 1
        if ($saldo < 0) {
            $status = "Defisit";
            $score -= 50;
            $analisis[] = "Saldo organisasi mengalami defisit.";
            $rekomendasi[] = "Kurangi pengeluaran dan tingkatkan pemasukan.";
        }

        // Rule 2
        if ($rasio > 80) {
            $status = "Waspada";
            $score -= 20;
            $analisis[] = "Pengeluaran mencapai " . round($rasio, 1) . "% dari pemasukan.";
            $rekomendasi[] = "Kurangi pengeluaran yang tidak mendesak.";
        } else {
            $analisis[] = "Rasio pengeluaran masih sehat (" . round($rasio, 1) . "%).";
        }

        // Rule 3
        if ($saldo < 100000) {
            $score -= 15;
            $analisis[] = "Dana kas mulai menipis.";
            $rekomendasi[] = "Tambahkan dana cadangan.";
        }

        // Rule 4
        if ($saldo > 500000) {
            $analisis[] = "Saldo kas cukup aman.";
        }

        // Rule 5
        if ($totalPemasukan > $totalPengeluaran) {
            $analisis[] = "Pemasukan lebih besar daripada pengeluaran.";
        }

        if ($score >= 90) {
            $status = "Sangat Sehat";
        } elseif ($score >= 75) {
            $status = "Sehat";
        } elseif ($score >= 50) {
            $status = "Waspada";
        } else {
            $status = "Defisit";
        }

        if (count($rekomendasi) == 0) {

            $rekomendasi[] =
                "Pertahankan kondisi keuangan organisasi.";

            $rekomendasi[] =
                "Lakukan pencatatan kas secara rutin.";

            $rekomendasi[] =
                "Pertahankan rasio pengeluaran di bawah 60%.";

        }

        return response()->json([
            "status" => $status,
            "score" => $score,
            "saldo" => $saldo,
            "rasio" => round($rasio, 1),
            "total_pemasukan" => $totalPemasukan,
            "total_pengeluaran" => $totalPengeluaran,
            "analisis" => $analisis,
            "rekomendasi" => $rekomendasi
        ]);
    }
}
