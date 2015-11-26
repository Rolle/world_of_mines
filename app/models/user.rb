class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :gps_files
  has_many :events
  belongs_to :user_group
  has_many :orders, dependent: :destroy

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
  
  def work_list_ids
    return [] if self.work_items.nil?
    self.work_items.split("|")
  end
  
  def update_current_ids(mines)   
    if mines.nil?
      self.current_ids = nil
    else
      self.current_ids = ids_to_list(mines)
    end
    self.save
  end

    def update_page_ids(mines)
    self.page_ids = ids_to_list(mines)
    self.save
  end

  def add_or_remove_workitem(id)
    self.work_items = "" if (self.work_items.nil?)
    a = self.work_items.split("|")
    if a.index(id).nil?
      a << id
    else
      a.delete(id)
    end
    self.work_items = a.join("|")
    self.save      
  end

  def add_workitems(id_list)
    self.work_items = "" if (self.work_items.nil?)
    a = self.work_items.split("|")
    ids = id_list.split("|")
    ids.each do |id|      
      if a.index(id).nil?
        a << id
      end
    end
    self.work_items = a.join("|")
    self.save      
  end

  def add_mines_to_workitems(mines)
    ids = []
    mines.each do |mine|
      ids << mine.id.to_s
    end
    add_workitems(ids.join("|"))
  end
  
  def work_item?(id)
    return false if self.work_items.nil?
    a = self.work_items.split("|")
    a.index(id.to_s)
  end

  def work_items_count
    return 0 if self.work_items.nil? 
    self.work_items.split("|").count
  end

  def clear_work_list
    self.work_items = nil
    self.save
  end

  private
    def ids_to_list(mines)
      return "" if mines.nil?
      list = []
      mines.each do |mine|
        list << mine.id.to_s
      end
      return list.join("|")
    end
end
