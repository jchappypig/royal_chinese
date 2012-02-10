class Menu < ActiveRecord::Base
  validate :name, presence:true
end
