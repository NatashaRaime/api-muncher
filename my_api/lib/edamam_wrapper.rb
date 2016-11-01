require 'httparty'

class EdamamApiWrapper
  BASE_URL = "https://api.edamam.com/search"
  ESP_BASE_URL = "https://api.edamam.com/search"
  TOKEN = ENV["TOKEN"]

  def self.listrecipes()
    unless english == false
    BASE_URL = ESP_BASE_URL
      url = BASE_URL + "recipes" + "token=#{TOKEN}" + "&pretty=1&exclude_archived=1"
      data = HTTParty.get(url)
      recipe_list = []
        if data["recipes"]
          data["recipes"].each do |recipe|
            wrapper = Recipe.new recipe["name"], recipe["id"] , purpose: recipe["purpose"], is_archived: recipe["is_archived"], members: recipe["members"]
            recipe_list << wrapper
          end
        end
      end
    #return array of ruby objects rather than a hash of non-parsed data
    return recipe_list
  end

  def self.sendmsg(recipe, msg, token = nil)
    token = TOKEN if token == nil
    puts "Sending message to recipe #{recipe}: #{msg}"
    url = BASE_URL + "chat.postMessage?" + "token=#{TOKEN}"
    data = HTTParty.post(url,
    #just one way of setting up the hash.. text, recipe required; others chosen
    body:  {
      "text" => "#{msg}",
      "recipe" => "#{recipe}",
      "username" => "Roberts-Robit",
      "icon_emoji" => ":robot_face:",
      "as_user" => "false"
    },
    :headers => { 'Content-Type' => 'application/x-www-form-urlencoded' })
    data
  end
end
