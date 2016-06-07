namespace :populator do
  desc "Populate database with template"
  task template: :environment do
  	[
  		{"url":"wedding-bells","demo_website":"\/\/themes.sindevo.com\/wedding-bells\/","display_name":"Wedding Bells"}, 
  		{"url":"weddingbliss","demo_website":"\/\/girlscancode.com\/weddingbliss\/","display_name":"Wedding Bliss"}, 
  		{"url":"w3wedding","demo_website":"\/\/themes.w3nuts.co.uk\/w3wedding\/version4\/","display_name":"W3 Wedding"}, 
  		{"url":"marriage","demo_website":"\/\/themes.sindevo.com\/marriage\/","display_name":"Marriage"}, 
  		{"url":"weddingtime","demo_website":"\/\/demo.codeopus.net\/weddingtime\/","display_name":"weddingtime"}, 
  		{"url":"wedding_slide","demo_website":"\/\/www.edigitaldreams.com\/tf\/Wedding_Slide\/v_2_0\/","display_name":"Wedding Slide"}, 
  		{"url":"eternity","demo_website":"\/\/themechills.com\/preview\/html\/eternity\/","display_name":"eternity"}, 
  		{"url":"sweetly","demo_website":"\/\/demohtml.templatesquare.com\/sweetly\/","display_name":"sweetly"}, 
  		{"url":"yes","demo_website":"\/\/logicathemes.com\/yes\/","display_name":"yes"}, 
  		{"url":"bestday","demo_website":"http:\/\/www.maskandesign.com\/bestday\/","display_name":"bestday"}, 
  		{"url":"perfectcouple","demo_website":"http:\/\/www.coffeecreamthemes.com\/themes\/perfectcouple\/site\/demo1-full\/","display_name":"Perfect Couple"}

  		].each do |plate|
  			Template.create(plate)
  		end

  end

end
