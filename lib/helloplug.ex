defmodule Helloplug do
  use Router

  # Routes
  # /hello
  defp route("GET", ["hello"], conn) do
    conn |> Plug.Conn.send_resp(200, "Hello, Plug")
  end

  # /users/:username
  defp route("GET", ["users", username], conn) do
    page_content = EEx.eval_file("templates/show_user.eex", [username: username])
    conn
      |> Plug.Conn.put_resp_content_type("text/html") 
      |> Plug.Conn.send_resp(200, page_content)
  end

  # 404
  defp route(_method, _path, conn) do
    IO.inspect _path
    conn |> Plug.Conn.send_resp(404, "Page not found!")
  end
end
