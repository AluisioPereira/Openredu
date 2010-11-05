class Course < ActiveRecord::Base
  belongs_to :environment
  has_many :spaces, :dependent => :destroy
  has_many :user_course_association, :dependent => :destroy
  has_many :users, :through => :user_course_association

  validates_presence_of :name, :message => "Não pode ficar em branco."

  acts_as_taggable

  # Sobreescrevendo ActiveRecord.find para adicionar capacidade de buscar por path do Space
  def self.find(*args)
    if args.is_a?(Array) and args.first.is_a?(String) and (args.first.index(/[a-zA-Z\-_]+/) or args.first.to_i.eql?(0) )
      find_by_path(args)
    else
      super
    end
  end

  def to_param
    self.path
  end
end
