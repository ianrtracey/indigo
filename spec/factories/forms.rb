FactoryGirl.define do
	factory :form do
	  name { FFaker::Name.name }
	  body { FFaker::Lorem.paragraphs }
	  submitted false
	  user
	end
end