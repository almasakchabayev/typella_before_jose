defmodule Typi.Router do
  use Typi.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Typi do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/auth", Auth do
    pipe_through :api

    post "/register", AccountController, :register
    post "/test", AccountController, :test
    post "/verify", VerifyController, :verify
  end
end
