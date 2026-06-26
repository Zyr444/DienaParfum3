<?php

use App\Http\Controllers\ProfileController;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

use App\Http\Controllers\ProductController;
use App\Http\Controllers\AIChatController;
use App\Http\Controllers\CheckoutController;

Route::get('/', [ProductController::class, 'index']);
Route::post('/api/chat-ai', [AIChatController::class, 'chat']);
Route::post('/checkout', [CheckoutController::class, 'store'])->name('checkout');

Route::get('/dashboard', function () {
    $coupons = App\Models\Coupon::where('status', 'active')
        ->where(function($query) {
            $query->whereNull('expires_at')
                  ->orWhere('expires_at', '>', now());
        })
        ->get();

    $orders = App\Models\Order::where('user_id', auth()->id())
        ->with('items.product')
        ->latest()
        ->get();

    return Inertia::render('Dashboard', [
        'coupons' => $coupons,
        'orders' => $orders
    ]);
})->middleware(['auth', 'verified'])->name('dashboard');

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

require __DIR__.'/auth.php';
