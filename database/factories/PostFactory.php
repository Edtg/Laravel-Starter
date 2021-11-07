<?php

namespace Database\Factories;

use DateTime;
use Illuminate\Database\Eloquent\Factories\Factory;
use phpDocumentor\Reflection\Types\Boolean;
use Illuminate\Support\Str;

class PostFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        return [
            'title' => Str::random(10),
            'content' => Str::random(50),
            'image_location' => Str::random(5).'/'.Str::random(6),
            'is_published' => rand(0, 1) == 1,
            'published_at' => date('Y/m/d'),
        ];
    }
}
