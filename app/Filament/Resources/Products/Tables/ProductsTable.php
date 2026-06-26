<?php

namespace App\Filament\Resources\Products\Tables;

use Filament\Actions\BulkActionGroup;
use Filament\Actions\DeleteBulkAction;
use Filament\Actions\EditAction;
use Filament\Actions\DeleteAction;
use Filament\Tables\Columns\ImageColumn;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Table;

class ProductsTable
{
    public static function configure(Table $table): Table
    {
        return $table
            ->columns([
                ImageColumn::make('image')
                    ->label('Foto')
                    ->circular()
                    ->state(fn ($record) => $record->image ? (str_starts_with($record->image, 'http') || str_starts_with($record->image, '/') ? asset(ltrim($record->image, '/')) : asset('storage/' . $record->image)) : null),
                
                TextColumn::make('name')
                    ->label('Nama Aroma')
                    ->searchable()
                    ->sortable(),

                TextColumn::make('price')
                    ->label('Harga')
                    ->formatStateUsing(fn (int $state): string => 'Rp ' . number_format($state, 0, ',', '.'))
                    ->sortable(),

                TextColumn::make('stock')
                    ->label('Stok')
                    ->badge()
                    ->color(fn (int $state): string => match (true) {
                        $state <= 5 => 'danger',
                        $state <= 20 => 'warning',
                        default => 'success',
                    })
                    ->sortable(),

                TextColumn::make('category.title')
                    ->label('Kategori')
                    ->badge()
                    ->searchable(),

                TextColumn::make('created_at')
                    ->label('Terdaftar Pada')
                    ->formatStateUsing(fn ($state): string => $state ? $state->format('d/m/Y H:i') : '-')
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->filters([
                \Filament\Tables\Filters\SelectFilter::make('category')
                    ->label('Kategori')
                    ->relationship('category', 'title'),
            ])
            ->recordActions([
                EditAction::make(),
            ])
            ->actions([
                DeleteAction::make(),
            ]);
    }
}
