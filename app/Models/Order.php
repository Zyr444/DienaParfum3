<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Order extends Model
{
    protected $fillable = [
        'order_number',
        'user_id',
        'sub_total',
        'shipping_id',
        'coupon',
        'total_amount',
        'quantity',
        'payment_method',
        'payment_status',
        'status',
        'first_name',
        'last_name',
        'email',
        'phone',
        'country',
        'post_code',
        'address1',
        'address2',
    ];

    protected $casts = [
        'sub_total' => 'decimal:2',
        'total_amount' => 'decimal:2',
    ];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function shipping(): BelongsTo
    {
        return $this->belongsTo(Shipping::class);
    }

    public function items(): \Illuminate\Database\Eloquent\Relations\HasMany
    {
        return $this->hasMany(OrderItem::class);
    }
}
