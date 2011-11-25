# A folder is a place where files can be stored.
# Folders can also have sub-folders.
# Via groups it is determined which actions the logged-in User can perform.
class Folder < ActiveRecord::Base

  # Associations
  belongs_to :user
  alias :owner :user
  has_many :myfiles, :dependent => :destroy
  belongs_to :space

  # Accessors
  attr_accessible :name, :space_id, :parent_id

  # Plugins
  acts_as_tree :order => 'name'

  # Validations
  validates_uniqueness_of :name, :scope => 'parent_id', :if => Proc.new { |folder| folder.parent_id }
  validates_presence_of :name

  # List subfolders
  # for the given user in the given order.
  def list_subfolders(logged_in_user, order)
    folders = []
    if self.can_be_read_by(logged_in_user)
      #if logged_in_user.can_read(self.id)
      self.children.order(order).each do |sub_folder|
        folders << sub_folder if sub_folder.can_be_read_by(logged_in_user)#logged_in_user.can_read(sub_folder.id)
      end
    end

    # return the folders:
    return folders
  end

  # List the files
  # for the given user in the given order.
  def list_files(logged_in_user, order)
    files = []
    #    if logged_in_user.can_read(self.id)
    if self.can_be_read_by(logged_in_user)
      files = self.myfiles.order(order).all
    end

    # return the files:
    return files
  end

  # Use this method to determine if a user is permitted to create in the given folder
  def can_be_created_by(user, space)
    user.can_manage? space
  end

  # Use this method to determine if a user is permitted to read in the given folder
  def can_be_read_by(user)
    true
  end

  # Use this method to determine if a user is permitted to update in the given folder
  def can_be_updated_by(user, space)
    user.can_manage? space
  end

  # Use this method to determine if a user is permitted to delete in the given folder
  def can_be_deleted_by(user, space)
    user.can_manage? space
  end

  def is_root
    (self.parent_id == nil)
  end
end
