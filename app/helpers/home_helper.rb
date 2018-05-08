module HomeHelper
  require 'securerandom'
  require 'open-uri'

  def generate_key
    "soloq#{SecureRandom.hex(4)}"
  end

  def get_summoner_id_name(summoner_name)
    name = summoner_name.gsub(' ', '%20')
    by_name = open("https://br1.api.riotgames.com/lol/summoner/v3/summoners/by-name/#{name}?api_key=#{ENV["RIOT_KEY"]}").string

    summoner_hash = JSON.parse by_name
    [summoner_hash["id"], summoner_hash["name"]]
  end

  def get_summoner_verification_code(summoner_id)
    by_id = open("https://br1.api.riotgames.com/lol/platform/v3/third-party-code/by-summoner/#{summoner_id}?api_key=#{ENV["RIOT_KEY"]}").string

    verification_hash = JSON.parse by_id
  end

  def get_user_tier_rank(user)
    rank_string = open("https://br1.api.riotgames.com/lol/league/v3/positions/by-summoner/#{user.summoner_id}?api_key=#{ENV["RIOT_KEY"]}").string

    rank_array = JSON.parse rank_string

    tier = 'UNRANKED'
    rank = nil
    rank_array.each do |queue_hash|
      next unless queue_hash["queueType"] == "RANKED_SOLO_5x5"
      tier = queue_hash["tier"]
      rank = queue_hash["rank"]
    end

    [tier, rank]
  end
end

# dummy ID
# 1350198
# dummy key
# soloq09caef7a
