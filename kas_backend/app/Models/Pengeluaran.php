<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\User;

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

    public function user()
    {
        return $this->belongsTo(User::class, 'id_users', 'id_users');
    }
}

