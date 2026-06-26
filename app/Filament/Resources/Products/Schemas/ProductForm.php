<?php

namespace App\Filament\Resources\Products\Schemas;

use Filament\Forms\Components\FileUpload;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Textarea;
use Filament\Schemas\Schema;

class ProductForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                \Filament\Schemas\Components\Section::make('Informasi Dasar')
                    ->description('Detail utama produk parfum Anda.')
                    ->schema([
                        TextInput::make('name')
                            ->label('Nama Aroma')
                            ->required()
                            ->maxLength(255)
                            ->placeholder('Contoh: Diena Parfume | Blue de Chanel'),
                        
                        \Filament\Forms\Components\RichEditor::make('description')
                            ->label('Deskripsi')
                            ->required()
                            ->columnSpanFull(),
                    ])->columns(1),

                \Filament\Schemas\Components\Section::make('Harga & Stok')
                    ->schema([
                        TextInput::make('price')
                            ->label('Harga')
                            ->required()
                            ->prefix('Rp')
                            ->minValue(0),
                        
                        TextInput::make('stock')
                            ->label('Jumlah Stok')
                            ->required()
                            ->default(0)
                            ->minValue(0),

                        \Filament\Forms\Components\Select::make('category_id')
                            ->label('Kategori')
                            ->relationship('category', 'title')
                            ->required(),
                    ])->columns(3),

                \Filament\Schemas\Components\Section::make('Visual')
                    ->schema([
                        FileUpload::make('image')
                            ->label('Foto Botol')
                            ->image()
                            ->directory('products')
                            ->imageEditor()
                            ->required(),
                    ]),
            ]);
    }
}
