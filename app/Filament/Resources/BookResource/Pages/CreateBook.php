<?php

namespace App\Filament\Resources\BookResource\Pages;

use App\Filament\Resources\BookResource;
use Filament\Actions;
use Filament\Resources\Pages\CreateRecord;

class CreateBook extends CreateRecord
{
    protected static string $resource = BookResource::class;
    

      public function getTitle(): string
    {
        return "Crear Libro";
    }
    public function getRedirectUrl(): string
    {
        return route('filament.admin.resources.books.index');
    }
}
