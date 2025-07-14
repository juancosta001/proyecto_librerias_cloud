<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Loan extends Model
{
    use HasFactory;

    protected $fillable = [
        'book_id',
        'loan_date',
        'return_date',
        'status',
    ];

    /**
     * Relación: Un préstamo pertenece a un libro.
     */
    public function book()
    {
        return $this->belongsTo(Book::class);
    }

    /**
     * Escuchar los eventos de creación y actualización.
     */
    protected static function booted()
    {
        static::creating(function ($loan) {
            // Resta 1 al stock cuando un préstamo es creado
            $loan->book->decrement('stock');
        });

        static::updated(function ($loan) {
            // Si el estado del préstamo es 'devuelto', se suma 1 al stock
            if ($loan->isDirty('status') && $loan->status === 'returned') {
                $loan->book->increment('stock');
            }
        });
    }
}
