<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use Inertia\Inertia;
use App\Models\Product;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;

class ProductController extends Controller
{
    public function index()
    {
        $products = Product::with('category')->get()->map(function ($product) {
            if ($product->image && !str_starts_with($product->image, 'http')) {
                if (str_starts_with($product->image, 'products/')) {
                    $product->image = asset('storage/' . $product->image);
                } else {
                    $product->image = asset(ltrim($product->image, '/'));
                }
            }
            return $product;
        });

        return Inertia::render('Welcome', [
            'canLogin' => Route::has('login'),
            'canRegister' => Route::has('register'),
            'laravelVersion' => Application::VERSION,
            'phpVersion' => PHP_VERSION,
            'products' => $products,
            'coupons' => [],
        ]);
    }
}
