<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

use App\Http\Controllers\Api\KasController;

Route::get('/kas', [KasController::class, 'index']);
Route::post('/pemasukan', [KasController::class, 'storePemasukan']);
Route::post('/pengeluaran', [KasController::class, 'storePengeluaran']);

// endpoint saldo
Route::get('/saldo', [KasController::class, 'saldo']);
