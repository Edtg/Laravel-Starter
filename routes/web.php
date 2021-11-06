<?php

use App\Http\Controllers\PostController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('home');
});


// Login Routes
Route::get('/login', [LoginController::class, 'showLoginForm'])->name('login');
Route::post('/login', [LoginController::class, 'login']);
Route::post('/logout', [LoginController::class, 'logout'])->name('logout');

Route::get('/register', [RegisterController::class, 'showRegistrationForm'])->name('register');
Route::post('/register', [RegisterController::class, 'register']);

Route::group(['prefix' => 'password'], function() {
    Route::get('/reset', [ForgotPasswordController::class, 'showLinkRequestForm']);
    Route::post('/email', [ForgotPasswordController::class, 'sendResetLinkEmail']);
    Route::get('/reset/{token}', [ResetPasswordController::class, 'showResetForm']);
    Route::post('/reset', [ResetPasswordController::class, 'reset']);
});

Route::get('/confirm-password', [ConfirmPasswordController::class, 'showConfirmPasswordForm'])->middleware('auth')->name('password.confirm');
Route::post('/confirm-password', [ConfirmPasswordController::class, 'confirmPassword'])->middleware('auth')->name('password.confirm');

Route::group(['prefix' => 'posts'], function() {
    Route::get('/', [PostController::class, 'showPosts']);
    Route::get('/{id}', [PostController::class, 'showPost']);
    Route::get('/new', [PostController::class, 'newPost'])->middleware(('auth'));
    Route::get('/edit/{id}', [PostController::class, 'showEditPost'])->middleware('auth');
    Route::post('/edit/{id}', [PostController::class, 'editPost'])->middleware('auth');
});