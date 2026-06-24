<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\KasController;
use App\Http\Controllers\Api\AuthController;

Route::post('/login', [AuthController::class, 'login']);
Route::get('/kas', [KasController::class, 'index']);
Route::get('/dashboard', [KasController::class, 'dashboard']);
Route::post('/pemasukan', [KasController::class, 'storePemasukan']);
Route::post('/pengeluaran', [KasController::class, 'storePengeluaran']);
Route::get('/saldo', [KasController::class, 'saldo']);
Route::post('/generate-laporan', [KasController::class, 'generateLaporan']);
Route::get('/laporan', [KasController::class, 'getLaporan']);
Route::get('/pemasukan', function () {
    return \App\Models\Pemasukan::all();
});

Route::get('/pengeluaran', function () {
    return \App\Models\Pengeluaran::all();
});


