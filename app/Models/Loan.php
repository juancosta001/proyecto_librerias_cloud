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
}
