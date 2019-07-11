class User < ActiveRecord::Base
  has_many :agendas
  has_many :tasks, through: :agendas
end
