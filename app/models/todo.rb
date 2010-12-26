class Todo < ActiveRecord::Base
  belongs_to :user
  
  validates :user, :presence => true
  validates :description, :presence => true, :length => { :maximum => 140 }
  validates :time, :numericality => true
  
    def tpdescription
      (" " + self.description + " ").gsub(" I "," you ").gsub(" i "," you ").gsub(" my "," your ").gsub(" myself "," yourself ").gsub(" me "," you ").gsub(" us "," you ").gsub(" we "," you ").gsub(" mine ", " yours ").gsub(" ourselves "," yourselves ")
    end
end
