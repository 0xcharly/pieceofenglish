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
  attr :src,   :string, required: true
  attr :alt,   :string, required: true
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
  def logo(assigns) do
    ~H"""
    <.image src="piece_of_english.png" alt="Piece of English logo" />
    """
  end
end
