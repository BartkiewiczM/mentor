class WorkspacesController < ApplicationController
  require 'net/http'
  require 'uri'

  before_action :set_workspace, only: [:show, :destroy]

  def index
    @workspaces = current_user.workspaces
  end

  def show
  end

  def create
    @workspace = current_user.workspaces.build(workspace_params)
    @workspace.room_url = create_room(name: @workspace.id)

    if @workspace.save
      redirect_to workspaces_path
    else
      render :index
    end
  end

  def destroy
    @workspace.destroy
    redirect_to workspaces_url
  end

  private

  def workspace_params
    params.require(:workspace).permit(:name)
  end

  def set_workspace
    @workspace = Workspace.find(params[:id])
  end

  def create_room(name:)
    uri = URI.parse("https://api.daily.co/v1/rooms")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request["Authorization"] = "Bearer 624c74ab5fc8decce8f50f54c5c0dd973f9f98006418e3b7eb1bfbf1b01a24ac"
    request.body = JSON.dump({
      "name" => name,
    })

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    puts "Response status: #{response.code}"  # Add this line
    puts "Response body: #{response.body}"  # Add this line

    @room_url = JSON.parse(response.body)['url']
  end

end
