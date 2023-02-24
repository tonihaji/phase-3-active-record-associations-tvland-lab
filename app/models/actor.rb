class Actor < ActiveRecord::Base
    has_many :characters
    has_many :shows, through: :characters
  
    def full_name
      "#{self.first_name} #{self.last_name}"
    end
  
    def characters
      Character.where(actor_id: self.id)
    end
  
    def shows
      Show.joins(:characters).where(characters: { actor_id: self.id })
    end
  
    def list_roles
      self.characters.map do |character|
        "#{character.name} - #{character.show.name}"
      end
    end 
end