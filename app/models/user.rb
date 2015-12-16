class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :gps_files
  has_many :events
  belongs_to :user_group

  def count_mines    
    return Mine.where(created_by: self.id).count
  end

  def count_photos
    return Photo.where(user_id: self.id).count
  end

  def count_updates
    return Mine.where(updated_by: self.id).count
  end

  def last_update_at
    mine = Mine.where(updated_by: self.id).order("updated_at desc").first
    return mine.updated_at if !mine.nil?
    return nil
  end

  def last_mine_at
    mine = Mine.where(created_by: self.id).order("created_at desc").first
    return mine.created_at if !mine.nil?
    return nil
  end

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
