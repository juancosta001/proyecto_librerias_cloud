<?php

namespace App\Filament\Resources\LoanResource\Pages;

use App\Filament\Resources\LoanResource;
use Filament\Actions;
use Filament\Resources\Pages\CreateRecord;

class CreateLoan extends CreateRecord
{
    protected static string $resource = LoanResource::class;

    public function getTitle(): string
    {
        return "Crear Prestamo";
    }
    public function getRedirectUrl(): string
    {
        return route('filament.admin.resources.loans.index');
    }
}
