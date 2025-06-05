<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class AuthorSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('authors')->insert([
            [
            'name' => 'Gabriel García Márquez',
            'bio' => 'Escritor colombiano, ganador del Premio Nobel de Literatura en 1982.',
            'created_at' => now(),
            'updated_at' => now(),
            ],
            [
            'name' => 'Isabel Allende',
            'bio' => 'Escritora chilena, reconocida por sus novelas históricas y realistas.',
            'created_at' => now(),
            'updated_at' => now(),
            ],
            [
            'name' => 'Jorge Luis Borges',
            'bio' => 'Escritor, poeta y ensayista argentino, figura clave de la literatura universal.',
            'created_at' => now(),
            'updated_at' => now(),
            ],
        ]);
    }
}
