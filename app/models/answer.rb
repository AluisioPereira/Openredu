class Answer < Status
  belongs_to :in_response_to, :polymorphic => true

  validates_presence_of :text, :maximum => 800
end
