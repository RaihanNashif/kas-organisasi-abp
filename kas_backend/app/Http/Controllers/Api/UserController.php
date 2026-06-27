<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;

class UserController extends Controller
{
    /**
     * Display a listing of the users.
     */
    public function index()
    {
        $users = User::all();
        return response()->json([
            'status' => 'success',
            'data' => $users
        ]);
    }

    /**
     * Display the specified user.
     */
    public function show($id)
    {
        $user = User::find($id);

        if (!$user) {
            return response()->json([
                'status' => 'error',
                'message' => 'User tidak ditemukan'
            ], 404);
        }

        return response()->json([
            'status' => 'success',
            'data' => $user
        ]);
    }

    /**
     * Store a newly created user in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'nama' => 'required|string|max:100',
            'username' => 'required|string|max:50|unique:users,username',
            'password' => 'required|string|max:255',
            'role' => 'required|in:superadmin,admin,anggota',
            'alamat' => 'nullable|string|max:200',
            'no_hp' => 'nullable|string|max:20'
        ]);

        // Catatan: Sesuai dengan AuthController yang mencocokkan password secara plain text,
        // password di sini disimpan secara plain text tanpa hashing.
        $user = User::create([
            'nama' => $request->nama,
            'username' => $request->username,
            'password' => $request->password,
            'role' => $request->role,
            'alamat' => $request->alamat,
            'no_hp' => $request->no_hp
        ]);

        return response()->json([
            'status' => 'success',
            'message' => 'User berhasil ditambahkan',
            'data' => $user
        ], 201);
    }

    /**
     * Update the specified user in storage.
     */
    public function update(Request $request, $id)
    {
        $user = User::find($id);

        if (!$user) {
            return response()->json([
                'status' => 'error',
                'message' => 'User tidak ditemukan'
            ], 404);
        }

        $request->validate([
            'nama' => 'sometimes|required|string|max:100',
            'username' => 'sometimes|required|string|max:50|unique:users,username,' . $id . ',id_users',
            'password' => 'sometimes|required|string|max:255',
            'role' => 'sometimes|required|in:superadmin,admin,anggota',
            'alamat' => 'nullable|string|max:200',
            'no_hp' => 'nullable|string|max:20'
        ]);

        $user->update($request->all());

        return response()->json([
            'status' => 'success',
            'message' => 'User berhasil diperbarui',
            'data' => $user
        ]);
    }

    /**
     * Remove the specified user from storage.
     */
    public function destroy($id)
    {
        $user = User::find($id);

        if (!$user) {
            return response()->json([
                'status' => 'error',
                'message' => 'User tidak ditemukan'
            ], 404);
        }

        $user->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'User berhasil dihapus'
        ]);
    }
}
