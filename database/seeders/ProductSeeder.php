<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Product;
use App\Models\Category;
use Illuminate\Support\Str;

class ProductSeeder extends Seeder
{
    public function run(): void
    {
        $allImages = [
            '/images/elysian_scent.png',
            '/images/oud_imperial.png',
            '/images/midnight_rose.png',
            '/images/santal_majuscule.png',
            '/images/noir_crystal.png',
            '/images/royal_gold.png',
            '/images/rose_velvet.png',
            '/images/ocean_breeze.png',
            '/images/forest_essence.png',
            '/images/amber_sun.png',
            '/images/midnight_lavender.png',
        ];

        $faker = \Faker\Factory::create();

        $aromaNames = [
            'Orchid & Midnight Jasmine', 'Ancient Agarwood', 'Amber & Black Pepper',
            'Sandalwood & Cacao', 'Silver Reflections', 'Carrara Legacy',
            'Crimson Silk', 'Morning Stone', 'Misty Emerald', 'Teardrop Horizon',
            'Violet Lavender', 'Imperial Elixir', 'Celestial Aura', 'Velvet Soul',
            'Divine Dreams', 'Radiant Spirit', 'Sacred Grace', 'Infinite Light',
            'Royal Scent', 'Pure Mist', 'Midnight Glow', 'Golden Heart',
            'Mystic Essence', 'Bergamot Noir', 'Neroli Bloom', 'Vetiver Smoke',
            'Cardamom Spice', 'Tonka Vanilla', 'Leather Oud', 'Rose Absolute'
        ];

        $notes = ['Bergamot', 'Patchouli', 'Neroli', 'Vetiver', 'Cardamom', 'Ylang-Ylang', 'Tonka Bean', 'Leather', 'Jasmine', 'Oud', 'Rose', 'Vanilla', 'Sandalwood', 'Musk'];

        // Get categories
        $womenCategory = Category::where('slug', 'womens-fragrance')->first();
        $menCategory = Category::where('slug', 'mens-fragrance')->first();
        $unisexCategory = Category::where('slug', 'unisex-fragrance')->first();

        if (!$womenCategory || !$menCategory || !$unisexCategory) {
            $this->command->warn('Please run CategorySeeder first!');
            return;
        }

        for ($i = 0; $i < 30; $i++) {
            $note1 = $faker->randomElement($notes);
            $note2 = $faker->randomElement($notes);
            $aromaName = $aromaNames[$i];
            
            // Distribute: 10 Women, 10 Men, 10 Unisex
            $categoryIndex = ($i % 3);
            if ($categoryIndex === 0) {
                $category = $womenCategory;
            } elseif ($categoryIndex === 1) {
                $category = $menCategory;
            } else {
                $category = $unisexCategory;
            }
            $price = $faker->numberBetween(18, 60) * 100000;
            $slug = Str::slug($aromaName);
            $sku = 'DIENA-' . Str::upper(Str::random(6));

            Product::create([
                'name'           => "Diena Parfume | {$aromaName}",
                'title'          => $aromaName,
                'slug'           => $slug,
                'description'    => "A masterfully crafted signature scent by Diena Parfume, blending top notes of {$note1} with base notes of {$note2} for a truly unique and unforgettable experience.",
                'summary'        => "Premium {$aromaName} by Diena Parfume",
                'price'          => $price,
                'original_price' => $price * $faker->randomFloat(2, 1.1, 1.5),
                'image'          => $allImages[$i % count($allImages)],
                'photo'          => $allImages[$i % count($allImages)],
                'stock'          => $faker->numberBetween(5, 25),
                'category_id'    => $category->id,
                'sku'            => $sku,
                'status'         => 'active',
            ]);
        }

        $this->command->info('30 Diena Parfume products created successfully!');
    }
}

