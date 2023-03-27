class Task < ApplicationRecord
  belongs_to :user
  validates :subj, :descript, :deadline, :user_id, presence: true
  after_initialize :set_defaults

  def complete!
    self.status = true
    save
  end

  def uncomplete!
    self.status = false
    save
  end

  def clear!
    self.hidden = true
    save
  end

  def un_clear!
    self.hidden = false
    save
  end

  private
  def set_defaults
    self.hidden = false if self.new_record?
    self.status = false if self.new_record?
    #self.status = false if self.new_record?
    #self.deadline = Date.today if self.new_record?
  end
end
