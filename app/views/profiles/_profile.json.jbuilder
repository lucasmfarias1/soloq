json.extract! profile, :id, :name, :tier, :rank, :image, :lol_id, :verification_key, :user_id, :created_at, :updated_at
json.url profile_url(profile, format: :json)
