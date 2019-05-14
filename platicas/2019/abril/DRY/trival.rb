class Record < Application
  def can_edit?(user)
    creator == user && record.created_at > 1.days.ago
  end
end



class Record < Application
  def can_edit?(user)
    belongs_to?(user) && record.created_at > 1.days.ago
  end

  def belongs_to?(user)
    creator == user
  end
end
