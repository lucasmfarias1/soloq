module HomeHelper
  require 'securerandom'
  require 'open-uri'

  def generate_key
    SecureRandom.hex(10)
  end


    def summoner_verification_code(summoner)
      by_name = open("https://br1.api.riotgames.com/lol/summoner/v3/summoners/by-name/#{summoner}?api_key=#{ENV["RIOT_KEY"]}").string

      summoner_hash = JSON.parse by_name

      by_id = open("https://br1.api.riotgames.com/lol/platform/v3/third-party-code/by-summoner/#{summoner_hash["id"]}?api_key=#{ENV["RIOT_KEY"]}").string

      verification_hash = JSON.parse by_id
    end
end

# dummy ID
# 1350198
