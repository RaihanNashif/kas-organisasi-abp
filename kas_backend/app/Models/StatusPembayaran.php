<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class StatusPembayaran extends Model
{
    protected $table = 'status_pembayaran';
    protected $primaryKey = 'id_status';

    protected $fillable = [
        'id_users',
        'bulan',
        'tahun',
        'jumlah',
        'status',
        'tanggal_bayar'
    ];

    public $timestamps = false;
}
