# Fragmentor

[![Hex.pm](https://img.shields.io/hexpm/v/fragmentor.svg)](https://hex.pm/packages/fragmentor)
[![Hex.pm](https://img.shields.io/hexpm/dw/fragmentor.svg)](https://hex.pm/packages/fragmentor)
[![Hex.pm](https://img.shields.io/hexpm/dt/fragmentor.svg)](https://hex.pm/packages/fragmentor)

Fragmentor helps to render `markdown` on web browsers.
It takes a raw markdown text as input, translate it into `html` using  [Earmark](https://github.com/pragdave/earmark) and then create chunks of html code objects.

## Chunk types

Currently there are three types of chunk that can be transformed into fragments. Let's see each of them.

### Code chunk

Imagine a markdown code text with syntax highlighting taken as input. Example:

~~~elixir
snippet_code = """
```elixir
my_map = %{name: "foo", age: 23}
```
"""
~~~

And when you execute the code bellow:

```elixir
snippet_code |> Fragmentor.to_html!()
```

It translates into:

```elixir
"<pre><code class=\"elixir\">my_map = %{name: &quot;foo&quot;, age: 23}</code></pre>\n"
```

You can also transform to `html` and then to a code fragment. Like this:

```elixir
snippet_code |> Fragmentor.to_html!() |> Fragmentor.to_fragments!()
```

Produces the following object output:

```elixir
[
  %Fragmentor.Fragment.Code{
    content: "my_map = %{name: &quot;foo&quot;, age: 23}",
    fragment_type: "code",
    language: "elixir"
  }
]
```

### Video chunk

An `html` video iframe placed in markdown. Like:

~~~elixir
html_fragment = """
```
  <iframe src="https://player.vimeo.com/video/754466968" width="640" height="360" frameborder="0" allow="autoplay; fullscreen; picture-in-picture" allowfullscreen></iframe>
```
"""
~~~

It translates into:

```elixir
"<pre><code class=\"html\">  &lt;iframe src=&quot;https://player.vimeo.com/video/754466968&quot; width=&quot;640&quot; height=&quot;360&quot; frameborder=&quot;0&quot; allow=&quot;autoplay; fullscreen; picture-in-picture&quot; allowfullscreen&gt;&lt;/iframe&gt;</code></pre>\n"
```

And you can transform to a video fragment. Let's see:

```elixir
html_fragment |> Fragmentor.to_fragments!()
```

Produces the following object output:

```elixir
[
  %Fragmentor.Fragment.Video{
    fragment_type: "video",
    provider: "vimeo",
    url: "https://player.vimeo.com/video/675564253?",
    video_id: "675564253"
  },
]
````

### Html content chunk

Other general markdown texts

~~~elixir
markdown_text = """
```
  hello it`s an markdown
```
"""
~~~

Let's transform to a markdown text. Like this:

```elixir
markdown_text |> Fragmentor.to_fragments!()
```

Produces the following object output:

```elixir
[
  %Fragmentor.Fragment.Html{
    content: "```\n  hello it`s an markdown\n```\n",
    fragment_type: "html"
  }
]
```

#### Iframe

We can also embed another document in the current HTML document via the `<iframe>` tag. Embedding is a way to display an editor on a documentation page, a blog post, docs, spreadsheets, Google presentations, or any other page.

Imagine we have this piece of code:

~~~elixir
html_fragment = """
```
<iframe src="https://stackblitz.com/edit/react-ts-mtfg3e?embed=1&file=App.tsx" width="640" height="360"></iframe>
```
"""
~~~

And we transform to a simple `html` fragment. Like this:

```elixir
html_fragment |> Fragmentor.to_fragments!()
```

That produces the following output:

```elixir
[
  %Fragmentor.Fragment.Html{
    content: "<iframe src=\"https://stackblitz.com/edit/react-ts-mtfg3e?embed=1&file=App.tsx\" width=\"640\" height=\"360\"></iframe>",
    fragment_type: "html"
  },
]
```

## Installation

To install Fragmentor add it to your list of dependencies in `mix.ex`.

```elixir
def deps do
  [
    {:fragmentor, "~> 0.2.0"}
  ]
end
```

The auto generated docs can be found at [https://hexdocs.pm/fragmentor](https://hexdocs.pm/fragmentor).

## How to use Fragmentor

There are two available functions and their trailing bang counterparts options according the [elixir common practices](https://hexdocs.pm/elixir/main/naming-conventions.html):

- `Fragmentor.to_html(markdown, options \\ [])`
- `Fragmentor.to_html!(markdown, options \\ [])`
- `Fragmentor.to_fragments(markdown, options \\ [])`
- `Fragmentor.to_fragments!(markdown, options \\ [])`

The `to_html/2` function takes a `markdown` text, convert it to `html` using `earmark` and apply some post processings such making every link target blank.

Usage:

```elixir
  markdown = """
    ```java
      public class HelloWorld {
        public static void main(String[] args) {
          System.out.println("Primeira Linha");
          System.out.println("Segunda Linha");
        }
      }
    ```
  """
  Fragmentor.to_html!(markdown)
```

```elixir
 "<pre><code class=\"java\">public class HelloWorld {\npublic static void main(String[] args) {\nSystem.out.println(&quot;Primeira Linha&quot;);\nSystem.out.println(&quot;Segunda Linha&quot;);\n}"
```

The `to_framents/2` function takes a `markdown` text, convert it using the `to_html/2` function and then split it up into fragments.

Usage:

```elixir
  markdown = """
    ```java
      public class HelloWorld {
        public static void main(String[] args) {
          System.out.println("Primeira Linha");
          System.out.println("Segunda Linha");
        }
      }
    ```
  """
  Fragmentor.to_fragments!(markdown)
```

```elixir
  %Fragmentor.Fragment.Code{
    fragment_type: "code",
    language: "elixir",
    content: "public class HelloWorld {\npublic static void main(String[] args) {\nSystem.out.println(\"Primeira Linha\");\nSystem.out.println(\"Segunda Linha\");\n}\n}"
  }
```

## Copyright and License

The source code is under the Apache 2 License.

Copyright (c) 2021 Trybe

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
