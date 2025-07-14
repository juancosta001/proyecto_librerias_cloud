<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // Crear la tabla 'publishers'
        Schema::create('publishers', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('address')->nullable();
            $table->timestamps();
        });

        // Agregar la columna 'publisher_id' a la tabla 'books'
        Schema::table('books', function (Blueprint $table) {
            $table->foreignId('publisher_id')->nullable()->constrained('publishers')->onDelete('set null');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('books', function (Blueprint $table) {
            // Eliminar la columna 'publisher_id' de la tabla 'books'
            $table->dropForeign(['publisher_id']);
            $table->dropColumn('publisher_id');
        });

        // Eliminar la tabla 'publishers'
        Schema::dropIfExists('publishers');
    }
};
