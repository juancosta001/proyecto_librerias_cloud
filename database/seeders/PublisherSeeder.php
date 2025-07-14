<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class PublisherSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('publishers')->insert([
            [
            'name' => 'Editorial Planeta',
            'address' => 'Calle Mayor 123, Madrid',
            'created_at' => now(),
            'updated_at' => now(),
            ],
            [
            'name' => 'Santillana',
            'address' => 'Avenida de América 45, Barcelona ',
            'created_at' => now(),
            'updated_at' => now(),
            ],
            [
            'name' => 'Alfaguara',
            'address' => 'Gran Vía 67, Madrid',
            'created_at' => now(),
            'updated_at' => now(),
            ],
        ]);
    }
}
