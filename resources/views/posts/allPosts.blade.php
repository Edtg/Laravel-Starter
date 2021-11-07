@extends('layouts/main')

@section('content')
    <h1>POSTS</h1>
    <p>This is the posts page</p>
    @foreach($posts as $post)
        <h2><a href="/posts/{{ $post->id }}">{{ $post->title }}</a></h2>
    @endforeach
@endsection