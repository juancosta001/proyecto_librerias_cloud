<?php

namespace App\Filament\Resources;

use App\Filament\Resources\LoanResource\Pages;
use App\Models\Loan;
use App\Models\Book;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;

class LoanResource extends Resource
{
    protected static ?string $model = Loan::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';
    protected static ?string $navigationLabel = 'Préstamos';
    protected static ?string $pluralLabel = 'Préstamos';
    protected static ?string $modelLabel = 'Préstamo';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Select::make('book_id')
                    ->label('Libro')
                    ->relationship('book', 'title') // Asegúrate de que el modelo Book tenga una columna 'title'
                    ->required(),

                Forms\Components\DatePicker::make('loan_date')
                    ->label('Fecha de préstamo')
                    ->required(),

                Forms\Components\DatePicker::make('return_date')
                    ->label('Fecha de devolución')
                    ->nullable(),

                Forms\Components\Select::make('status')
                    ->label('Estado')
                    ->options([
                        'active' => 'Activo',
                        'returned' => 'Devuelto',
                        'overdue' => 'Vencido',
                    ])
                    ->default('active')
                    ->required(),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('book.title')
                    ->label('Libro')
                    ->sortable()
                    ->searchable(),

                Tables\Columns\TextColumn::make('loan_date')
                    ->label('Fecha de préstamo')
                    ->date()
                    ->sortable(),

                Tables\Columns\TextColumn::make('return_date')
                    ->label('Fecha de devolución')
                    ->date()
                    ->sortable(),

              Tables\Columns\TextColumn::make('status')
    ->label('Estado')
    ->formatStateUsing(function (string $state) {
        return match ($state) {
            'active' => '🟡 Activo',
            'returned' => '🟢 Devuelto',
            'overdue' => '🔴 Vencido',
            default => ucfirst($state),
        };
    })
    ->sortable()
    ->searchable()
    ->html(), // si querés usar íconos HTML

            ])
            ->filters([
                Tables\Filters\SelectFilter::make('status')
                    ->label('Estado')
                    ->options([
                        'active' => 'Activo',
                        'returned' => 'Devuelto',
                        'overdue' => 'Vencido',
                    ]),
            ])
            ->actions([
                Tables\Actions\EditAction::make()->label('Editar'),
   
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make()->label('Eliminar seleccionados'),
                ]),
            ]);
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListLoans::route('/'),
            'create' => Pages\CreateLoan::route('/crear'),
            'edit' => Pages\EditLoan::route('/{record}/editar'),
        ];
    }
}
