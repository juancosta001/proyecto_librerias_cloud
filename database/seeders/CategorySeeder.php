<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class CategorySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('categories')->insert([
            [
            'name' => 'Ficción',
            'description' => 'Libros de narrativa imaginativa.',
            'created_at' => now(),
            'updated_at' => now(),
            ],
            [
            'name' => 'Ciencia',
            'description' => 'Libros sobre temas científicos.',
            'created_at' => now(),
            'updated_at' => now(),
            ],
            [
            'name' => 'Historia',
            'description' => 'Libros sobre hechos históricos.',
            'created_at' => now(),
            'updated_at' => now(),
            ],
        ]);
    }
}
