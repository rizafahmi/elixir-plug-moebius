defmodule Helloplug do
  use Application
  use Router
  import Moebius.Query
  require EEx
  EEx.function_from_file(:defp, :template_show_user, "templates/show_user.eex", [:user])

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Helloplug.Db, [Moebius.get_connection()])
    ]

    opts = [strategy: :one_for_one, name: Helloplug.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Routes
  # /hello
  defp route("GET", ["hello"], conn) do
    conn |> Plug.Conn.send_resp(200, "Hello, Plug")
  end

  # /users/:username
  defp route("GET", ["users", username], conn) do
    case db(:users) |> filter(username: username) |> Helloplug.Db.first() do
      {:ok, nil} ->
        conn |> Plug.Conn.send_resp(404, "Username not found")

      {:ok, user} ->
        page_content = template_show_user(user)

        conn
        |> Plug.Conn.put_resp_content_type("text/html")
        |> Plug.Conn.send_resp(200, page_content)
    end
  end

  # 404
  defp route(_method, _path, conn) do
    IO.inspect(_path)
    conn |> Plug.Conn.send_resp(404, "Page not found!")
  end
end
