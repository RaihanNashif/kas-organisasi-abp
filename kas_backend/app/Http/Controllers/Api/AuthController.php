<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        $request->validate([
            'username' => 'required',
            'password' => 'required'
        ]);

        $user = User::where('username', $request->username)
            ->where('password', $request->password)
            ->first();

        if (!$user) {
            return response()->json([
                'status' => 'error',
                'message' => 'Username atau password salah'
            ], 401);
        }

        return response()->json([
            'status' => 'success',
            'message' => 'Login berhasil',
            'user' => [
                'id_users' => $user->id_users,
                'nama' => $user->nama,
                'username' => $user->username,
                'role' => $user->role
            ]
        ]);
    }
    public function getUsers()
    {
        return response()->json(
            User::select('id_users', 'nama')
                ->where('role', 'anggota')
                ->orderBy('nama')
                ->get()
        );
    }
}