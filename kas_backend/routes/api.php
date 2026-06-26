<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\KasController;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\UserController;

Route::post('/login', [AuthController::class, 'login']);
Route::get('/kas', [KasController::class, 'index']);
Route::get('/dashboard', [KasController::class, 'dashboard']);
Route::post('/pemasukan', [KasController::class, 'storePemasukan']);
Route::post('/pengeluaran', [KasController::class, 'storePengeluaran']);
Route::get('/saldo', [KasController::class, 'saldo']);
Route::post('/generate-laporan', [KasController::class, 'generateLaporan']);
Route::get('/laporan', [KasController::class, 'getLaporan']);
Route::get('/pemasukan', [KasController::class, 'getPemasukan']);
Route::get('/pengeluaran', [KasController::class, 'getPengeluaran']);

// Route Manajemen User
Route::get('/users', [UserController::class, 'index']);
Route::get('/users/{id}', [UserController::class, 'show']);
Route::post('/users', [UserController::class, 'store']);
Route::put('/users/{id}', [UserController::class, 'update']);
Route::delete('/users/{id}', [UserController::class, 'destroy']);


