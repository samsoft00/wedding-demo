module SetupStoreHelper
	
	def tutorial_progress_bar
	  content_tag(:div, class: "side-nav", id:"leftCol") do
	    content_tag(:div, class: "hide-side") do
	      content_tag(:ul, class: "listnone nav affix-top", id:"sidebar") do
	        wizard_steps.collect do |every_step|
	          class_str = "unfinished"
	          class_str = "current active"  if every_step == step
	          class_str = "finished" if past_step?(every_step)
	          concat(
	            content_tag(:li, class: class_str) do
	              link_to every_step.to_s.gsub('_', ' '), wizard_path(every_step)
	            end 
	          )   
	        end 
	      end 
	    end
	  end
	end

end