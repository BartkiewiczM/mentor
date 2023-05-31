class AddRoomUrlToWorkspaces < ActiveRecord::Migration[7.0]
  def change
    add_column :workspaces, :room_url, :string
  end
end
