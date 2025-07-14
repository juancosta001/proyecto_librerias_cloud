<?php

namespace App\Filament\Resources\PublisherResource\Pages;

use App\Filament\Resources\PublisherResource;
use Filament\Actions;
use Filament\Resources\Pages\CreateRecord;

class CreatePublisher extends CreateRecord
{
    protected static string $resource = PublisherResource::class;
      public function getTitle(): string
    {
        return "Crear Editorial";
    }
    public function getRedirectUrl(): string
    {
        return route('filament.admin.resources.publishers.index');
    }
}
