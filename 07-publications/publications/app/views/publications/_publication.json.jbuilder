json.extract! publication, :id, :title, :published_at, :abstract, :created_at, :updated_at
json.url publication_url(publication, format: :json)
