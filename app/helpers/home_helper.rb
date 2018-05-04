module HomeHelper
  require 'securerandom'
  require 'open-uri'

  def generate_key
    "soloq#{SecureRandom.hex(4)}"
  end

  def get_summoner_id(summoner_name)
    by_name = open("https://br1.api.riotgames.com/lol/summoner/v3/summoners/by-name/#{summoner_name}?api_key=#{ENV["RIOT_KEY"]}").string

    summoner_hash = JSON.parse by_name
    summoner_hash["id"]
  end

  def get_summoner_verification_code(summoner_id)
    by_id = open("https://br1.api.riotgames.com/lol/platform/v3/third-party-code/by-summoner/#{summoner_id}?api_key=#{ENV["RIOT_KEY"]}").string

    verification_hash = JSON.parse by_id
  end

  def get_user_tier_rank(user)
    rank_string = open("https://br1.api.riotgames.com/lol/league/v3/positions/by-summoner/#{user.summoner_id}?api_key=#{ENV["RIOT_KEY"]}").string

    rank_hash = JSON.parse rank_string
    [rank_hash[0]["tier"], rank_hash[0]["rank"]]
  end
end

# dummy ID
# 1350198
# dummy key
# soloq09caef7a
