<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class BookSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Elimina todos los registros existentes para volver a ejecutar el seeder
        DB::table('books')->delete();

        DB::table('books')->insert([
            [
                'title' => 'El Quijote',
                'isbn_code' => '978-84-376-0494-7',
                'publication_date' => '1605-01-16',
                'author_id' => 1,
                'category_id' => 1,
                'publisher_id' => 1,
                'stock' => 6,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'title' => 'Cien Años de Soledad',
                'isbn_code' => '978-84-376-0495-4',
                'publication_date' => '1967-05-30',
                'author_id' => 2,
                'category_id' => 1,
                'publisher_id' => 2,
                'stock' => 4,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'title' => 'Rayuela',
                'isbn_code' => '978-84-376-0496-1',
                'publication_date' => '1963-06-28',
                'author_id' => 3,
                'category_id' => 1,
                'publisher_id' => 3,
                'stock' => 2,
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }
}
