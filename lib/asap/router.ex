defmodule SlackAsap.Router do
  use Plug.Router

  plug Plug.Parsers, parsers: [:urlencoded]
  plug :match
  plug :dispatch

  # Slack will periodically send get requests
  # to make sure the bot is still alive.
  get "/" do
    send_resp(conn, 200, "")
  end

  post "/" do
    conn
      |> resp(200, Poison.encode!(SlackAsap.Command.handle(conn.params)))
      |> put_resp_content_type("application/json")
      |> send_resp()
  end

  match _ do
    send_resp(conn, 404, "Not found")
  end
end
