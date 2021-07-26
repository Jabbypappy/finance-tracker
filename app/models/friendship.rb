class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User' # belongs to friend as well, but friend is from the User class, not the Friend class (there isn't a friend class)
end
