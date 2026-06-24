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
        $data = Pemasukan::create($request->all());
        return response()->json($data);

        $request->validate([
            'tanggal' => 'required|date',
            'jumlah' => 'required|numeric'
        ]);
    }

    // POST pengeluaran
    public function storePengeluaran(Request $request)
    {
        $data = Pengeluaran::create($request->all());
        return response()->json($data);

        $request->validate([
            'tanggal' => 'required|date',
            'jumlah' => 'required|numeric'
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
}
