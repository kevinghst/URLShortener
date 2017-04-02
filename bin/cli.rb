p "Input your email:"

email = gets.chomp
user = User.find_by_email(email)

puts "Press 0 to create new short url \nPress 1 to visit an existing one"

option = gets.chomp

if option == "0"
  puts "Type in your long url"
  long_url = gets.chomp

  new_url = Url.create_new_url(user.id, long_url)
  puts new_url.short_url
else
  puts "Type in the shortened URL"
  short_url = gets.chomp

  url = Url.find_by_short_url(short_url)
  puts url.long_url
end


#QasWphhITQQaaicwh_ut5w
