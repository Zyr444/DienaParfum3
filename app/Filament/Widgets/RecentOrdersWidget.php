<?php

namespace App\Filament\Widgets;

use App\Models\Order;
use Filament\Actions\Action;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Table;
use Filament\Widgets\TableWidget;
use Illuminate\Database\Eloquent\Builder;

class RecentOrdersWidget extends TableWidget
{
    protected static ?string $heading = 'Pesanan WhatsApp Terbaru';

    protected int|string|array $columnSpan = 'full';

    public function table(Table $table): Table
    {
        return $table
            ->query(
                fn (): Builder => Order::query()->latest()->limit(5)
            )
            ->columns([
                TextColumn::make('order_number')
                    ->label('No. Pesanan')
                    ->copyable(),

                TextColumn::make('first_name')
                    ->label('Penerima')
                    ->state(fn ($record) => $record->first_name . ' ' . $record->last_name),

                TextColumn::make('phone')
                    ->label('WhatsApp'),

                TextColumn::make('total_amount')
                    ->label('Total')
                    ->formatStateUsing(fn ($state): string => 'Rp ' . number_format($state, 0, ',', '.')),

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
                    }),

                TextColumn::make('status')
                    ->label('Status')
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
                    }),

                TextColumn::make('created_at')
                    ->label('Waktu')
                    ->dateTime('d/m/Y H:i'),
            ])
            ->paginated(false)
            ->actions([
                Action::make('whatsapp')
                    ->label('Kirim WA')
                    ->icon('heroicon-o-chat-bubble-left-right')
                    ->color('success')
                    ->url(fn ($record) => self::generateWhatsAppUrl($record))
                    ->openUrlInNewTab(),
                \Filament\Actions\EditAction::make()
                    ->url(fn ($record) => "/admin/orders/{$record->id}/edit"),
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
