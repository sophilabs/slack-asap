defmodule SlackMock.Web.Users do
  def list(),
    do: %{
      "cache_ts" => 1503591092,
      "members" => [
        %{
          "deleted" => false,
          "id" => "UXXXXXXXX",
          "is_app_user" => true,
          "is_bot" => false,
          "name" => "foo",
          "profile" => %{
            "avatar_hash" => "574ef05b3285",
            "email" => "foo@example.com",
            "first_name" => "Franz",
            "image_1024" => "https://avatars.slack-edge.com/2002-01-01/67349247734_d41d8cd98f00b204e95_192.jpg",
            "image_192" => "https://avatars.slack-edge.com/2002-01-01/67349247734_8c374fa08776a8de50c2_192.jpg",
            "image_24" => "https://avatars.slack-edge.com/2002-01-01/67349247734_8c374fa08776a8de50c2_24.jpg",
            "image_32" => "https://avatars.slack-edge.com/2002-01-01/67349247734_8c374fa08776a8de50c2_32.jpg",
            "image_48" => "https://avatars.slack-edge.com/2002-01-01/67349247734_8c374fa08776a8de50c2_48.jpg",
            "image_512" => "https://avatars.slack-edge.com/2002-01-01/67349247734_8c374fa08776a8de50c2_192.jpg",
            "image_72" => "https://avatars.slack-edge.com/2002-01-01/67349247734_8c374fa08776a8de50c2_72.jpg",
            "image_original" => "https://avatars.slack-edge.com/2002-01-01/67349247734_8c374fa08776a8de50c2_original.jpg",
            "last_name" => "Oslvaldiz",
            "phone" => "55555555",
            "real_name" => "Franz Oslvaldiz",
            "real_name_normalized" => "Franz Oslvaldiz",
            "skype" => "Franz Oslvaldiz Skype",
            "team" => "T03LA94885",
            "title" => "Developer"},
            "team_id" => "T03LA94885",
            "updated" => 1000000000
          }
      ],
      "ok" => true,
      "response_metadata" => %{"warnings" => ["superfluous_charset"]},
      "warning" => "superfluous_charset"}
end
