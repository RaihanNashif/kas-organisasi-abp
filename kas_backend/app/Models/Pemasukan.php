<?php

namespace App\Models;

use App\Models\User;
use Illuminate\Database\Eloquent\Model;

class Pemasukan extends Model
{
    protected $table = 'pemasukan';

    protected $primaryKey = 'id_pemasukan';

    public $incrementing = true;

    protected $keyType = 'int';

    protected $fillable = [
        'tanggal',
        'sumber',
        'jumlah',
        'keterangan',
        'id_users',
        'input_by'
    ];

    // kalau tidak ada created_at & updated_at di tabel
    public $timestamps = false;

    public function user()
    {
        return $this->belongsTo(User::class, 'id_users', 'id_users');
    }
}
