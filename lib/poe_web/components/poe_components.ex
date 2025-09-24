defmodule PoeWeb.PoeComponents do
  @moduledoc """
  Provides custom UI components.
  """
  use Phoenix.Component
  use PoeWeb, :verified_routes

  @doc """
  Renders an image.

  ## Examples

      <.image src="image.png" alt="Content description" class="h-auto" />
  """
  attr :src, :string, required: true
  attr :alt, :string, required: true
  attr :class, :string, default: ""

  def image(assigns) do
    ~H"""
    <img src={~p"/images/#{@src}"} alt={@alt} class={@class || ""} />
    """
  end

  @doc """
  Renders the Piece of English logo.

  ## Examples

      <.logo />
  """
  attr :class, :string, default: ""

  def logo(assigns) do
    ~H"""
    <.image src="piece_of_english.png" alt="Piece of English logo" class={"aspect-square #{@class}"} />
    """
  end

  @doc """
  Renders the Piece of English logo.

  ## Examples

      <.logo_only />
  """
  attr :class, :string, default: ""

  def logo_only(assigns) do
    ~H"""
    <.image
      src="piece_of_english_logo_only.png"
      alt="Piece of English logo"
      class={"aspect-square #{@class}"}
    />
    """
  end

  @doc """
  A page title and subtitle.

  ## Example

    <.heading title="Section title" description="Section description" />
  """
  attr :title, :string, required: true
  attr :description, :string, default: nil
  attr :class, :string, default: ""

  def heading(assigns) do
    ~H"""
    <div class={@class || ""}>
      <p class="text-[2rem] mt-4 font-semibold leading-10 tracking-tighter text-zinc-900 text-balance">
        {@title}
      </p>
      <%= if @description do %>
        <p class="mt-4 text-base leading-7 text-zinc-600">
          {@description}
        </p>
      <% end %>
    </div>
    """
  end

  @doc """
  Renders a button on the front page.

  ## Example

    <.front_page_button href={~p"/about"} label="About">
      <.icon_info />
    </.front_page_button>
  """
  attr :href, :string, required: true
  attr :label, :string, required: true
  slot :inner_block, required: true

  def front_page_button(assigns) do
    ~H"""
    <a href={@href} class= "group relative rounded-2xl px-6 py-4 text-sm text-center font-semibold leading-6 text-zinc-900 sm:py-6">
      <span class="absolute inset-0 rounded-2xl transition bg-[#ffdfec] bg-opacity-40 group-hover:bg-opacity-50 sm:group-hover:scale-105">
      </span>
      <span class="relative flex items-center gap-4 sm:flex-col">
        {render_slot(@inner_block)}
        {@label}
      </span>
    </a>
    """
  end

  @doc """
  An "info" icon, courtesy of mingcute.com.

  https://www.mingcute.com/

  ## Example

      <.icon_info content_color="#000000" />
  """
  attr :content_color, :string, default: "#18181bcc"
  attr :content_fill_color, :string, required: true
  attr :fill_opacity, :float, default: 0.5
  attr :class, :string, default: "h-8 w-8"

  def icon_info(assigns) do
    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      width="24"
      height="24"
      viewBox="0 0 24 24"
      class={@class || ""}
    >
      <g id="information_line" fill="none">
        <path d="M24 0v24H0V0zM12.593 23.258l-.011.002-.071.035-.02.004-.014-.004-.071-.035c-.01-.004-.019-.001-.024.005l-.004.01-.017.428.005.02.01.013.104.074.015.004.012-.004.104-.074.012-.016.004-.017-.017-.427c-.002-.01-.009-.017-.017-.018m.265-.113-.013.002-.185.093-.01.01-.003.011.018.43.005.012.008.007.201.093c.012.004.023 0 .029-.008l.004-.014-.034-.614c-.003-.012-.01-.02-.02-.022m-.715.002a.023.023 0 0 0-.027.006l-.006.014-.034.614c0 .012.007.02.017.024l.015-.002.201-.093.01-.008.004-.011.017-.43-.003-.012-.01-.01z" /><path
          fill={@content_fill_color}
          stroke={@content_color}
          stroke-width="1"
          stroke-linecap="round"
          stroke-linejoin="round"
          d="M12 2c5.523 0 10 4.477 10 10s-4.477 10-10 10S2 17.523 2 12 6.477 2 12 2m0 2a8 8 0 1 0 0 16 8 8 0 0 0 0-16m-.01 6c.558 0 1.01.452 1.01 1.01v5.124A1 1 0 0 1 12.5 18h-.49A1.01 1.01 0 0 1 11 16.99V12a1 1 0 1 1 0-2zM12 7a1 1 0 1 1 0 2 1 1 0 0 1 0-2"
        />
      </g>
    </svg>
    """
  end

  @doc """
  A "calendar" icon, courtesy of mingcute.com.

  https://www.mingcute.com/

  ## Example

      <.icon_file_certificate content_color="#000000" />
  """
  attr :content_color, :string, default: "#18181bcc"
  attr :content_fill_color, :string, required: true
  attr :fill_opacity, :float, default: 0.5
  attr :class, :string, default: "h-8 w-8"

  def icon_calendar(assigns) do
    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      width="24"
      height="24"
      viewBox="0 0 24 24"
      class={@class || ""}
    >
      <g id="calendar_2_line" fill="none" fill-rule="evenodd">
        <path d="M24 0v24H0V0zM12.594 23.258l-.012.002-.071.035-.02.004-.014-.004-.071-.036c-.01-.003-.019 0-.024.006l-.004.01-.017.428.005.02.01.013.104.074.015.004.012-.004.104-.074.012-.016.004-.017-.017-.427c-.002-.01-.009-.017-.016-.018m.264-.113-.014.002-.184.093-.01.01-.003.011.018.43.005.012.008.008.201.092c.012.004.023 0 .029-.008l.004-.014-.034-.614c-.003-.012-.01-.02-.02-.022m-.715.002a.023.023 0 0 0-.027.006l-.006.014-.034.614c0 .012.007.02.017.024l.015-.002.201-.093.01-.008.003-.011.018-.43-.003-.012-.01-.01z" /><path
          fill={@content_fill_color}
          stroke={@content_color}
          stroke-width="1"
          stroke-linecap="round"
          stroke-linejoin="round"
          d="M16 3a1 1 0 0 1 1 1v1h2a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V7a2 2 0 0 1 2-2h2V4a1 1 0 0 1 2 0v1h6V4a1 1 0 0 1 1-1M8 7H5v2h14V7h-3zm-3 4v8h14v-8zm2 2a1 1 0 0 1 1-1h.01a1 1 0 1 1 0 2H8a1 1 0 0 1-1-1m1 2a1 1 0 1 0 0 2h.01a1 1 0 1 0 0-2zm3-2a1 1 0 0 1 1-1h.01a1 1 0 1 1 0 2H12a1 1 0 0 1-1-1m1 2a1 1 0 1 0 0 2h.01a1 1 0 1 0 0-2zm3-2a1 1 0 0 1 1-1h.01a1 1 0 1 1 0 2H16a1 1 0 0 1-1-1m1 2a1 1 0 1 0 0 2h.01a1 1 0 1 0 0-2z"
        />
      </g>
    </svg>
    """
  end

  @doc """
  A "file certicate" icon, courtesy of mingcute.com.

  https://www.mingcute.com/

  ## Example

      <.icon_file_certificate content_color="#000000" />
  """
  attr :content_color, :string, default: "#18181bcc"
  attr :content_fill_color, :string, required: true
  attr :fill_opacity, :float, default: 0.5
  attr :class, :string, default: "h-8 w-8"

  def icon_file_certificate(assigns) do
    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      width="24"
      height="24"
      viewBox="0 0 24 24"
      class={@class || ""}
    >
      <g id="file_certificate_line" fill="none" fill-rule="evenodd">
        <path d="M24 0v24H0V0zM12.593 23.258l-.011.002-.071.035-.02.004-.014-.004-.071-.035c-.01-.004-.019-.001-.024.005l-.004.01-.017.428.005.02.01.013.104.074.015.004.012-.004.104-.074.012-.016.004-.017-.017-.427c-.002-.01-.009-.017-.017-.018m.265-.113-.013.002-.185.093-.01.01-.003.011.018.43.005.012.008.007.201.093c.012.004.023 0 .029-.008l.004-.014-.034-.614c-.003-.012-.01-.02-.02-.022m-.715.002a.023.023 0 0 0-.027.006l-.006.014-.034.614c0 .012.007.02.017.024l.015-.002.201-.093.01-.008.004-.011.017-.43-.003-.012-.01-.01z" /><path
          fill={@content_fill_color}
          stroke={@content_color}
          stroke-width="1"
          stroke-linecap="round"
          stroke-linejoin="round"
          d="M13.586 2A2 2 0 0 1 15 2.586L19.414 7A2 2 0 0 1 20 8.414V20a2 2 0 0 1-2 2h-5a1 1 0 1 1 0-2h5V10h-4.5A1.5 1.5 0 0 1 12 8.5V4H6v4a1 1 0 0 1-2 0V4a2 2 0 0 1 2-2zM7 10a4 4 0 0 1 3 6.646v4.192a1.1 1.1 0 0 1-1.592.984L7 21.118l-1.408.704A1.1 1.1 0 0 1 4 20.838v-4.192A4 4 0 0 1 7 10m1 7.874a4.01 4.01 0 0 1-2 0v1.508l.553-.276a1 1 0 0 1 .894 0l.553.276zM7 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4m7-7.586V8h3.586z"
        />
      </g>
    </svg>
    """
  end

  @doc """
  A "instagram" icon, courtesy of mingcute.com.

  https://www.mingcute.com/

  ## Example

      <.icon_instagram content_color="#000000" />
  """
  attr :content_color, :string, default: "#18181bff"
  attr :content_fill_color, :string, required: true
  attr :fill_opacity, :float, default: 0.5
  attr :class, :string, default: "h-8 w-8"

  def icon_instagram(assigns) do
    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      width="24"
      height="24"
      viewBox="0 0 24 24"
      class={@class || ""}
    >
      <g id="instagram_line" fill="none" fill-rule="evenodd">
        <path d="M24 0v24H0V0zM12.593 23.258l-.011.002-.071.035-.02.004-.014-.004-.071-.035c-.01-.004-.019-.001-.024.005l-.004.01-.017.428.005.02.01.013.104.074.015.004.012-.004.104-.074.012-.016.004-.017-.017-.427c-.002-.01-.009-.017-.017-.018m.265-.113-.013.002-.185.093-.01.01-.003.011.018.43.005.012.008.007.201.093c.012.004.023 0 .029-.008l.004-.014-.034-.614c-.003-.012-.01-.02-.02-.022m-.715.002a.023.023 0 0 0-.027.006l-.006.014-.034.614c0 .012.007.02.017.024l.015-.002.201-.093.01-.008.004-.011.017-.43-.003-.012-.01-.01z" /><path
          stroke={@content_color}
          fill={@content_fill_color}
          stroke-width="1"
          stroke-linecap="round"
          stroke-linejoin="round"
          d="M16 3a5 5 0 0 1 5 5v8a5 5 0 0 1-5 5H8a5 5 0 0 1-5-5V8a5 5 0 0 1 5-5zm0 2H8a3 3 0 0 0-3 3v8a3 3 0 0 0 3 3h8a3 3 0 0 0 3-3V8a3 3 0 0 0-3-3m-4 3a4 4 0 1 1 0 8 4 4 0 0 1 0-8m0 2a2 2 0 1 0 0 4 2 2 0 0 0 0-4m4.5-3.5a1 1 0 1 1 0 2 1 1 0 0 1 0-2"
        />
      </g>
    </svg>
    """
  end
end
