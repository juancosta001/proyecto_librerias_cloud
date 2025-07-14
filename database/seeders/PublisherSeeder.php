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
        $publishers = [
            [
                'name' => 'Editorial Planeta',
                'address' => 'Calle Mayor 123, Madrid',
            ],
            [
                'name' => 'Santillana',
                'address' => 'Avenida de América 45, Barcelona ',
            ],
            [
                'name' => 'Alfaguara',
                'address' => 'Gran Vía 67, Madrid',
            ],
        ];

        foreach ($publishers as $publisher) {
            $exists = DB::table('publishers')->where('name', $publisher['name'])->exists();
            if (!$exists) {
                DB::table('publishers')->insert([
                    'name' => $publisher['name'],
                    'address' => $publisher['address'],
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }
        }
    }
}
