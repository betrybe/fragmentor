# Fragmentor

Fragmentor helps to render `markdown` on web browsers.
It takes a raw markdown text as input, translate it to `html` using  [earmark](https://github.com/pragdave/earmark) and then create chunks of html code objects.

## Chunk types

Currently there are three types of chunk:

### Code chunk

A markdown code text taken as input:

~~~
 ```elixir
 my_map = %{name: foo, age: 23}
 ```
~~~

Produces the following object output:

```elixir
  %Fragmentor.Fragment.Code{
    fragment_type: "code",
    language: "elixir",
    content: "my_map = %{name: foo, age: 23}"
  }
```

### Video chunk

An html video iframe placed in markdown

```html
  <iframe src="https://player.vimeo.com/video/675564253?h=588f932258" width="640" height="360" frameborder="0" allow="autoplay; fullscreen; picture-in-picture" allowfullscreen></iframe>
```

Produces the following object output:

```elixir
  %Fragmentor.Fragment.Video{
    fragment_type: "video",
    provider: "vimeo",
    url: "https://player.vimeo.com/video/675564253?",
    video_id: "675564253"
  }
````

### Html content chunk

Other general markdown texts

```markdown
  hello it`s an markdown
```

Produces the following object output:

```elixir
 Fragmentor.Fragment.Html{
    fragment_type: "html",
    content: "hello it`s a markdown",
  }
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

There are two available functions and their bang counterparts options according the elixir common practices:

- `Fragmentor.to_html(markdown, options \\ [])`
- `Fragmentor.to_html!(markdown, options \\ [])`
- `Fragmentor.to_fragments(markdown, options \\ [])`
- `Fragmentor.to_html(markdown, options \\ [])`

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
