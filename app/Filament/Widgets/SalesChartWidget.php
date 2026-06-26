<?php

namespace App\Filament\Widgets;

use App\Models\Order;
use Filament\Widgets\ChartWidget;

class SalesChartWidget extends ChartWidget
{
    protected ?string $heading = 'Perkembangan Penjualan (30 Hari Terakhir)';

    protected function getData(): array
    {
        $salesData = [];
        $labels = [];
        
        // Initialize last 30 days
        for ($i = 29; $i >= 0; $i--) {
            $date = now()->subDays($i)->format('Y-m-d');
            $labels[] = now()->subDays($i)->format('d M');
            $salesData[$date] = 0;
        }

        // Query sales data
        $records = Order::where('payment_status', 'paid')
            ->where('created_at', '>=', now()->subDays(30))
            ->selectRaw('DATE(created_at) as date, SUM(total_amount) as total')
            ->groupBy('date')
            ->get();

        foreach ($records as $record) {
            if (isset($salesData[$record->date])) {
                $salesData[$record->date] = (float) $record->total;
            }
        }

        return [
            'datasets' => [
                [
                    'label' => 'Omset Harian (Rupiah)',
                    'data' => array_values($salesData),
                    'borderColor' => '#D4AF37', // Gold theme
                    'backgroundColor' => 'rgba(212, 175, 55, 0.1)',
                    'fill' => true,
                    'tension' => 0.3,
                ],
            ],
            'labels' => $labels,
        ];
    }

    protected function getType(): string
    {
        return 'line';
    }
}
