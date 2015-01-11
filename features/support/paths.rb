# Taken from the cucumber-rails project.

module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page$/
      '/?name=You&rounds=1&player_count=1'

    when /the home\s?page to play "(.*)" rounds$/
      "/?name=You&rounds=#{$1}&player_count=1"

    when /the home\s?page with the name "(.^\b*)"$/
      "/?name=#{$1}&rounds=1&player_count=1"

    when /the homepage with the name "(.*)" to play "(.*)" rounds$/
      "/?name=#{$1}&rounds=#{$2}&player_count=1"

    when /the homepage with the name "(.*)" to play "(.*)" rounds with "(.*)" opponents$/
      "/?name=#{$1}&rounds=#{$2}&player_count=#{$3}"

    when /the score reset page/
      "/resetscore"

    when /the newgame page$/
      '/newgame'

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
