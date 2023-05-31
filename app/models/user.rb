class User < ApplicationRecord
  has_many :workspaces, foreign_key: 'creator_id'
  has_many :notes, foreign_key: 'author_id'


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
