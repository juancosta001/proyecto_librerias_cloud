<?php

namespace App\Filament\Resources\LoanResource\Pages;

use App\Filament\Resources\LoanResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditLoan extends EditRecord
{
    protected static string $resource = LoanResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }

     public function getTitle(): string
    {
        return "Editar Prestamo";
    }
    public function getRedirectUrl(): string|null
    {
        return route('filament.admin.resources.loans.index');
    }
}
