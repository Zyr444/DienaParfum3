<?php

namespace App\Http\Controllers;

use App\Models\Order;
use App\Models\OrderItem;
use App\Models\Cart;
use Illuminate\Http\Request;
use Illuminate\Support\Str;

class CheckoutController extends Controller
{
    public function store(Request $request)
    {
        $request->validate([
            'first_name' => 'required|string|max:255',
            'last_name' => 'required|string|max:255',
            'email' => 'required|email|max:255',
            'phone' => 'required|string|max:20',
            'address1' => 'required|string',
            'address2' => 'nullable|string',
            'post_code' => 'nullable|string|max:10',
            'country' => 'nullable|string|max:100',
            'cart_items' => 'required|array',
            'cart_items.*.product_id' => 'required|exists:products,id',
            'cart_items.*.price' => 'required|numeric',
            'cart_items.*.quantity' => 'required|integer|min:1',
            'sub_total' => 'required|numeric',
            'total_amount' => 'required|numeric',
            'coupon' => 'nullable|string|max:255',
        ]);

        $orderNumber = 'DP-' . date('Ymd') . '-' . strtoupper(Str::random(4));

        $order = Order::create([
            'order_number' => $orderNumber,
            'user_id' => auth()->id(),
            'sub_total' => $request->sub_total,
            'shipping_id' => null,
            'coupon' => $request->coupon,
            'total_amount' => $request->total_amount,
            'quantity' => collect($request->cart_items)->sum('quantity'),
            'payment_method' => 'bank_transfer',
            'payment_status' => 'unpaid',
            'status' => 'new',
            'first_name' => $request->first_name,
            'last_name' => $request->last_name,
            'email' => $request->email,
            'phone' => $request->phone,
            'country' => $request->country ?? 'Indonesia',
            'post_code' => $request->post_code,
            'address1' => $request->address1,
            'address2' => $request->address2,
        ]);

        foreach ($request->cart_items as $item) {
            OrderItem::create([
                'order_id' => $order->id,
                'product_id' => $item['product_id'],
                'price' => $item['price'],
                'quantity' => $item['quantity'],
                'amount' => $item['price'] * $item['quantity'],
            ]);
        }

        // Clear user's active cart in database if logged in
        if (auth()->check()) {
            Cart::where('user_id', auth()->id())->delete();
        }

        return response()->json([
            'success' => true,
            'order_number' => $order->order_number,
            'message' => 'Pesanan berhasil disimpan di database!',
        ]);
    }
}
