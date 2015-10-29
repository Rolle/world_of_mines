class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :gps_files
  has_many :events
  belongs_to :user_group

  def guest?
  	return true if user_group_id == 1
  	false
  end

  def user?
  	return true if user_group_id >= 2
  	false  	
  end

  def admin?
  	return true if user_group_id >= 3
  	false  	
  end

  def superadmin?
  	return true if user_group_id >= 4
  	false  
  end

end
