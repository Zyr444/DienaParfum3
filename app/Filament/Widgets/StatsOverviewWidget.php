<?php

namespace App\Filament\Widgets;

use App\Models\Order;
use App\Models\User;
use Filament\Widgets\StatsOverviewWidget as BaseStatsOverviewWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;

class StatsOverviewWidget extends BaseStatsOverviewWidget
{
    protected function getStats(): array
    {
        $totalSales = Order::where('payment_status', 'paid')->sum('total_amount');
        $totalOrders = Order::count();
        $pendingOrders = Order::where('status', 'new')->count();
        $totalUsers = User::count();

        return [
            Stat::make('Total Omset Penjualan', 'Rp ' . number_format($totalSales, 0, ',', '.'))
                ->description('Total dari transaksi berstatus lunas')
                ->descriptionIcon('heroicon-m-banknotes')
                ->color('success'),
            
            Stat::make('Pesanan Baru (Pending)', $pendingOrders)
                ->description('Perlu konfirmasi pembayaran/chat WA')
                ->descriptionIcon('heroicon-m-shopping-bag')
                ->color($pendingOrders > 0 ? 'warning' : 'success'),

            Stat::make('Total Semua Transaksi', $totalOrders)
                ->description('Jumlah seluruh pesanan tercatat')
                ->descriptionIcon('heroicon-m-arrow-path')
                ->color('info'),

            Stat::make('Pelanggan Terdaftar', $totalUsers)
                ->description('Total pengguna di website')
                ->descriptionIcon('heroicon-m-user-group')
                ->color('primary'),
        ];
    }
}
