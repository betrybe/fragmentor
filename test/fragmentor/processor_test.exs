defmodule Fragmentor.ProcessorTest do
  use ExUnit.Case

  doctest Fragmentor.Processor

  alias Fragmentor.Fragment.{Code, Video, Html}
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
  end
end
