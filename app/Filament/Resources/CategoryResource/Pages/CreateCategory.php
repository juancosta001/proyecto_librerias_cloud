<?php

namespace App\Filament\Resources\CategoryResource\Pages;

use App\Filament\Resources\CategoryResource;
use Filament\Actions;
use Filament\Resources\Pages\CreateRecord;

class CreateCategory extends CreateRecord
{
    protected static string $resource = CategoryResource::class;
    public function getTitle(): string {return"Crear Categoria";}

    public function getRedirectUrl(): string{return route ('filament.admin.resources.categories.index');}
}
