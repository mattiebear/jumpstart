defmodule JumpstartWeb.Components do
  use Phoenix.Component

  attr :email, :string, required: true

  def avatar(assigns) do
    ~H"""
    <div class="h-[3.75rem] w-[3.75rem] rounded-full overflow-hidden">
      <img src={gravatar_url(@email)} />
    </div>
    """
  end

  defp gravatar_url(email) do
    %URI{scheme: "https", host: "gravatar.com"}
    |> URI.append_query("d=mp")
    |> hash_email(email)
    |> to_string
  end

  defp hash_email(uri, email) do
    hash = :crypto.hash(:md5, String.downcase(email)) |> Base.encode16(case: :lower)
    %URI{uri | path: "/avatar/#{hash}"}
  end
end
