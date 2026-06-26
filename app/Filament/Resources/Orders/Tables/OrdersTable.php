<?php

namespace App\Filament\Resources\Orders\Tables;

use Filament\Actions\BulkActionGroup;
use Filament\Actions\DeleteBulkAction;
use Filament\Actions\EditAction;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Table;
use Filament\Actions\Action;

class OrdersTable
{
    public static function configure(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('order_number')
                    ->label('No. Pesanan')
                    ->searchable()
                    ->sortable()
                    ->copyable(),

                TextColumn::make('user.name')
                    ->label('Nama Akun')
                    ->searchable()
                    ->sortable()
                    ->placeholder('Guest / WhatsApp'),

                TextColumn::make('first_name')
                    ->label('Nama Penerima')
                    ->state(fn ($record) => $record->first_name . ' ' . $record->last_name)
                    ->searchable(['first_name', 'last_name'])
                    ->sortable(),

                TextColumn::make('phone')
                    ->label('No. WhatsApp')
                    ->searchable(),

                TextColumn::make('total_amount')
                    ->label('Total Bayar')
                    ->formatStateUsing(fn ($state): string => 'Rp ' . number_format($state, 0, ',', '.'))
                    ->sortable(),

                TextColumn::make('payment_status')
                    ->label('Pembayaran')
                    ->badge()
                    ->color(fn (string $state): string => match ($state) {
                        'paid' => 'success',
                        'unpaid' => 'warning',
                        'failed' => 'danger',
                        default => 'gray',
                    })
                    ->formatStateUsing(fn (string $state): string => match ($state) {
                        'paid' => 'Lunas',
                        'unpaid' => 'Belum Lunas',
                        'failed' => 'Gagal',
                        default => $state,
                    })
                    ->sortable(),

                TextColumn::make('status')
                    ->label('Status Pesanan')
                    ->badge()
                    ->color(fn (string $state): string => match ($state) {
                        'new' => 'info',
                        'process' => 'primary',
                        'shipped' => 'warning',
                        'delivered' => 'success',
                        'cancelled' => 'danger',
                        default => 'gray',
                    })
                    ->formatStateUsing(fn (string $state): string => match ($state) {
                        'new' => 'Baru',
                        'process' => 'Diproses',
                        'shipped' => 'Dikirim',
                        'delivered' => 'Selesai',
                        'cancelled' => 'Dibatalkan',
                        default => $state,
                    })
                    ->sortable(),

                TextColumn::make('created_at')
                    ->label('Waktu Pesanan')
                    ->dateTime('d/m/Y H:i')
                    ->sortable(),
            ])
            ->filters([
                \Filament\Tables\Filters\SelectFilter::make('payment_status')
                    ->label('Status Pembayaran')
                    ->options([
                        'unpaid' => 'Belum Lunas',
                        'paid' => 'Lunas',
                        'failed' => 'Gagal',
                    ]),
                \Filament\Tables\Filters\SelectFilter::make('status')
                    ->label('Status Pesanan')
                    ->options([
                        'new' => 'Baru',
                        'process' => 'Diproses',
                        'shipped' => 'Dikirim',
                        'delivered' => 'Selesai',
                        'cancelled' => 'Dibatalkan',
                    ]),
            ])
            ->recordActions([
                EditAction::make(),
            ])
            ->actions([
                Action::make('whatsapp')
                    ->label('Kirim WA')
                    ->icon('heroicon-o-chat-bubble-left-right')
                    ->color('success')
                    ->url(fn ($record) => self::generateWhatsAppUrl($record))
                    ->openUrlInNewTab(),
                \Filament\Actions\DeleteAction::make(),
            ])
            ->toolbarActions([
                BulkActionGroup::make([
                    DeleteBulkAction::make(),
                ]),
            ]);
    }

    protected static function generateWhatsAppUrl($record): string
    {
        $phone = preg_replace('/[^0-9]/', '', $record->phone);
        if (str_starts_with($phone, '0')) {
            $phone = '62' . substr($phone, 1);
        }

        $formattedTotal = 'Rp ' . number_format($record->total_amount, 0, ',', '.');
        
        if ($record->payment_status === 'unpaid') {
            $message = "Halo {$record->first_name},\n\nKami dari *Diena Parfum* ingin mengonfirmasi pesanan Anda dengan kode *#{$record->order_number}* sebesar *{$formattedTotal}*.\n\nMenunggu konfirmasi pembayaran/bukti transfer dari Anda agar pesanan dapat segera diproses ya kak. Silakan kirimkan bukti transfernya ke chat ini. Terima kasih! ✦";
        } elseif ($record->payment_status === 'paid' && $record->status === 'process') {
            $message = "Halo {$record->first_name},\n\nTerima kasih! Pembayaran Anda sebesar *{$formattedTotal}* untuk pesanan *#{$record->order_number}* telah kami terima (Lunas).\n\nParfum pesanan Anda saat ini sedang kami kemas secara rapi dan akan segera diserahkan ke ekspedisi. Kami akan mengabari Anda kembali setelah resi pengiriman keluar. ✦";
        } elseif ($record->status === 'shipped') {
            $message = "Halo {$record->first_name},\n\nKabar baik! Pesanan *#{$record->order_number}* Anda telah selesai dikemas dan diserahkan ke kurir ekspedisi untuk dikirim.\n\nAnda dapat memantau perjalanannya dengan nomor resi berikut:\n📦 *Ekspedisi & Nomor Resi:* [Tulis Resi Di Sini]\n\nTerima kasih telah berbelanja di Diena Parfum! Ditunggu ulasan bintang 5-nya ya kak setelah parfum sampai. ✦";
        } else {
            $message = "Halo {$record->first_name},\n\nKami dari *Diena Parfum* ingin menghubungi Anda terkait pesanan *#{$record->order_number}*. Apakah ada yang bisa kami bantu? ✦";
        }

        return "https://wa.me/{$phone}?text=" . urlencode($message);
    }
}
