FROM elixir:slim

WORKDIR /app
ADD . /app

RUN mix local.hex --force
RUN mix deps.get

EXPOSE 4000

CMD ["mix", "run", "--no-halt"]
