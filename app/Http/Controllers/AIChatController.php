<?php

namespace App\Http\Controllers;

use App\Models\Product;
use Illuminate\Http\Request;

class AIChatController extends Controller
{
    public function chat(Request $request)
    {
        $request->validate([
            'message' => 'required|string|max:1000',
        ]);

        $message = strtolower($request->input('message'));
        $products = Product::with('category')->get();

        // 1. Detect category/gender intent
        $targetCategory = null;
        if (str_contains($message, 'cewe') || str_contains($message, 'wanita') || str_contains($message, 'perempuan') || str_contains($message, 'women') || str_contains($message, 'girl')) {
            $targetCategory = 'women';
        } elseif (str_contains($message, 'cowo') || str_contains($message, 'pria') || str_contains($message, 'lelaki') || str_contains($message, 'men') || str_contains($message, 'boy')) {
            $targetCategory = 'men';
        } elseif (str_contains($message, 'unisex') || str_contains($message, 'netral') || str_contains($message, 'bersama')) {
            $targetCategory = 'unisex';
        } elseif (str_contains($message, 'premium') || str_contains($message, 'mewah') || str_contains($message, 'eksklusif') || str_contains($message, 'luxury')) {
            $targetCategory = 'premium';
        }

        // 2. Define keyword groups for scoring
        $keywords = [
            'manis' => ['manis', 'sweet', 'vanilla', 'cokelat', 'chocolate', 'caramel', 'karamel', 'madu', 'honey'],
            'segar' => ['segar', 'fresh', 'citrus', 'jeruk', 'lemon', 'mint', 'buah', 'fruit', 'fruity', 'ocean', 'aquatic'],
            'kayu' => ['kayu', 'woody', 'santal', 'sandalwood', 'gaharu', 'oud', 'cedar', 'oakmoss'],
            'bunga' => ['bunga', 'floral', 'rose', 'mawar', 'melati', 'jasmine', 'lavender', 'orchid'],
            'hangat' => ['hangat', 'warm', 'spicy', 'rempah', 'amber', 'musk', 'musky', 'patchouli'],
            'lembut' => ['lembut', 'soft', 'powder', 'powdery', 'clean', 'elegant', 'anggun']
        ];

        // Detect user keywords
        $detectedTypes = [];
        foreach ($keywords as $type => $aliases) {
            foreach ($aliases as $alias) {
                if (str_contains($message, $alias)) {
                    $detectedTypes[] = $type;
                    break;
                }
            }
        }

        // 3. Score products
        $scoredProducts = [];
        foreach ($products as $product) {
            $score = 0;
            $prodName = strtolower($product->name);
            $prodDesc = strtolower($product->description);
            $prodCat = $product->category ? strtolower($product->category->title) : '';

            // Gender / Category matching
            if ($targetCategory) {
                if (str_contains($prodCat, $targetCategory)) {
                    $score += 15;
                } else {
                    // Slight penalty if category mismatch, but allow it if scent keywords match heavily
                    $score -= 5;
                }
            }

            // Keyword matching
            foreach ($detectedTypes as $type) {
                $aliases = $keywords[$type];
                foreach ($aliases as $alias) {
                    if (str_contains($prodName, $alias)) {
                        $score += 10;
                    }
                    if (str_contains($prodDesc, $alias)) {
                        $score += 5;
                    }
                }
            }

            // General keyword search if user typed specific words
            $words = explode(' ', $message);
            foreach ($words as $word) {
                if (strlen($word) > 3) {
                    if (str_contains($prodName, $word)) $score += 8;
                    if (str_contains($prodDesc, $word)) $score += 3;
                }
            }

            if ($score > 0) {
                $scoredProducts[] = [
                    'product' => $product,
                    'score' => $score
                ];
            }
        }

        // Sort by score desc
        usort($scoredProducts, function ($a, $b) {
            return $b['score'] <=> $a['score'];
        });

        // Get top 3 products
        $recommended = array_slice($scoredProducts, 0, 3);
        $recommendedProducts = array_map(function ($item) {
            $product = $item['product'];
            // Normalize image path (same as ProductController)
            if ($product->image && !str_starts_with($product->image, 'http')) {
                if (str_starts_with($product->image, 'products/')) {
                    $product->image = asset('storage/' . $product->image);
                } else {
                    $product->image = asset(ltrim($product->image, '/'));
                }
            }
            return $product;
        }, $recommended);

        // 4. Generate conversational response
        if (empty($recommendedProducts)) {
            // Check if it's a greeting
            if (str_contains($message, 'halo') || str_contains($message, 'hi') || str_contains($message, 'hei') || str_contains($message, 'pagi') || str_contains($message, 'siang') || str_contains($message, 'sore') || str_contains($message, 'malam') || str_contains($message, 'tanya')) {
                $reply = "Halo! Saya adalah **Diena AI Scent Guide**. ✦\n\nSaya bisa membantu mencarikan parfum yang paling cocok untuk kepribadian dan selera Anda. Coba tanyakan sesuatu seperti:\n- *\"saran parfum cewe yang manis\"*\n- *\"parfum cowok yang segar untuk siang hari\"*\n- *\"parfum dengan aroma mawar mewah\"*\n\nAda aroma tertentu yang sedang Anda cari?";
            } else {
                // Return fallback recommendation of best-sellers
                $featured = Product::with('category')->inRandomOrder()->take(2)->get();
                $recommendedProducts = [];
                foreach ($featured as $product) {
                    if ($product->image && !str_starts_with($product->image, 'http')) {
                        if (str_starts_with($product->image, 'products/')) {
                            $product->image = asset('storage/' . $product->image);
                        } else {
                            $product->image = asset(ltrim($product->image, '/'));
                        }
                    }
                    $recommendedProducts[] = $product;
                }
                $reply = "Saya belum menemukan aroma yang persis seperti kata kunci Anda. Namun, berikut adalah beberapa koleksi terlaris dari Diena Parfum yang sangat populer dan wajib Anda coba! Silakan jelajahi aroma segar dan mewah di bawah ini:";
            }
        } else {
            $reply = "Halo! Berdasarkan keinginan Anda, berikut adalah rekomendasi parfum terbaik dari koleksi **Diena Parfum** yang sangat cocok:\n\n";
            $i = 1;
            foreach ($recommendedProducts as $prod) {
                $name = $prod->name;
                if (str_contains($name, '|')) {
                    $name = trim(explode('|', $name)[1]);
                }
                $desc = strip_tags($prod->description);
                if (strlen($desc) > 120) {
                    $desc = substr($desc, 0, 117) . '...';
                }
                $reply .= "{$i}. **{$name}** - {$desc}\n";
                $i++;
            }
            $reply .= "\nAnda bisa melihat detail parfum atau menambahkannya langsung ke keranjang belanja melalui kartu produk di bawah ini. Apakah ada aroma lain yang ingin Anda ketahui?";
        }

        return response()->json([
            'message' => $reply,
            'products' => $recommendedProducts
        ]);
    }
}
