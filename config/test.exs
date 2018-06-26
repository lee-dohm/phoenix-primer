use Mix.Config

config :ex_doc, :markdown_processor, ExDoc.Markdown.Cmark

# Customize the test environment for CI systems
if System.get_env("CI") == "true", do: import_config("ci.exs")
