defmodule Fragmentor.ProcessorTest do
  use ExUnit.Case

  doctest Fragmentor.Processor

  alias Fragmentor.Fragment.{Code, Html, Video}
  alias Fragmentor.Processor

  @fragments [
    %Html{
      content:
        "<p>Imagine que você está desenvolvendo um sistema que deverá comparar se duas frases são iguais. Para isso, é definida a\n    mesma frase, e o output deverá ser igual, por se tratar de frases idênticas. Nessas situações, é importante saber em\n    qual posição houve a primeira ocorrência de um caractere ou texto. Para conseguirmos resolver esse problema, é hora\n    de aprender a utilizar o método <code class=\"inline\">indexOf</code> da classe <code class=\"inline\">String</code>.\\n⚠\n    <em>Antes de prosseguir, lembre-se de que uma <code class=\"inline\">String</code> nada mais é do que um array de\n        caracteres, onde cada posição desse array\n        contém um caractere.</em>\n</p>\n",
      fragment_type: "html"
    },
    %Video{
      fragment_type: "video",
      provider: "vimeo",
      url: "https://player.vimeo.com/video/677241568?",
      video_id: "677241568"
    },
    %Html{
      content:
        "\n<p>Veja mais um exemplo:</p>\n<p>Vamos começar utilizando <code class=\"inline\">minhaString.indexOf(meuCaracter)</code> para que a função retorne o\n    índice, ou seja, a posição da primeira ocorrência do caractere na string dada. Confira como fazer isso no código\n    abaixo:</p>\n",
      fragment_type: "html"
    },
    %Code{
      content:
        "String saudacao = &quot;Olá, Mundo!&quot;;\\n\\nSystem.out.println(saudacao.indexOf(&#39;M&#39;)); // imprime: 5",
      fragment_type: "code",
      language: "java"
    },
    %Html{
      content:
        "\n<p>Note que o uso do método <code class=\"inline\">minhaString.indexOf</code> nos permitiu fazer a busca pela ocorrência\n    de um caractere, nome ou texto.</p>\n<p>Vamos pegar mais um exemplo:</p>\n",
      fragment_type: "html"
    },
    %Code{
      content:
        "String lorem = &quot;Lorem ipsum dolor sit amet&quot;;\\n\\nSystem.out.println(lorem.indexOf(&#39;s&#39;, 10)); // imprime: 18",
      fragment_type: "code",
      language: "java"
    }
  ]

  @embedded_fragments [
    %Fragmentor.Fragment.Html{
      content:
        "<h1>Incorporando projetos</h1>\n\n<p>\n    A incorporação é uma maneira de exibir um editor StackBlitz em uma página de documentação, uma postagem de blog ou qualquer outra página. Esta página orienta você pela incorporação manual em iframes. Você também pode fazer isso <a href=\"https://developer.stackblitz.com/docs/platform/javascript-sdk/\"></a>programaticamente usando nosso SDK</p>a>.\n</p>\n\n<h2>Incorporando o projeto StackBlitz em uma página</h2>\n\n<p>Os arquivos de código são interativos, além do que a aplicação renderizada também é interativa.</p>\n\n",
      fragment_type: "html"
    },
    %Fragmentor.Fragment.Html{
      fragment_type: "html",
      content:
        "<iframe src=\"https://stackblitz.com/edit/react-ts-mtfg3e?embed=1&file=App.tsx\"></iframe>"
    },
    %Fragmentor.Fragment.Html{
      content:
        "\n\n<h1>ElixirConf 2022 - José Valim - Elixir v1.14</h1>\n\n<p>\n    José Valim (Dashbit) faz a palestra de abertura da ElixirConf US 2022.\n</p>\n\n",
      fragment_type: "html"
    },
    %Fragmentor.Fragment.Video{
      fragment_type: "video",
      provider: "youtube",
      url: "https://www.youtube.com/embed/KmLw58qEtuM\"",
      video_id: "KmLw58qEtuM"
    }
  ]

  describe "to_html/2" do
    test "returns correct html from received markdown" do
      markdown_content = File.read!("test/support/fixtures/markdown/java_content.md")
      expected_result = File.read!("test/support/fixtures/html/java_content.html")

      assert Processor.to_html!(markdown_content) == expected_result
    end
  end

  describe "to_fragment/2" do
    test "returns correct fragments of received html" do
      html_content = File.read!("test/support/fixtures/html/multiple_fragments.html")
      assert Processor.to_fragments!(html_content) == @fragments
    end

    test "returns embedded iframe html with video fragments correctly" do
      html_content = File.read!("test/support/fixtures/html/embedded_iframe_fragments.html")
      assert Processor.to_fragments!(html_content) == @embedded_fragments
    end
  end
end
