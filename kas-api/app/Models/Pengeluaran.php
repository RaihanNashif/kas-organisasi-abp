<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Pengeluaran extends Model
{
    protected $table = 'pengeluaran';

    protected $primaryKey = 'id_pengeluaran';

    public $incrementing = true;
    protected $keyType = 'int';

    protected $fillable = [
        'tanggal',
        'keperluan',
        'jumlah',
        'keterangan',
        'id_users',
        'input_by'
    ];

    public $timestamps = false;
}
