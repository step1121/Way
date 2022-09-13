class Task < ApplicationRecord
  belongs_to :vision

  validates :content, length: { minimum: 2, maximum: 30 }, presence: true
  validates :completion_on, presence: true
  validate :date_before_start
  validate :date_before_finish
  
  # 未完了タスクの絞り込み
  scope :yet, -> { where(completion_status: false) }
  # 完了タスクの絞り込み
  scope :complete, -> { where(completion_status: true) }
  
  
  def completion_status_method
    if completion_status == true
      'Conmplete!!'
    else
      'Conmplete??'
    end
  end

  # 完了日が本日以降出ない時のバリデーション
  def date_before_start
    return if completion_on.blank?
    errors.add(:completion_on, "は本日以降を選択してください") if completion_on < Date.today
  end

  # 完了日が達成日以前出ない時のバリデーション
  def date_before_finish
    return if completion_on.blank?
    errors.add(:completion_on, "はWay達成日以前を選択してください") if  completion_on >= vision.finish_on
  end
end
