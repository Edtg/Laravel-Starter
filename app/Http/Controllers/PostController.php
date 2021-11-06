<?php

namespace App\Http\Controllers;

use App\Models\Post;
use Illuminate\Http\Request;

class PostController extends Controller
{
    public function showPosts()
    {
        return view('posts.allPosts');
    }

    public function showPost($id)
    {
        return view('posts.post');
    }

    public function newPost()
    {
        $post = new Post;

        $post->save();

        return redirect('/posts/edit/'.$post->id);
    }

    public function showEditPost($id)
    {
        return view('posts.editPost');
    }

    public function editPost(Request $request, Post $post)
    {
        return redirect('/post/'.$post->id);
    }
}
