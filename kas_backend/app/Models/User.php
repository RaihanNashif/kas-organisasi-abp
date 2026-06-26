<?php

namespace App\Models;

use App\Models\Pemasukan;
use Illuminate\Database\Eloquent\Model;

class User extends Model
{
    protected $table = 'users';
    protected $primaryKey = 'id_users';

    protected $fillable = [
        'nama',
        'username',
        'password',
        'role',
        'alamat',
        'no_hp'
    ];

    public $timestamps = false;

    public function pemasukan()
    {
        return $this->hasMany(Pemasukan::class, 'id_users', 'id_users');
    }

    public function pengeluaran()
    {
        return $this->hasMany(Pengeluaran::class, 'id_users', 'id_users');
    }

    public function statusPembayaran()
    {
        return $this->hasMany(StatusPembayaran::class, 'id_users', 'id_users');
    }

    public function laporan()
    {
        return $this->hasMany(Laporan::class, 'id_users', 'id_users');
    }
}

