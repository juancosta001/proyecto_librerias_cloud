<?php

namespace App\Filament\Resources\AuthorResource\Pages;

use App\Filament\Resources\AuthorResource;
use Filament\Actions;
use Filament\Resources\Pages\CreateRecord;

class CreateAuthor extends CreateRecord
{
    protected static string $resource = AuthorResource::class;
    public function getTitle(): string
    {
        return "Crear Autor";
    }
    public function getRedirectUrl(): string
    {
        return route('filament.admin.resources.authors.index');
    }
}
