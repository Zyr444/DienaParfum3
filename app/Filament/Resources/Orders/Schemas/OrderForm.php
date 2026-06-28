<?php

namespace App\Filament\Resources\Orders\Schemas;

use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\Textarea;
use Filament\Forms\Components\Repeater;
use Filament\Schemas\Schema;

class OrderForm
{
    public static function configure(Schema $schema): Schema
    {
        return $schema
            ->components([
                \Filament\Schemas\Components\Section::make('Status & Pembayaran')
                    ->schema([
                        TextInput::make('order_number')
                            ->label('Nomor Pesanan')
                            ->disabled()
                            ->required(),
                        Select::make('user_id')
                            ->label('Akun Pelanggan')
                            ->relationship('user', 'name')
                            ->disabled()
                            ->placeholder('Guest / WhatsApp User'),
                        Select::make('payment_method')
                            ->label('Metode Pembayaran')
                            ->options([
                                'cod' => 'Cash On Delivery (COD)',
                                'bank_transfer' => 'Bank Transfer (WhatsApp Direct)',
                                'card' => 'Credit Card',
                                'paypal' => 'PayPal',
                            ])
                            ->default('bank_transfer')
                            ->required(),
                        Select::make('payment_status')
                            ->label('Status Pembayaran')
                            ->options([
                                'unpaid' => 'Belum Lunas',
                                'paid' => 'Lunas',
                                'failed' => 'Gagal',
                            ])
                            ->default('unpaid')
                            ->required(),
                        Select::make('status')
                            ->label('Status Pengiriman')
                            ->options([
                                'new' => 'Baru',
                                'process' => 'Diproses',
                                'shipped' => 'Dikirim (Resi Tersedia)',
                                'delivered' => 'Selesai',
                                'cancelled' => 'Dibatalkan',
                            ])
                            ->default('new')
                            ->required(),
                        TextInput::make('coupon')
                            ->label('Kupon Digunakan')
                            ->disabled(),
                        TextInput::make('sub_total')
                            ->label('Sub Total')
                            ->numeric()
                            ->prefix('Rp')
                            ->disabled(),
                        TextInput::make('total_amount')
                            ->label('Total Akhir')
                            ->numeric()
                            ->prefix('Rp')
                            ->disabled()
                            ->required(),
                    ])->columns(3),

                \Filament\Schemas\Components\Section::make('Informasi Pengiriman')
                    ->schema([
                        TextInput::make('first_name')
                            ->label('Nama Depan')
                            ->required(),
                        TextInput::make('last_name')
                            ->label('Nama Belakang')
                            ->required(),
                        TextInput::make('email')
                            ->label('Email')
                            ->email()
                            ->required(),
                        TextInput::make('phone')
                            ->label('No. WhatsApp')
                            ->tel()
                            ->required(),
                        Textarea::make('address1')
                            ->label('Alamat Utama')
                            ->required()
                            ->columnSpan(2),
                        Textarea::make('address2')
                            ->label('Alamat Tambahan / Catatan')
                            ->columnSpan(2),
                        TextInput::make('post_code')
                            ->label('Kode Pos'),
                        TextInput::make('country')
                            ->label('Negara')
                            ->default('Indonesia'),
                    ])->columns(2),

                \Filament\Schemas\Components\Section::make('Daftar Produk yang Dibeli')
                    ->schema([
                        Repeater::make('items')
                            ->relationship('items')
                            ->schema([
                                Select::make('product_id')
                                    ->label('Nama Parfum')
                                    ->relationship('product', 'name')
                                    ->disabled()
                                    ->columnSpan(2),
                                TextInput::make('price')
                                    ->label('Harga Satuan')
                                    ->numeric()
                                    ->prefix('Rp')
                                    ->disabled(),
                                TextInput::make('quantity')
                                    ->label('Jumlah')
                                    ->numeric()
                                    ->disabled(),
                                TextInput::make('amount')
                                    ->label('Total')
                                    ->numeric()
                                    ->prefix('Rp')
                                    ->disabled(),
                            ])
                            ->columns(5)
                            ->disableItemCreation()
                            ->disableItemDeletion()
                            ->disableItemMovement()
                            ->columnSpanFull()
                    ])
            ]);
    }
}
