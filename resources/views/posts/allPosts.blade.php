@extends('layouts/main')

@section('content')
    <h1>POSTS</h1>
    <p>This is the posts page</p>
    @foreach($posts as $post)
        <h2>{{ $post->name }}</h2>
    @endforeach
@endsection