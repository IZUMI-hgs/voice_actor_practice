json.extract! board, :id, :title, :text, :created_at, :updated_at
json.url board_url(board, format: :json)
