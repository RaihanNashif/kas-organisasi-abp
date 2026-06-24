<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Laporan extends Model
{
    protected $table = 'laporan';
    protected $primaryKey = 'id_laporan';

    protected $fillable = [
        'total_pemasukan',
        'total_pengeluaran',
        'saldo_akhir',
        'periode',
        'id_users'
    ];

    public $timestamps = false;
}

