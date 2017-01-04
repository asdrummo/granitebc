class Activity < ActiveRecord::Base
    validates :activity_id, uniqueness: true

end
